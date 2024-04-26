package victor

import (
	"context"
	"io"
	"strings"

	"github.com/pkg/errors"
	"github.com/pulumi/pulumi/sdk/v3/go/auto"
	"github.com/pulumi/pulumi/sdk/v3/go/auto/optup"
	"go.uber.org/multierr"
	"go.uber.org/zap"
)

type VictorArgs struct {
	Verbose       bool
	Version       string
	Statefile     string
	Username      *string
	Password      *string
	Passphrase    string
	Context       string
	Server        *string
	Resources     []string
	Configuration []string
	Outputs       *string
}

func Victor(ctx context.Context, args *VictorArgs) error {
	if args == nil {
		args = &VictorArgs{
			Verbose: false,
		}
	}
	logger := Log()

	// Build Victor's client
	client := NewClient(args.Version, args.Verbose, args.Username, args.Password)

	// Create the workspace
	if args.Verbose {
		logger.Info("creating the local workspace")
	}
	ws, err := auto.NewLocalWorkspace(ctx,
		auto.WorkDir(args.Context),
		auto.EnvVars(map[string]string{
			"PULUMI_CONFIG_PASSPHRASE": args.Passphrase,
		}),
	)
	if err != nil {
		return errors.Wrap(err, "creating the local workspace")
	}

	// Install resources
	var merr error
	for _, res := range args.Resources {
		name, version, _ := strings.Cut(res, " ")
		if args.Server == nil {
			multierr.Append(merr, ws.InstallPlugin(ctx, name, version))
			continue
		}
		multierr.Append(merr, ws.InstallPluginFromServer(ctx, name, version, *args.Server))
	}
	if merr != nil {
		return errors.Wrap(merr, "pulumi resources install, failing fast")
	}

	// Get stack
	if args.Verbose {
		logger.Info("getting the stack")
	}
	stack, err := GetStack(ctx, client, ws, args.Statefile, args.Verbose)
	if err != nil {
		return err
	}

	// Set stack configuration
	for _, conf := range args.Configuration {
		k, v, _ := strings.Cut(conf, " ")
		merr = multierr.Append(merr, stack.SetConfig(ctx, k, auto.ConfigValue{
			Value: v,
		}))
	}
	if merr != nil {
		return merr
	}

	// Refresh and update
	upopts := []optup.Option{}
	if args.Verbose {
		logger.Info("refreshing and updating Pulumi stack")
		zw := &ZapWriter{logger: logger}
		upopts = append(upopts, optup.ProgressStreams(zw))
	}
	_, err = stack.Refresh(ctx)
	if err != nil {
		return errors.Wrap(err, "refreshing Pulumi stack")
	}
	res, err := stack.Up(ctx, upopts...)
	if err != nil {
		return errors.Wrap(err, "stack up")
	}

	// Export outputs
	if args.Outputs != nil {
		if err := ExportOutputs(res.Outputs, *args.Outputs); err != nil {
			logger.Error("exporting outputs",
				zap.Error(err),
			)
		}
	}

	// Export stack
	if args.Verbose {
		logger.Info("pushing the stack")
	}
	return PushStack(ctx, client, stack, args.Statefile)
}

type ZapWriter struct {
	logger *zap.Logger
}

var _ io.Writer = (*ZapWriter)(nil)

func (zw *ZapWriter) Write(p []byte) (n int, err error) {
	msg := string(p)
	zw.logger.Info("pulumi output",
		zap.String("msg", msg),
	)
	return len(p), nil
}
