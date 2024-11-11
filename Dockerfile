FROM pulumi/pulumi-go:3.138.0@sha256:8ef29143abfcea8c330d15d1b4c89ad69e8b267cffcded3483263ddb0ef6e141
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
