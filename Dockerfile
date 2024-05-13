FROM pulumi/pulumi-go:3.115.2@sha256:9c1db7776c65fc1a84969a13430b18a5ff4297c8e96418f5e4b1991aa71fde2b
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
