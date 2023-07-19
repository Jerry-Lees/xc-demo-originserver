FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive

#Setup the entrypoint file
COPY mario.sh /safe-ish/mario.sh
COPY www /var/www/html

#Setup permissions.
RUN chmod 777 /safe-ish/mario.sh

#Install needed packages.
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install apt-transport-https ca-certificates 
RUN apt-get -y install openssh-client openssh-server 
#insecure test
RUN apt-get -y install net-tools tcpdump iputils-ping nano curl apt-utils ufw
#lamp Install
RUN apt-get -y install apache2 mysql-server php libapache2-mod-php php-mysql
RUN ufw app info "Apache Full"

#Upgrade packages, fixing missing.
RUN apt-get upgrade -y --fix-missing

EXPOSE 80 443

WORKDIR /root

ENTRYPOINT ["/safe-ish/mario.sh"]