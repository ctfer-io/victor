FROM pulumi/pulumi-go:3.226.0@sha256:de3464fd80932f9f172a6eba6288da4cd536f7d9f632c6f7f7d7f1f0bd9f5148
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
