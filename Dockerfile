FROM pulumi/pulumi-go:3.133.0@sha256:e4a3d653d98e77fca00cf0e02a062165073ee1f72efc9b5c8568a6e963d1193c
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
