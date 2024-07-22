FROM pulumi/pulumi-go:3.125.0@sha256:ce1a0f0234cd253110ab893ed98876ac05f0f55363af12f2e957f6f15f1b7dab
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
