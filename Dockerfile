From ghcr.io/xtls/xray-core:latest AS xray
RUN mkdir -p /tmp/empty

From tobyxdd/hysteria:latest
EXPOSE 8443/udp
EXPOSE 443/tcp
EXPOSE 443/udp
VOLUME /usr/local/etc/xray
VOLUME /var/log/xray
ENV TZ=Asia/Shanghai

COPY --chown=0:0 --chmod=755 start.sh start.sh
COPY --from=xray --chown=0:0 --chmod=755 /usr/local/bin/xray /usr/local/bin/xray
COPY --from=xray --chown=0:0 --chmod=755 /tmp/empty /usr/local/share/xray
COPY --from=xray --chown=0:0 --chmod=644 /usr/local/share/xray/*.dat /usr/local/share/xray/
COPY --from=xray --chown=0:0 --chmod=755 /tmp/empty /usr/local/etc/xray
COPY --from=xray --chown=0:0 --chmod=755 /tmp/empty /var/log/xray
COPY --from=xray --chown=65532:65532 --chmod=600 /var/log/xray/*.log /var/log/xray/

ENTRYPOINT [ "./start.sh" ] 
