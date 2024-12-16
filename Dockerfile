FROM pulumi/pulumi-go:3.143.0@sha256:7533e7fca25e4827aba95f1b6da48ea28609d3d87e5e1b91d30d7779429c28de
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
