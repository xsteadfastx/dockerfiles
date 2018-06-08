FROM busybox

LABEL name=jenkins-data \
      version="0.0.0"

RUN mkdir -p /var/jenkins_home \
  && chown -R default /var/jenkins_home

VOLUME /var/jenkins_home

CMD ["true"]
