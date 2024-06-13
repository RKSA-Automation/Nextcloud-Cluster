FROM haproxy:latest

USER root

RUN mkdir -p /var/ssl/
WORKDIR /var/ssl/

RUN openssl req -nodes -x509 -newkey rsa:2048 -keyout haproxy.key -out haproxy.crt -days 365 -subj "/CN=localhost.com/O=My Local Orgnization/C=US" && \
    cat haproxy.key haproxy.crt > haproxy.pem

RUN echo '#!/bin/bash' > /script.sh && \
	echo 'echo "Updating /etc/hosts file"' >> /script.sh && \
	echo 'cat /hosts.txt >> /etc/hosts' >> /script.sh && \
	echo 'exec /usr/local/bin/docker-entrypoint.sh "$@"' >> /script.sh && \
	chmod +x /script.sh 

ENTRYPOINT ["/script.sh"]

WORKDIR /var/lib/haproxy

CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]

EXPOSE 443 80 8404