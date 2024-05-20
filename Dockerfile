FROM pulumi/pulumi-go:3.116.1@sha256:c1cf69e2a60a3e2ed3b0ee95d4fd5fc69560e37911f00b6691ed03cb623b9499
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
