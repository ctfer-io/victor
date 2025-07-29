package main

import (
	"context"
	"log"
	"net/mail"
	"os"
	"os/signal"
	"syscall"

	"github.com/ctfer-io/victor"
	"github.com/urfave/cli/v3"
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
	app := &cli.Command{
		Name: "Victor",
		Usage: " Victor is always here to assist you through continuous deployment, and especially when updating" +
			"and storing Pulumi stack states in webservers through a GitHub Action workflow or a Drone pipeline.",
		Flags: []cli.Flag{
			cli.VersionFlag,
			cli.HelpFlag,
			&cli.BoolFlag{
				Name:     "verbose",
				Usage:    "Turn on the verbose mode i.e. writes the Pulumi state outputs to stdout.",
				Required: false,
				Sources:  cli.EnvVars("VERBOSE", "PLUGIN_VERBOSE"),
			},
			// Webserver related
			&cli.StringFlag{
				Name:     "statefile",
				Category: catWebserver,
				Usage:    "Where the Pulumi stack state file is supposed to be saved. If it does not currently exist, Victor will create a brand new one.",
				Required: true,
				Sources:  cli.EnvVars("STATEFILE", "PLUGIN_STATEFILE"),
			},
			&cli.StringFlag{
				Name:     "username",
				Category: catWebserver,
				Usage:    "What username to use when getting/pushing the Pulumi stack state file. Don't set for unauthenticated.",
				Required: false,
				Sources:  cli.EnvVars("USERNAME", "PLUGIN_USERNAME"),
			},
			&cli.StringFlag{
				Name:     "password",
				Category: catWebserver,
				Usage:    "What password to use when getting/pushing the Pulumi stack state file. Don't set for unauthenticated.",
				Required: false,
				Sources:  cli.EnvVars("PASSWORD", "PLUGIN_PASSWORD"),
			},
			// Pulumi related
			&cli.StringFlag{
				Name:     "passphrase",
				Category: catPulumi,
				Usage:    "Pulumi stack password, used to decipher and recipher the state.",
				Required: false,
				Sources:  cli.EnvVars("PULUMI_CONFIG_PASSPHRASE", "PLUGIN_PASSPHRASE"),
			},
			&cli.StringFlag{
				Name:     "context",
				Category: catPulumi,
				Usage:    "Where to deploy i.e. the Pulumi entrypoint (the directory pointing to a `main.go` file containing the `pulumi.Run` call).",
				Required: false,
				Value:    ".",
				Sources:  cli.EnvVars("CONTEXT", "PLUGIN_CONTEXT"),
			},
			&cli.StringFlag{
				Name:     "server",
				Category: catPulumi,
				Usage:    "Where to download the Pulumi plugin resources. If set, overrides the online default mode of Pulumi.",
				Required: false,
				Sources:  cli.EnvVars("SERVER", "PLUGIN_SERVER"),
			},
			&cli.StringSliceFlag{
				Name:     "resources",
				Category: catPulumi,
				Usage:    "List of Pulumi plugin resources (<name> <version>) to install before performing the update.",
				Required: false,
				Sources:  cli.EnvVars("RESOURCES", "PLUGIN_RESOURCES"),
			},
			&cli.StringSliceFlag{
				Name:     "configuration",
				Category: catPulumi,
				Usage:    "List of configurations tuples (<key> <value>) to pass to the Pulumi entrypoint. Does not support secrets yet.",
				Required: false,
				Sources:  cli.EnvVars("CONFIGURATION", "PLUGIN_CONFIGURATION"),
			},
			&cli.StringFlag{
				Name:     "outputs",
				Category: catPulumi,
				Usage:    "Where to write the Pulumi stack outputs. If set to \"-\" will write to stdout, else to the given filename.",
				Required: false,
				Sources:  cli.EnvVars("OUTPUTS", "PLUGIN_OUTPUTS"),
			},
		},
		Action: run,
		Authors: []any{
			mail.Address{
				Name:    "Lucas Tesson - PandatiX",
				Address: "lucastesson@protonmail.com",
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

	if err := app.Run(ctx, os.Args); err != nil {
		log.Fatal(err)
	}
}

func run(ctx context.Context, cmd *cli.Command) error {
	// Build SDK arguments
	args := &victor.VictorArgs{
		Verbose:       cmd.Bool("verbose"),
		Version:       version,
		Statefile:     cmd.String("statefile"),
		Username:      ptrCli(cmd, "username"),
		Password:      ptrCli(cmd, "password"),
		Passphrase:    cmd.String("passphrase"),
		Context:       cmd.String("context"),
		Server:        ptrCli(cmd, "server"),
		Resources:     cmd.StringSlice("resources"),
		Configuration: cmd.StringSlice("configuration"),
		Outputs:       ptrCli(cmd, "outputs"),
	}
	return victor.Victor(ctx, args)
}

func ptrCli(cmd *cli.Command, key string) *string {
	v := cmd.String(key)
	if cmd.IsSet(key) {
		return &v
	}
	return nil
}
