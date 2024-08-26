FROM pulumi/pulumi-go:3.130.0@sha256:745341f56f835c2d7aa84f667ef186ce8fa3272f156a98ea21ff466fa4226aa5
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
