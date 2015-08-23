FROM java:8
MAINTAINER Bahaaldine Azarmi <baha@elastic.co>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y supervisor

RUN rm -rf /var/lib/apt/lists/* && \
    wget -q http://mirrors.ircam.fr/pub/apache/kafka/0.8.2.1/kafka_2.10-0.8.2.1.tgz -O /tmp/kafka_2.10-0.8.2.1.tgz && \
    tar xfz /tmp/kafka_2.10-0.8.2.1.tgz -C /opt && \
    rm /tmp/kafka_2.10-0.8.2.1.tgz && \
    mv /opt/kafka_2.10-0.8.2.1 /opt/kafka

ENV KAFKA_HOME /opt/kafka

# Supervisor config
ADD etc/supervisor/conf.d/kafka.conf /etc/supervisor/conf.d/kafka.conf

CMD ["supervisord", "-n"]