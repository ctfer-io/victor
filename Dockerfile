FROM pulumi/pulumi-go:3.210.0@sha256:851a1d8cc7dab41c31830ea3b412ea68af795e8b30f6f31baf5fcae92ab8b440
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
