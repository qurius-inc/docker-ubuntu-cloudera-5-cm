FROM qurius/ubuntu-cloudera-5-base:0.2
MAINTAINER Qurius-inc

RUN apt-get update
RUN apt-get -y --force-yes install cloudera-manager-server-db-2 cloudera-manager-server
RUN apt-get clean

RUN mkdir /var/cm/cloudera-host-monitor
RUN mkdir /var/cm/cloudera-service-monitor

RUN chmod -R 764 /var/cm/cloudera-host-monitor
RUN chmod -R 764 /var/cm/cloudera-service-monitor

COPY scripts/supervisor/cm.conf /etc/supervisor/conf.d/cm.conf

# make cloudera-scm-server-db to run in foreground
RUN sed -i 's#\$SU -c "\$PG_CTL start -D \$DATA_DIR -l \$SERVER_OUT -o \\"\$EXTRA_PG_ARGS\\"" >\/dev\/null#\$SU -c "\/usr\/lib\/postgresql\/9.3\/bin\/postgres -D \$DATA_DIR $EXTRA_PG_ARGS" >\$SERVER_OUT 2>\&1#g' /etc/init.d/cloudera-scm-server-db

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
