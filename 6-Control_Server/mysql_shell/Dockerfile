FROM debian:stable-slim

RUN apt-get update && \
	apt-get install --no-install-recommends -y lsb-release wget gnupg ca-certificates locales

RUN wget https://repo.mysql.com//mysql-apt-config_0.8.29-1_all.deb && \
	echo "4" | dpkg --install mysql-apt-config_0.8.29-1_all.deb && \
	rm -f mysql-apt-config_0.8.29-1_all.deb && \
	apt-get update && \
	apt-get install --no-install-recommends -y mysql-shell && \
	apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Uncomment desired locale to enable it's generation
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen

ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en   
ENV LC_ALL en_US.UTF-8

ADD ./trg_bin /trg_bin
ENV PATH="/trg_bin:${PATH}"

RUN echo '#!/bin/bash' > /trg_bin/script.sh && \
	echo 'echo "Updating /etc/hosts file"' >> /trg_bin/script.sh && \
	echo 'cat /hosts.txt >> /etc/hosts' >> /trg_bin/script.sh && \
	echo 'exec "$@"' >> /trg_bin/script.sh && \
	chmod +x -R /trg_bin

ENTRYPOINT ["/trg_bin/script.sh"]

CMD ["tail","-f","/dev/null"]