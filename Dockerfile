FROM pulumi/pulumi-go:3.153.1@sha256:55f30f43e1f0811381580554a5f92b6c9555d98212e5b230bf937380fd11e22b
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
