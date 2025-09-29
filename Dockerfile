FROM pulumi/pulumi-go:3.198.0@sha256:37ff9d8a99a03f182883a0594f6a1bca733d93675b4c7599a385f94b21213d99
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
