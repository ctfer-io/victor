FROM pulumi/pulumi-go:3.230.0@sha256:88f73b4cb5d88ee17a2c910a3180b4709ea191adb8f000b879819a6c68884d8d
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
