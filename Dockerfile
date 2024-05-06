FROM pulumi/pulumi-go:3.115.1@sha256:ecfa03fd161a99f537a683630318cac974eaab7efcc66390a044b5137d4ef900
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
