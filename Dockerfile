FROM pulumi/pulumi-go:3.190.0@sha256:8e46e5d6b3aeb26537e6a848928eb1fa6c7c67d58476126922909928ece169f0
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
