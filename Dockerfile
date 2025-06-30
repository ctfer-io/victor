FROM pulumi/pulumi-go:3.180.0@sha256:4d496e06ed0e65d35ec8f0c53ba6da7dcb6c735b1d09fbc59e592f440a351638
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
