FROM pulumi/pulumi-go:3.149.0@sha256:19bb0fcf7086c0b5c60fac161cfc882b2ef2421e27380723361876e1be991319
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
