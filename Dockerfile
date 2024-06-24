FROM pulumi/pulumi-go:3.121.0@sha256:19afb209845427908c035d37e698f625fbbf8cee34f9a28a8fcbe579d5131fac
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
