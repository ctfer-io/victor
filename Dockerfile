FROM pulumi/pulumi-go:3.208.0@sha256:fb231854038f590b2558c443e80095ccb6d4fd8bc42b6d1e7f611a75cf0ffd48
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
