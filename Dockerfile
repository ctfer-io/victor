FROM pulumi/pulumi-go:3.260.0@sha256:44eaf05d5cefc764698a00dc873435c354703adb1833a697539df0fd29cdddc5
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
