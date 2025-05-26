FROM pulumi/pulumi-go:3.171.0@sha256:ee926bbd6ac229071e00f760a0c954844c5cffe77202887be415df6df9597d0a
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
