FROM pulumi/pulumi-go:3.134.1@sha256:230b0d79de53099aca709f8d0613f0dc339523ae8df286f4182ca7a43cbb0582
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
