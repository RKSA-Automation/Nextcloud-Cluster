FROM nextcloud:latest

ENV TZ Asia/Manila
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#RUN apt-get update -y && \
#	apt-get install --no-install-recommends smbclient libbz2-dev libsmbclient-dev -y && \
#	pecl install smbclient && \
#	docker-php-ext-install bz2 && \
#   docker-php-ext-enable smbclient

#RUN apt-get install --no-install-recommends -y cron && \
#	crontab -u www-data -r && \
#	echo '* * * * * date > /tmp/cron_status.log' >> /tmp/cron_job.txt && \
#	echo '*/5 * * * * sudo -u www-data php -f /var/www/html/cron.php' >> /tmp/cron_job.txt && \
#	crontab /tmp/cron_job.txt

#RUN sed -i '/memory_consumption/d' /usr/local/etc/php/conf.d/opcache-recommended.ini && \
#	echo 'opcache.memory_consumption=1024' >> /usr/local/etc/php/conf.d/opcache-recommended.ini

RUN echo '#!/bin/bash' > /script.sh && \
#	echo 'echo "Updating /etc/hosts file"' >> /script.sh && \
#	echo 'cat /hosts.txt >> /etc/hosts' >> /script.sh && \
#	echo 'service cron start' >> /script.sh && \
	echo 'exec /entrypoint.sh apache2-foreground "$@"' >> /script.sh && \
	chmod +x /script.sh 

WORKDIR /

ENTRYPOINT ["/script.sh"]

EXPOSE 80