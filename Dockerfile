FROM pulumi/pulumi-go:3.184.0@sha256:5e56ecc65e59082c772b66184f7c928ff20f85aa5e61cd3e92d707874244c4cb
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
