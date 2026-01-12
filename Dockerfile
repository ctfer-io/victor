FROM pulumi/pulumi-go:3.215.0@sha256:207699e363cda5572b1f6e681c7995992699b234e3c753ef5a068080d1a1756c
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
