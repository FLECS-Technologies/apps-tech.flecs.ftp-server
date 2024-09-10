ARG ARCH
ARG VERSION
ARG VARIANT

FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get --yes --no-install-recommends install \
    vsftpd db-util && \
    apt-get --yes clean && \
    rm -rf /var/lib/apt/lists/*
RUN mkdir -p /srv/vsftp/
RUN chown ftp:ftp /srv/vsftp/
RUN mkdir -p /var/run/vsftpd/empty
RUN chmod -w /var/run/vsftpd/empty
ADD docker/fs/ /

ENTRYPOINT [ "/entrypoint.sh" ]