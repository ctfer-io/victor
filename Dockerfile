FROM pulumi/pulumi-go:3.137.0@sha256:f164da7da3c221c91d665fd486a46f9f4fd23a32267612e3e828001dc8261781
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
