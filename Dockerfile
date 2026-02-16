FROM pulumi/pulumi-go:3.220.0@sha256:c4e2a15cce89cf08e5b008950f45e1c06cb67075a630d9eeb8084dd506e5e126
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
