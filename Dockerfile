FROM pulumi/pulumi-go:3.276.0@sha256:5688e5ba569bc316f43965f4c5cac640e016914e244126092774d8b991cdb455
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
