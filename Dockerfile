FROM pulumi/pulumi-go:3.243.0@sha256:596c1cef0ce24930be5f51f069bfc5b651fecc1bbb954e1d62725e0df6cfb1d7
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
