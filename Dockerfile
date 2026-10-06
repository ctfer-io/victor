FROM pulumi/pulumi-go:3.267.0@sha256:2c896c3d58543bcc7b04812d6355492a8f795d6ce6dee2375a11ff3f7673720c
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
