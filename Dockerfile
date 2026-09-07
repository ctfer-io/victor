FROM pulumi/pulumi-go:3.261.0@sha256:2f9366ff81f9ceb52b4df4b868d8ea0725fc168931da60521a9d0ab668cc60bd
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
