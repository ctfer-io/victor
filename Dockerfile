FROM pulumi/pulumi-go:3.122.0@sha256:3652ba20fe2f605474b10de2e8baf4ad805d9e8cf201f015b64830cea6931dd5
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
