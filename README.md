<div align="center">
    <h1>Victor</h1>
    <p><b>Victor is always here to assist you through continuous deployment, and especially<br>when updating and storing Pulumi stack states in webservers through a Drone pipeline.</b><p>
    <a href="https://pkg.go.dev/github.com/ctfer-io/victor"><img src="https://shields.io/badge/-reference-blue?logo=go&style=for-the-badge" alt="reference"></a>
	<a href="https://goreportcard.com/report/github.com/ctfer-io/victor"><img src="https://goreportcard.com/badge/github.com/ctfer-io/victor?style=for-the-badge" alt="go report"></a>
	<a href="https://coveralls.io/github/ctfer-io/victor?branch=main"><img src="https://img.shields.io/coverallsCoverage/github/ctfer-io/victor?style=for-the-badge" alt="Coverage Status"></a>
	<br>
	<a href=""><img src="https://img.shields.io/github/license/ctfer-io/victor?style=for-the-badge" alt="License"></a>
	<a href="https://github.com/ctfer-io/victor/actions?query=workflow%3Aci+"><img src="https://img.shields.io/github/actions/workflow/status/ctfer-io/victor/ci.yaml?style=for-the-badge&label=CI" alt="CI"></a>
	<a href="https://github.com/ctfer-io/victor/actions/workflows/codeql-analysis.yaml"><img src="https://img.shields.io/github/actions/workflow/status/ctfer-io/victor/codeql-analysis.yaml?style=for-the-badge&label=CodeQL" alt="CodeQL"></a>
    <br>
    <a href="https://securityscorecards.dev/viewer/?uri=github.com/ctfer-io/victor"><img src="https://img.shields.io/ossf-scorecard/github.com/ctfer-io/victor?label=openssf%20scorecard&style=for-the-badge" alt="OpenSSF Scoreboard"></a>
</div>

## How to use

You can drop the following into your Drone pipeline (`type: docker`).

```yaml
steps:
  - name: victor
    image: ctfer-io/victor:latest
    settings:
      # Webserver related options
      statefile: https://my-webserver.dev/project.stack.state
      username:
        from_secret: WEBSERVER_USERNAME
      password:
        from_secret: WEBSERVER_PASSWORD
      # Pulumi related options
      passphrase:
        from_secret: PULUMI_CONFIG_PASSPHRASE
      context: ./deploy
      resources:
        - "kubernetes 3.29.1"
        - "random 4.13.2"
      server: https://my-webserver.dev/pulumi
      outputs: outputs.json
    # Specific environment variables that fit your context (e.g. offline)
    environment:
      MY_VAR1: "my_value"
      MY_VAR2:
        from_secret: MY_VAR2
```

## How it works
