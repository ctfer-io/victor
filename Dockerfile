FROM pulumi/pulumi-go:3.204.0@sha256:91b6f1d2abb0f63e64952f1973c8d92234288267c98e92ae2ddbb52e984f5146
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
