FROM pulumi/pulumi-go:3.119.0@sha256:aa6002afc94c08b687e056a2603c6e9742ef3f6d4c1ce82d986e4694af8c7c5c
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
