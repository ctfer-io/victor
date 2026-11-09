FROM pulumi/pulumi-go:3.274.1@sha256:dee00f39d037b7415dc86c0b2bcb4fa3e29004f34133a476b1b57fe1ba7c1669
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
