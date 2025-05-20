FROM pulumi/pulumi-go:3.170.0@sha256:fff81df5490dbff638cc1d78b57d455e2ac9dccc72edc7ca5001004a108a7d4d
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
