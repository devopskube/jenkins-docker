FROM jenkins:2.19.1-alpine

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh $(cat /usr/share/jenkins/plugins.txt | tr '\n' ' ')

#Copy plugins
COPY plugins/*.hpi /usr/share/jenkins/ref/plugins/

COPY config/jenkins.properties /usr/share/jenkins/

# remove executors in master
COPY config/*.groovy /usr/share/jenkins/ref/init.groovy.d/

# lets configure and add default jobs
COPY config/*.xml $JENKINS_HOME/

ENV JAVA_OPTS="-Ddocker.host=unix:/var/run/docker.sock"
