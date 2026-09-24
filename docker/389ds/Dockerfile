FROM ubuntu:26.04

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y 389-ds-base 389-ds-base-libs krb5-user

COPY entrypoint.sh /usr/local/bin/
RUN chmod 555 /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["sh", "-c", "/usr/sbin/ns-slapd -D /etc/dirsrv/slapd-localhost -i /run/dirsrv/slapd-localhost.pid -d 16384"]

