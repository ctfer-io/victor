FROM pulumi/pulumi-go:3.272.0@sha256:59db48f96787060c60a53940bcde7ec87f271b060ef5706fa14e297d0b89b150
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
