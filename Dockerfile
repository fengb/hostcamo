FROM alpine:latest

RUN apk --no-cache add dnsmasq

COPY dist/hosts /etc/dnsmasq.d/hostcamo.hosts
COPY docker-entrypoint.sh /

EXPOSE 53 53/udp
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["dnsmasq", "--no-daemon"]
