FROM pulumi/pulumi-go:3.269.0@sha256:f9d34a84c15ea05d36e15dce65c82fef6c3cd8d0348a5944ae779dc5e141535c
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
