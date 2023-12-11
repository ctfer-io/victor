package victor

import (
	"encoding/base64"
	"fmt"
	"net/http"
)

// Client is the Victor's wrapper around a *http.Client that handles
// authentication and request management.
type Client struct {
	username, password *string
	sub                *http.Client
}

// NewClient is a *Client factory.
func NewClient(username, password *string) *Client {
	return &Client{
		username: username,
		password: password,
		sub:      &http.Client{},
	}
}

func (client *Client) Do(req *http.Request) (*http.Response, error) {
	fmt.Printf("Getting content at %s", req.URL)

	req.Header.Set("User-Agent", fmt.Sprintf("CTFer.io Victor (%s)", Version))
	if client.username != nil && client.password != nil {
		bauth := fmt.Sprintf("%s:%s", *client.username, *client.password)
		bauth = base64.StdEncoding.EncodeToString([]byte(bauth))
		req.Header.Set("Authorization", fmt.Sprintf("Basic %s", bauth))
	}
	return client.sub.Do(req)
}
