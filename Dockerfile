FROM pulumi/pulumi-go:3.224.0@sha256:05e89bb74ae04dff4b5b09e2d9d9ddbd876a11a38a09d2e623ba6ee45d297b4f
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
