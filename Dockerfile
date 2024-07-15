FROM pulumi/pulumi-go:3.124.0@sha256:0212cf5a2fff2170916fa831d266d479f6b82768c161e9f89debba1cf33ab840
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
