FROM pulumi/pulumi-go:3.229.0@sha256:06093e7f416137eb2539d7ca3a3127a01816d3bfa3dbdcfa699a82f0ba8b1ae3
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
