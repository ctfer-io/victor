FROM pulumi/pulumi-go:3.147.0@sha256:70a5e3b5bf65d165d814b8e08feabb8c2f420fe35da97b0f5d7eccdb574dc001
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
