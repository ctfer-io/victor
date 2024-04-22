FROM pulumi/pulumi-go:3.113.3@sha256:bab33ba82c3b8e5e90b53764ce4a3b10de8e2362b7913ce1b692f768035114fe
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
