FROM debian:stable-slim

RUN apt-get update && \
	apt-get install --no-install-recommends -y lsb-release wget gnupg ca-certificates

RUN wget https://repo.mysql.com//mysql-apt-config_0.8.29-1_all.deb && \
	echo "4" | dpkg --install mysql-apt-config_0.8.29-1_all.deb && \
	rm -f mysql-apt-config_0.8.29-1_all.deb && \
	apt-get update && \
	apt-get install --no-install-recommends -y mysql-router && \
	apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD run.sh /run.sh

RUN echo '#!/bin/bash' > /script.sh && \
	echo 'echo "Updating /etc/hosts file"' >> /script.sh && \
	echo 'cat /hosts.txt >> /etc/hosts' >> /script.sh && \
	echo 'exec /run.sh "$@"' >> /script.sh && \
	chmod +x /script.sh 

ENTRYPOINT ["/script.sh"]

CMD ["mysqlrouter"]

# CMD ["tail","-f","/dev/null"]

EXPOSE 6446 6447 6448 6449 8443