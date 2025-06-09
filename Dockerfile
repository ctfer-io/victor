FROM pulumi/pulumi-go:3.175.0@sha256:1e18dac93903d5e107be00ca79d6bc4d0a4db9ebf3583ea673dcb5d221e19172
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
