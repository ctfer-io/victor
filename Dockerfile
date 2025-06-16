FROM pulumi/pulumi-go:3.177.0@sha256:29aeb82789971d0e457198bde33d5869baceafcea6fdcf15a929cd3797a6be68
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
