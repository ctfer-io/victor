FROM pulumi/pulumi-go:3.228.0@sha256:cccfc30904c170ccab63e1e086e69cb0cc598f9180cb0c79deb76961bdc902dd
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
