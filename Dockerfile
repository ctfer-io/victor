FROM pulumi/pulumi-go:3.202.0@sha256:154a358b747d9b7f9a006a816bca2a73f738fefcf76608b311b6723bb77c66f9
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
