FROM pulumi/pulumi-go:3.254.0@sha256:b1ee457d88f407b94a91b2a7ebc71ba37f9aa015fce1597f40dac07b168e49b3
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
