FROM pulumi/pulumi-go:3.141.0@sha256:1ed33c6da24e0753a92f088fa18cd7e1d23b8cbcd45b18b21c9d98daad4042ca
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
