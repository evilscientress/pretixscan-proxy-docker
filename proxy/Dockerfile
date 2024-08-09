ARG JAVA_VERSION=11
FROM azul/zulu-openjdk:${JAVA_VERSION}-jre-headless-latest
ARG PRETIXSCAN_PROXY_VERSION=2.6.2
ARG PRETIXSCAN_PROXY_CHECKSUM=sha256:8d51688094c8d6a44ca85df9d7b70c200c0000f3115f7d9bcf70b8213e6b9f76

# Environment Variables
ENV PRETIXSCAN_PROXY_DATABASE="jdbc:postgresql:scanproxy" \
    PRETIXSCAN_PROXY_BASEURL="https://localhost:8443" \
    PRETIXSCAN_PROXY_ADMINAUTH="admin:admin" \
    PRETIXSCAN_PROXY_AUTO_OFFLINE_MODE="on" \
    XDG_DATA_HOME=/data


RUN useradd -r -u 1000 -d /pretix pretix && \
    mkdir /data && chown 1000 /data && \
    mkdir /pretix && chown 1000 /pretix

COPY --chown=root:root --chmod=0755 entrypoint.sh /usr/bin/entrypoint
ADD --checksum=${PRETIXSCAN_PROXY_CHECKSUM} --chmod=0644 https://marketplace.pretix.eu/download/pretixscan-proxy/${PRETIXSCAN_PROXY_VERSION} /pretix/pretixscan-proxy.jar

VOLUME /data

USER pretix
WORKDIR /pretix
EXPOSE 7000
ENTRYPOINT ["/usr/bin/entrypoint"]
CMD ["proxy"]
