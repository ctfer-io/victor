FROM pulumi/pulumi-go:3.247.0@sha256:515d5e463e55d735d5b4238c59f2c5ac60e4341a0cb7f6f7b801437a5118c93e
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
