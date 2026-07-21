FROM pulumi/pulumi-go:3.253.0@sha256:de592cefd8e96bcfd101e7f891aa50736ca4d1e09a30aa0cef37715d2d42d06f
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
