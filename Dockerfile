FROM pulumi/pulumi-go:3.252.0@sha256:be75c338b55d6f8d22d094cd63299381154b33d9fe309ed90876805f0b6b3318
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
