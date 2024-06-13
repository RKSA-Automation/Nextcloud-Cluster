FROM ldapaccountmanager/lam:latest

RUN echo '#!/bin/bash' > /script.sh && \
	echo 'echo "Updating /etc/hosts file"' >> /script.sh && \
	echo 'cat /hosts.txt >> /etc/hosts' >> /script.sh && \
	echo 'exec /usr/bin/dumb-init "$@"' >> /script.sh && \
	chmod +x /script.sh

ENTRYPOINT ["/script.sh"]
CMD ["/usr/local/bin/start.sh"]
