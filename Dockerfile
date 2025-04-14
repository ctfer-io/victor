FROM pulumi/pulumi-go:3.162.0@sha256:663aa32ffe3bc7bc17c5a8700ce709d7481388725317eff02bff6f5721b8e9a3
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
