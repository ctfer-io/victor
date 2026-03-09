FROM pulumi/pulumi-go:3.225.1@sha256:6a5d6bce087e41c48d74c086357167747343eeaf4ee50f189a8adac2766c6349
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
