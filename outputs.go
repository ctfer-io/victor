package victor

import (
	"encoding/json"
	"fmt"
	"os"

	"github.com/pulumi/pulumi/sdk/v3/go/auto"
	"go.uber.org/zap"
)

// ExportOutputs writes the Pulumi stack outputs to stdout or in a file.
func (args *VictorArgs) Export(outputs auto.OutputMap) error {
	if args.Outputs == nil {
		return nil
	}

	out, _ := json.Marshal(outputs)
	if *args.Outputs == "-" {
		fmt.Printf("%s\n", out)
		return nil
	}

	if args.Verbose {
		Log().Info("writing outputs",
			zap.String("destination", *args.Outputs),
		)
	}
	return os.WriteFile(*args.Outputs, out, 0644)
}
