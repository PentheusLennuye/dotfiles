FROM ubuntu:26.04

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y 389-ds-base 389-ds-base-libs krb5-user

COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["tail", "-f", "/var/log/dirsrv/slapd-service/errors"]

