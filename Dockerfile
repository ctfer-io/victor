FROM pulumi/pulumi-go:3.142.0@sha256:d78dca60063a8a2c154f09136b17aed1db09f494f29fdfb4b6294e116c16b18f
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
