FROM pulumi/pulumi-go:3.227.0@sha256:1887fe3d786a75158475b926f5ed17e2fcd9267995a2d6a22bba9693aa6168bb
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
