ARG ARCH
ARG VERSION
ARG VARIANT

FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get --yes --no-install-recommends install \
    vsftpd db-util ftp-proxy && \
    apt-get --yes clean && \
    rm -rf /var/lib/apt/lists/*
RUN mkdir -p /srv/vsftp/
RUN chown ftp:ftp /srv/vsftp/
RUN mkdir -p /var/run/vsftpd/empty
RUN chmod -w /var/run/vsftpd/empty
RUN touch /var/log/ftp-proxy.log
RUN chmod 666 /var/log/ftp-proxy.log
ADD docker/fs/ /

ENTRYPOINT [ "/entrypoint.sh" ]