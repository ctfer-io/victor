FROM pulumi/pulumi-go:3.118.0@sha256:8e9b3e22a2a9abcf6248fea7b903995ac6726c67bb7254fb09d406af7e4b9518
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
