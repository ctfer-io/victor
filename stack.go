package victor

import (
	"bytes"
	"context"
	"io"
	"net/http"

	"github.com/pkg/errors"
	"github.com/pulumi/pulumi/sdk/v3/go/auto"
	"github.com/pulumi/pulumi/sdk/v3/go/common/apitype"
)

// GetStack fetches the Pulumi stack state file from the provided url,
// and if it does not exist, create a brand new one.
func GetStack(ctx context.Context, cli *Client, ws auto.Workspace, url string, verbose bool) (auto.Stack, error) {
	// TODO extract the stack from the url ? or the workspace ?
	stackName := "victor"
	logger := Log()

	// Get stack
	stack, err := auto.UpsertStack(ctx, stackName, ws)
	if err != nil {
		return auto.Stack{}, errors.Wrapf(err, "while upserting stack %s", stackName)
	}

	// Get state from webserver if exist
	req, _ := http.NewRequestWithContext(ctx, http.MethodGet, url, nil)
	res, err := cli.Do(req)
	if err != nil {
		return auto.Stack{}, errors.Wrapf(err, "while fetching %s", url)
	}
	defer func() {
		_ = res.Body.Close()
	}()

	if res.StatusCode == http.StatusNotFound {
		if verbose {
			logger.Info("stack file not found, starting from a brand new one")
		}
		return stack, nil
	}

	if verbose {
		logger.Info("loading existing stack")
	}

	// Load state
	state, err := io.ReadAll(res.Body)
	if err != nil {
		return auto.Stack{}, errors.Wrapf(err, "while reading file at %s", url)
	}

	udep := apitype.UntypedDeployment{
		Version: 3, // Pulumi v3
	}
	if err := udep.Deployment.UnmarshalJSON(state); err != nil {
		return auto.Stack{}, errors.Wrap(err, "while unmarshalling state")
	}
	if err := stack.Import(ctx, udep); err != nil {
		return auto.Stack{}, errors.Wrap(err, "while importing state")
	}

	return stack, nil
}

// PushStack sends the Pulumi stack state file to the provided url.
func PushStack(ctx context.Context, client *Client, stack auto.Stack, url string) error {
	// Export state
	udep, err := stack.Export(ctx)
	if err != nil {
		return errors.Wrap(err, "while exporting state")
	}
	state, _ := udep.Deployment.MarshalJSON()

	// Send it to the webserver
	req, _ := http.NewRequestWithContext(ctx, http.MethodPut, url, bytes.NewBuffer(state))
	res, err := client.Do(req)
	if err != nil {
		return errors.Wrapf(err, "while sending state to %s", url)
	}
	defer func() {
		_ = res.Body.Close()
	}()

	return nil
}
