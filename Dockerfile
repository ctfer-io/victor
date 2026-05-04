FROM pulumi/pulumi-go:3.234.0@sha256:1760af75952305cc2a3d48220ba9c1b5f1ea8b06d404c35160269e2ed04d01dd
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
