FROM pulumi/pulumi-go:3.145.0@sha256:b4b0c0f0760e67eba7d045c007f730e8845cf0da998c08bd68472a614698c6a2
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
