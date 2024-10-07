FROM pulumi/pulumi-go:3.135.1@sha256:7e95ca7059754b4bba99ec2730e19b5538f7771c43796a77aa50b1be85ebe27d
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
