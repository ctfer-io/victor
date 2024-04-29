FROM pulumi/pulumi-go:3.114.0@sha256:320f41cf91eac598bc34f5965dc8cee60d423005c82d8c8b4399478eceb0b659
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
