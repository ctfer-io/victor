FROM pulumi/pulumi-go:3.217.0@sha256:155e94acfa4ba0e6328303a59ff49aa7a530164b9b7eb9e7598c5d1fcf083a07
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
