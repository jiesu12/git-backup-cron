FROM jiesu/cron-arm

RUN apk --no-cache add git openssh curl

VOLUME /volume

COPY gitconfig /home/jie/.gitconfig
RUN chown jie:jie /home/jie/.gitconfig

COPY job.sh init.sh /
RUN chmod +x /job.sh /init.sh

