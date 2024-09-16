FROM pulumi/pulumi-go:3.132.0@sha256:31bc0ca3b1d90f04d680a3fdf66ee151c8983bdd29a7c91be8f48f3d5425d31d
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
