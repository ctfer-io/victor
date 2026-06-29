FROM pulumi/pulumi-go:3.248.0@sha256:721bfa7fbdfddf644771bd2291e46accdeba8fac5d6859a7d43030ffd34ee0d4
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
