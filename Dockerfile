FROM pulumi/pulumi-go:3.231.0@sha256:d51f4e5f0879e14a35ae1e0690fad17a15872480640c2d15bdf582bdbe221d97
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
