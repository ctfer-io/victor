package main

import (
	"context"
	"fmt"
	"log"
	"os"
	"os/signal"
	"strings"
	"syscall"

	"github.com/ctfer-io/victor"
	"github.com/pkg/errors"
	"github.com/pulumi/pulumi/sdk/v3/go/auto"
	"github.com/pulumi/pulumi/sdk/v3/go/auto/optup"
	"github.com/urfave/cli/v2"
)

const (
	catWebserver = "webserver"
	catPulumi    = "pulumi"
)

var (
	version = "dev"
	commit  = ""
	date    = ""
	builtBy = ""
)

func main() {
	app := &cli.App{
		Name:  "Victor",
		Usage: "Continuous Deployment for Pulumi in Drone pileline, with external state management deffered to a webserver.",
		Flags: []cli.Flag{
			cli.VersionFlag,
			cli.HelpFlag,
			&cli.BoolFlag{
				Name: "verbose",
			},
			// Webserver related
			&cli.StringFlag{
				Name:     "statefile",
				Category: catWebserver,
				Usage:    "Where the Pulumi stack state file is supposed to be saved. If it does not currently exist, Victor will create a brand new one.",
				Required: true,
				EnvVars:  []string{"PLUGIN_STATEFILE"},
			},
			&cli.StringFlag{
				Name:     "username",
				Category: catWebserver,
				Usage:    "What username to use when getting/pushing the Pulumi stack state file. Don't set for unauthenticated.",
				Required: false,
				EnvVars:  []string{"PLUGIN_USERNAME"},
			},
			&cli.StringFlag{
				Name:     "password",
				Category: catWebserver,
				Usage:    "What password to use when getting/pushing the Pulumi stack state file. Don't set for unauthenticated.",
				Required: false,
				EnvVars:  []string{"PLUGIN_PASSWORD"},
			},
			// Pulumi related
			&cli.StringFlag{
				Name:     "passphrase",
				Category: catPulumi,
				Usage:    "Pulumi stack password, used to decipher and recipher the state.",
				Required: false,
				EnvVars:  []string{"PULUMI_CONFIG_PASSPHRASE", "PLUGIN_PASSPHRASE"},
			},
			&cli.StringFlag{
				Name:     "context",
				Category: catPulumi,
				Usage:    "Where to deploy i.e. the Pulumi entrypoint (the directory pointing to a `main.go` file containing the `pulumi.Run` call).",
				Required: false,
				Value:    ".",
				EnvVars:  []string{"PLUGIN_CONTEXT"},
			},
			&cli.StringFlag{
				Name:     "server",
				Category: catPulumi,
				Usage:    "Where to download the Pulumi plugin resources. If set, overrides the online default mode of Pulumi.",
				Required: false,
				EnvVars:  []string{"PLUGIN_SERVER"},
			},
			&cli.StringSliceFlag{
				Name:     "resources",
				Category: catPulumi,
				Usage:    "List of Pulumi plugin resources (<name> <version>) to install before performing the update.",
				Required: false,
				EnvVars:  []string{"PLUGIN_RESOURCES"},
			},
			&cli.StringFlag{
				Name:     "outputs",
				Category: catPulumi,
				Usage:    "Where to write the Pulumi stack outputs. If set to \"-\" will write to stdout, else to the given filename.",
				Required: false,
				EnvVars:  []string{"PLUGIN_OUTPUTS"},
			},
		},
		Action: run,
		Authors: []*cli.Author{
			{
				Name:  "Lucas Tesson - PandatiX",
				Email: "lucastesson@protonmail.com",
			},
		},
		Version: version,
		Metadata: map[string]any{
			"version": version,
			"commit":  commit,
			"date":    date,
			"builtBy": builtBy,
		},
	}

	// Create context that listens for the interrupt signal from the OS.
	ctx, stop := signal.NotifyContext(context.Background(), syscall.SIGINT, syscall.SIGTERM)
	defer stop()

	if err := app.RunContext(ctx, os.Args); err != nil {
		log.Fatal(err)
	}
}

func run(ctx *cli.Context) error {
	// Populate globals
	victor.Version = version
	victor.Verbose = ctx.Bool("verbose")

	// Build Victor's client
	var username, password *string
	if ctx.IsSet("username") {
		username = ptr(ctx.String("username"))
	}
	if ctx.IsSet("password") {
		password = ptr(ctx.String("password"))
	}
	client := victor.NewClient(username, password)

	// Create the workspace
	if victor.Verbose {
		fmt.Println("Creating the local workspace")
	}
	statefile := ctx.String("statefile")
	ws, err := auto.NewLocalWorkspace(ctx.Context,
		auto.WorkDir(ctx.String("context")),
		auto.EnvVars(map[string]string{
			"PULUMI_CONFIG_PASSPHRASE": ctx.String("passphrase"),
		}),
	)
	if err != nil {
		return errors.Wrap(err, "while creating the local workspace")
	}

	// Install resources
	server := ctx.String("server")
	resources := ctx.StringSlice("resources")
	failed := false
	for _, res := range resources {
		name, version, _ := strings.Cut(res, " ")
		if err := ws.InstallPluginFromServer(ctx.Context, name, version, server); err != nil {
			fmt.Fprintf(os.Stderr, "an error occurred while installing resource %s from %s: %s", res, server, err)
			failed = true
		}
	}
	if failed {
		return errors.New("one or more errors happened during resources install, failing fast.")
	}

	// Get stack
	if victor.Verbose {
		fmt.Println("Getting the stack")
	}
	stack, err := victor.GetStack(ctx.Context, client, ws, statefile)
	if err != nil {
		return err
	}

	// Refresh and update
	upopts := []optup.Option{}
	if victor.Verbose {
		fmt.Println("Refreshing and updating Pulumi stack")
		upopts = append(upopts, optup.ProgressStreams(os.Stdout))
	}
	_, err = stack.Refresh(ctx.Context)
	if err != nil {
		return errors.Wrap(err, "while refreshing Pulumi stack")
	}
	res, err := stack.Up(ctx.Context, upopts...)
	if err != nil {
		return errors.Wrap(err, "while stack up")
	}

	// Export outputs
	if ctx.IsSet("outputs") {
		if err := victor.ExportOutputs(res.Outputs, ctx.String("outputs")); err != nil {
			fmt.Fprintf(os.Stderr, "while exporting outputs, got: %s", err)
		}
	}

	// Export stack
	if victor.Verbose {
		fmt.Println("Pushing the stack")
	}
	if err := victor.PushStack(ctx.Context, client, stack, statefile); err != nil {
		return err
	}

	return nil
}

func ptr[T any](t T) *T {
	return &t
}
