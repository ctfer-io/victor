FROM pulumi/pulumi-go:3.156.0@sha256:f0ffdaab1a7c3a3de50c55eef7b5e6516b279848682c7e145e981cd992bd9385
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
