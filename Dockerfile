FROM pulumi/pulumi-go:3.196.0@sha256:6bccf6584dca732f483cd6cba3f4ed4ed97bdc080015e33ac00dbbf7366b0820
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
