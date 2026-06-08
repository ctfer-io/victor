FROM pulumi/pulumi-go:3.245.0@sha256:2838623f96744f7ca084dcfe575bb724dee1de69a7a9fa9f47aed060a2b6d8b5
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
