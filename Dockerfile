FROM pulumi/pulumi-go:3.160.0@sha256:0bbd434b71f532cb0b24f5acd679f40193baff2f900d90d94354b9fafe25696c
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
