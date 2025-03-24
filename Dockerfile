FROM pulumi/pulumi-go:3.157.0@sha256:be5f3661843febfa3100f41a73ce1f11986910c0b14b197cd9b65ad7a3ad5eca
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
