FROM pulumi/pulumi-go:3.216.0@sha256:732de57bc2bde08561ef98921995ba0746629e69fc5ebf83341ff3efa529a64f
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
