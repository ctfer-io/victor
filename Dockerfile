FROM pulumi/pulumi-go:3.273.0@sha256:99ed8bb8b24722d1e41ab792348e4bdce7c52e3a86ebd549e310152cdc9f8e54
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
