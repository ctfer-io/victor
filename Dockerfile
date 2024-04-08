FROM pulumi/pulumi-go:3.112.0@sha256:2ec6c3066c0ae32254c696e41d82e747a9332fe60f388bc79cb4f8661a4d91e9
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
