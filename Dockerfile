FROM pulumi/pulumi-go:3.150.0@sha256:5b4b943cf22c66fddeb73bb65fc71ac5b0e59ab7dd39861a4fe1a807db374b22
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
