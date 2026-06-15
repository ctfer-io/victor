FROM pulumi/pulumi-go:3.246.0@sha256:e32c64d93aece6f039efeab3600c617bd44ef03ab3149db75495d5c7cf9c184a
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
