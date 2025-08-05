package victor

import (
	"encoding/base64"
	"fmt"
	"net/http"

	"go.uber.org/zap"
)

// Client is the Victor's wrapper around a *http.Client that handles
// authentication and request management.
type Client struct {
	version string
	verbose bool

	username, password *string
	sub                *http.Client
}

// NewClient is a *Client factory.
func NewClient(version string, verbose bool, username, password *string) *Client {
	return &Client{
		version:  version,
		verbose:  verbose,
		username: username,
		password: password,
		sub:      &http.Client{},
	}
}

func (client *Client) Do(req *http.Request) (*http.Response, error) {
	if client.verbose {
		Log().Info("getting distant content",
			zap.String("location", req.URL.String()),
		)
	}

	req.Header.Set("User-Agent", client.UserAgent())
	if client.username != nil && client.password != nil {
		bauth := fmt.Sprintf("%s:%s", *client.username, *client.password)
		bauth = base64.StdEncoding.EncodeToString([]byte(bauth))
		req.Header.Set("Authorization", fmt.Sprintf("Basic %s", bauth))
	}
	return client.sub.Do(req)
}

func (client *Client) UserAgent() string {
	return fmt.Sprintf("CTFer.io Victor (%s)", client.version)
}
