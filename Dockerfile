FROM scratch
COPY victor /victor
ENTRYPOINT [ "/victor" ]
