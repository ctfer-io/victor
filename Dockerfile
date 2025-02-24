FROM pulumi/pulumi-go:3.152.0@sha256:0fda555b528fd8dc846112f9f6380aaa3ec63a54e3a476a8a5888c2db28ccfa9
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
