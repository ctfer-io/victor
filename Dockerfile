FROM pulumi/pulumi-go:3.255.0@sha256:deaa6abf41ad2b18968e12efbff444164ef211bf228130f893be0b2e5de7ae33
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
