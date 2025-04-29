FROM pulumi/pulumi-go:3.165.0@sha256:f54db623d4e7463577fd9ffa64b60f590dcf8757ffe5a52f3a945363fc7c3202
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
