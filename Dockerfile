FROM pulumi/pulumi-go:3.232.0@sha256:a7c5e649a3d89974a495bdcf39eba03226036f16bc32c81c29fdc6e153002850
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
