FROM pulumi/pulumi-go:3.206.0@sha256:9621dc4059d5790be06a5c0182c193ff3e3e242e45fd32bdbf44b19e8fc565da
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
