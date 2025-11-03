FROM pulumi/pulumi-go:3.205.0@sha256:b5fce5f6f186320c2e1f5a63259defe0adaa9a9e06c14c19b9fe6b99d8c5606d
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
