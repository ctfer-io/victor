FROM pulumi/pulumi-go:3.212.0@sha256:891a74b5b246c782cb75d082957eb5fd1b2699b0d408d9516c90375c93f47d5a
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
