FROM pulumi/pulumi-go:3.257.0@sha256:3fbcf47879f783540e790bb75b636d7b6dd7a103b4f84f693747307753b378f4
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
