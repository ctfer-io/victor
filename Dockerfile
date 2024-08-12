FROM pulumi/pulumi-go:3.128.0@sha256:d6f23d9797e10c9c23986a47df9287097da86111ef1a7bbe03844d553eb2a666
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
