FROM qurius/ubuntu-cloudera-5-base
MAINTAINER Qurius-inc

RUN apt-get -y --force-yes install cloudera-manager-server-db-2 cloudera-manager-server

RUN mkdir /var/cm/cloudera-host-monitor
RUN mkdir /var/cm/cloudera-service-monitor

RUN chmod -R 764 /var/cm/cloudera-host-monitor
RUN chmod -R 764 /var/cm/cloudera-service-monitor

ADD scripts/start-cm.sh /root/start-cm.sh
RUN chmod +x /root/start-cm.sh

CMD /root/start-cm.sh
