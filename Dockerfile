FROM pulumi/pulumi-go:3.178.0@sha256:08300d4e64d6d296e9e822acf022d0900505d02f58bb9cc70efdde914df49d51
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
