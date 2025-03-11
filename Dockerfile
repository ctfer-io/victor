FROM pulumi/pulumi-go:3.154.0@sha256:f9416bd4a47ad7941ef3431398a3f84486a2254d22da6cc61a8ad72213234dcc
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
