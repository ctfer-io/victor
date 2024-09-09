FROM pulumi/pulumi-go:3.131.0@sha256:e74002eb5a9cc94e1143bb0e1dee6c4d70d15ed26be6b79d9c8b74f368260a18
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
