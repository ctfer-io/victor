FROM pulumi/pulumi-go:3.96.2
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
