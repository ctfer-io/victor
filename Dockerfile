FROM pulumi/pulumi-go:3.117.0@sha256:38d60e70380139de0b52770f5bfb6c0ac34d40be6cc240d30f26011175b6621d
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
