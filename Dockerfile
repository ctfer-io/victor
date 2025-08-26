FROM pulumi/pulumi-go:3.191.0@sha256:c1ce0082cd4dd518585c9696e4d753d705be8261afef699433dac2cd6ff46f45
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
