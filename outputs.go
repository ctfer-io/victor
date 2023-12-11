package victor

import (
	"encoding/json"
	"fmt"
	"os"

	"github.com/pulumi/pulumi/sdk/v3/go/auto"
)

// ExportOutputs writes the Pulumi stack outputs to stdout or in a file.
func ExportOutputs(outputs auto.OutputMap, dst string) error {
	out, _ := json.Marshal(outputs)
	if dst == "-" {
		fmt.Printf("%s\n", out)
		return nil
	}

	fmt.Printf("Writing outputs to %s", dst)
	return os.WriteFile(dst, out, 0644)
}
