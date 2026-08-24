FROM pulumi/pulumi-go:3.259.0@sha256:040f9e9f1cec843bba3b4488253bfdb4414f7429c2000d80d7073ebaf59a2b41
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
