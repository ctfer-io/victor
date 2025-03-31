FROM pulumi/pulumi-go:3.159.0@sha256:2c27ecc7d6ce37dfa7b55c6ef192261e9bf727b07a75e7136fa7330f94799bbf
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
