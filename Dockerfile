FROM pulumi/pulumi-go:3.268.0@sha256:225c2d1e12cb12bbba9bdfe2ee512a1466fdf793e16e07c694b2fd7aeb9342d6
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
