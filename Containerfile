ARG FREEBSD_RELEASE

FROM ghcr.io/appjail-makejails/core:${FREEBSD_RELEASE}

ARG NO_PKGCLEAN

LABEL org.opencontainers.image.title="Adguard Home" \
    org.opencontainers.image.description="Network-wide ads & trackers blocking DNS server" \
    org.opencontainers.image.source="https://github.com/AppJail-makejails/adguardhome" \
    org.opencontainers.image.url="https://github.com/AppJail-makejails/adguardhome" \
    org.opencontainers.image.vendor="DtxdF" \
    org.opencontainers.image.authors="Jesús Daniel Colmenares Oviedo <dtxdf@disroot.org>"

RUN set -xe; \
    \
    pkg update; \
    pkg install -U adguardhome; \
    \
    if [ -z "${NO_PKGCLEAN}" ]; then \
        pkg clean -a; \
        rm -rf /var/cache/pkg/*; \
    fi; \
    rm -rf /var/db/pkg/repos/*

EXPOSE 53/tcp 53/udp \
	67/udp \
	68/udp \
	80/tcp \
	443/tcp 443/udp \
	853/tcp 853/udp \
	3000/tcp 3000/udp \
	5443/tcp 5443/udp \
	6060/tcp

WORKDIR /adguardhome/work

RUN set -xe; \
    \
    mkdir -p /adguardhome /adguardhome/work /adguardhome/conf; \
    \
    chmod 0700 /adguardhome/work

ENTRYPOINT ["adguardhome"]

CMD [ \
	"--no-check-update", \
	"-c", "/adguardhome/conf/AdGuardHome.yaml", \
	"-w", "/adguardhome/work" \
]
