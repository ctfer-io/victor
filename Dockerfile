FROM pulumi/pulumi-go:3.96.2
COPY victor /victor
ENTRYPOINT [ "/victor" ]
