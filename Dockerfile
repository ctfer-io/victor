FROM pulumi/pulumi-go:3.111.1@sha256:6d506fa398b819dd0186d4cf3f59c3383988505f773ec369af41bf8952e08830
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
