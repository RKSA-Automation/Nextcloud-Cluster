FROM mysql:8.0

ADD ./my.conf  /etc/mysql/my.cnf
RUN chmod 644 /etc/mysql/my.cnf

WORKDIR /

RUN echo '#!/bin/bash' > /script.sh && \
	echo 'set -e' >> /script.sh && \
#	echo 'echo "Updating /etc/hosts file"' >> /script.sh && \
#	echo 'cat /hosts.txt >> /etc/hosts' >> /script.sh && \
	echo 'echo "Setting server_id to $SERVER_ID"' >> /script.sh && \
	echo 'sed -i "s/server_id=1/server_id=$SERVER_ID/" /etc/mysql/my.cnf' >> /script.sh && \
	echo 'exec /entrypoint.sh "$@"' >> /script.sh && \
	chmod +x /script.sh 
	
ENTRYPOINT ["/script.sh"]

CMD ["mysqld","--defaults-file=/etc/mysql/my.cnf"]

EXPOSE 3301
