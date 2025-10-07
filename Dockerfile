FROM pulumi/pulumi-go:3.200.0@sha256:eadac766236f9e28290a52655ed7308fcf601291e2548f87ad03d0dfaee08498
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
