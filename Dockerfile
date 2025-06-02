FROM pulumi/pulumi-go:3.173.0@sha256:c5daaaa6de5c716cd0954fcaf36e7d10c8934ec307e759ce8c33587bb63383c1
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
