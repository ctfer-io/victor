FROM pulumi/pulumi-go:3.214.1@sha256:ccf6b3fd8b92692b47408a1e5300a8efb30b503e00ea3e10cc25bbb838044c9b
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
