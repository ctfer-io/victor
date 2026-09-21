FROM pulumi/pulumi-go:3.263.0@sha256:3332fec35111e07c81dae4f6e53aaaf5e68bb25b2561505f921620a708b80123
COPY victor /victor
RUN pulumi login --local
ENTRYPOINT [ "/victor" ]
