FROM pulumi/pulumi-go:3.144.1@sha256:475a42e413d60b34110d47b71c6b67708eea6e92312a7884f041f722d7c0393c
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
