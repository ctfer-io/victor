FROM pulumi/pulumi-go:3.197.0@sha256:bdd27c5aff14417957c26bcafdece2a9105d481104c6fbb83f1c9ddceb31ac4d
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
