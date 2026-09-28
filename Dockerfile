FROM pulumi/pulumi-go:3.264.0@sha256:0123173123b7d84514fa1541c058342a0622bb39794422d167c88f0e6cc2411b
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
