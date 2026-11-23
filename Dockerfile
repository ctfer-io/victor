FROM pulumi/pulumi-go:3.277.0@sha256:5be1faa7369daf82010e1701d7b5d158ccd875271eb12fc0b8909ae88305fc33
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
