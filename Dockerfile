FROM pulumi/pulumi-go:3.237.0@sha256:d5bbc516cf6df7078a8ffe7e593bfccb6cb02ea4049738e3934587dd9ae9f1dc
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
