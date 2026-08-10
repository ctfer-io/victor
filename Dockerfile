FROM pulumi/pulumi-go:3.256.0@sha256:606cdf3e816dcb06933142a54958406aa82eeb06cb69312cbe2bef0d7fd520bb
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
