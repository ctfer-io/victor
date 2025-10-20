FROM pulumi/pulumi-go:3.203.0@sha256:b1c613a18a7189b1905dead531150e3e6fa601333608aef7fdc6e489e0112c98
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
