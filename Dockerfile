FROM pulumi/pulumi-go:3.250.0@sha256:40d9f1c901eeda8819371df56e0011b05a19563b87abb25b2549377d206d9290
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
