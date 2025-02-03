FROM pulumi/pulumi-go:3.148.0@sha256:388c0fc83829abd14b2cd4107a8ab510d2e0ba9fff5e686ff7b4ba4d03a5da70
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
