FROM pulumi/pulumi-go:3.219.0@sha256:4f58b37b1168ed4150b7d14b927bda98148de0d87703a27afef100511d45c271
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
