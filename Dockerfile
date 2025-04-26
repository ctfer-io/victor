FROM pulumi/pulumi-go:3.163.0@sha256:673d978ff473db3ab1ac3f3a95235b5a9058c2a6f7f1fa140edf2f7723782706
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
