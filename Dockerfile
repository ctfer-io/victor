FROM pulumi/pulumi-go:3.188.0@sha256:1d6b24586475ca7e787736072dd3f691a8dc02deeae6c3bb745a8a022d731b85
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
