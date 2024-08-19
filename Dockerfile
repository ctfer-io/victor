FROM pulumi/pulumi-go:3.129.0@sha256:9652c38d257efe5d0de1b2843677bc1894924636473c119d20e2e64082a8b5cd
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
