FROM pulumi/pulumi-go:3.167.0@sha256:022e2066910fedefe24b55bf72dc7ce2eb5e292c4dea7a56080220ee5eea1ecf
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
