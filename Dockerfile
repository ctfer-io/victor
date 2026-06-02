FROM pulumi/pulumi-go:3.244.0@sha256:988a28e77131c146ad641549e507a9f6ba2391e422fcd93191fb5c3292175c30
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
