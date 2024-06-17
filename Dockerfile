FROM pulumi/pulumi-go:3.120.0@sha256:b783ae9cbcac6e0d16404e6f7d22a70cc88cc9c26786004130aedb5788632735
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
