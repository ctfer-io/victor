FROM pulumi/pulumi-go:3.262.0@sha256:94e9a5b229dd59bae09fdb216ccf5cbe3ffc4a36617cfe42b262115669791512
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
