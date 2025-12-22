FROM pulumi/pulumi-go:3.213.0@sha256:255fc1ac2e01843800da22947517dcacac401635d631c4a7fd5200700c0cd2aa
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
