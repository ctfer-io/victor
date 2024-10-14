FROM pulumi/pulumi-go:3.136.1@sha256:8971a3e15eebb161e5d5c5d1395ac671f1ee11c5adfacc10f5b48e222708e20a
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
