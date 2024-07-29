FROM pulumi/pulumi-go:3.127.0@sha256:54c4d73834c1a6f9bf291ca6ebd25988086d496c6282c6e701fe809ce094d3d4
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
