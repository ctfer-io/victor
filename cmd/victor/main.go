package main

import (
	"context"
	"log"
	"os"
	"os/signal"
	"syscall"

	"github.com/ctfer-io/victor"
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
				Name:     "verbose",
				Usage:    "Turn on the verbose mode i.e. writes the Pulumi state outputs to stdout.",
				Required: false,
				EnvVars:  []string{"VERBOSE", "PLUGIN_VERBOSE"},
			},
			// Webserver related
			&cli.StringFlag{
				Name:     "statefile",
				Category: catWebserver,
				Usage:    "Where the Pulumi stack state file is supposed to be saved. If it does not currently exist, Victor will create a brand new one.",
				Required: true,
				EnvVars:  []string{"STATEFILE", "PLUGIN_STATEFILE"},
			},
			&cli.StringFlag{
				Name:     "username",
				Category: catWebserver,
				Usage:    "What username to use when getting/pushing the Pulumi stack state file. Don't set for unauthenticated.",
				Required: false,
				EnvVars:  []string{"USERNAME", "PLUGIN_USERNAME"},
			},
			&cli.StringFlag{
				Name:     "password",
				Category: catWebserver,
				Usage:    "What password to use when getting/pushing the Pulumi stack state file. Don't set for unauthenticated.",
				Required: false,
				EnvVars:  []string{"PASSWORD", "PLUGIN_PASSWORD"},
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
				EnvVars:  []string{"CONTEXT", "PLUGIN_CONTEXT"},
			},
			&cli.StringFlag{
				Name:     "server",
				Category: catPulumi,
				Usage:    "Where to download the Pulumi plugin resources. If set, overrides the online default mode of Pulumi.",
				Required: false,
				EnvVars:  []string{"SERVER", "PLUGIN_SERVER"},
			},
			&cli.StringSliceFlag{
				Name:     "resources",
				Category: catPulumi,
				Usage:    "List of Pulumi plugin resources (<name> <version>) to install before performing the update.",
				Required: false,
				EnvVars:  []string{"RESOURCES", "PLUGIN_RESOURCES"},
			},
			&cli.StringSliceFlag{
				Name:     "configuration",
				Category: catPulumi,
				Usage:    "List of configurations tuples (<key> <value>) to pass to the Pulumi entrypoint. Does not support secrets yet.",
				Required: false,
				EnvVars:  []string{"CONFIGURATION", "PLUGIN_CONFIGURATION"},
			},
			&cli.StringFlag{
				Name:     "outputs",
				Category: catPulumi,
				Usage:    "Where to write the Pulumi stack outputs. If set to \"-\" will write to stdout, else to the given filename.",
				Required: false,
				EnvVars:  []string{"OUTPUTS", "PLUGIN_OUTPUTS"},
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
	// Build SDK arguments
	args := &victor.VictorArgs{
		Verbose:       ctx.Bool("verbose"),
		Version:       version,
		Statefile:     ctx.String("statefile"),
		Username:      ptrCli(ctx, "username"),
		Password:      ptrCli(ctx, "password"),
		Passphrase:    ctx.String("passphrase"),
		Context:       ctx.String("context"),
		Server:        ptrCli(ctx, "server"),
		Resources:     ctx.StringSlice("resources"),
		Configuration: ctx.StringSlice("configuration"),
		Outputs:       ptrCli(ctx, "outputs"),
	}
	return victor.Victor(ctx.Context, args)
}

func ptrCli(ctx *cli.Context, key string) *string {
	v := ctx.String(key)
	if ctx.IsSet(key) {
		return &v
	}
	return nil
}
