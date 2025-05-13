FROM pulumi/pulumi-go:3.169.0@sha256:d263f8d71819b9fbe2810ac917ff69e62bceb391608a727da9d0ffa9b1388343
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
