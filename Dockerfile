FROM alpine

COPY ./bin/start-nfs /start-nfs

RUN set -xe \
  && apk add --no-cache --no-progress nfs-utils \
  && mkdir -p /var/lib/nfs/v4recovery \
  && chmod u+x /start-nfs

ENV EXPORT_SETTINGS rw,fsid=0,sync,no_subtree_check,no_auth_nlm,insecure,no_root_squash,crossmnt,no_acl
ENV EXPORT_TO *
EXPOSE 111/tcp 111/udp 2049/tcp 2049/udp
VOLUME /nfs-share
WORKDIR /nfs-share

CMD ["/start-nfs"]
