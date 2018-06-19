FROM kylemanna/openvpn:latest

RUN apk --no-cache add dnsmasq

COPY docker-entrypoint.sh /
COPY dist/hosts /etc/dnsmasq.d/hostcamo.hosts

EXPOSE 53 53/udp
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["dnsmasq", "--no-daemon"]
