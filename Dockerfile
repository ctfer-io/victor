FROM pulumi/pulumi-go:3.193.0@sha256:73304aba1d4d5ba81684da67324d72ec40758a92fd83e9a8f5920ae259e96c56
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
