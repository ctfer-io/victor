FROM pulumi/pulumi-go:3.218.0@sha256:2916c43e9a3f30711a75bac29f28a71ee284294c5be0989849ed21c914a72d7a
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
