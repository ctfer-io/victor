FROM pulumi/pulumi-go:3.192.0@sha256:11b274b66facf382736fdce3c0947ae675d4b8c00fb2014a4bcc9ca4cb9283ca
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
