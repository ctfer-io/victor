FROM pulumi/pulumi-go:3.223.0@sha256:e93b80d1a9736ee33a7090545e8f1ea612617c81d87953963758c8be1c200aed
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
