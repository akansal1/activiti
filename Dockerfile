#
# Tomcat Alpine with activiti Dockerfile
#
### 
FROM tomcat:8.5.9-jre8-alpine
MAINTAINER Kent Johnson "kentoj@gmail.com"

EXPOSE 8080

ENV TOMCAT_HOME=/usr/local/tomcat
ENV ACTIVITI_VERSION 6.0.0.Beta4
ENV POSTGRESQL_JDBC_DRIVER_VERSION 9.4.1212
ENV ACTIVITI_URL=https://github.com/Activiti/Activiti/releases/download/activiti
ENV POSTGRESQL_URL=https://jdbc.postgresql.org/download/postgresql
ENV ACTIVITI_WORKDIR=/opt/activiti


# To install jar files first we need to deploy war files manually
RUN apk update && \
	apk add ca-certificates && \
	update-ca-certificates && \
	apk add openssl && \
	mkdir -p ${ACTIVITI_WORKDIR}


RUN	wget ${ACTIVITI_URL}-${ACTIVITI_VERSION}/activiti-${ACTIVITI_VERSION}.zip -O /tmp/activiti.zip

RUN unzip /tmp/activiti.zip -d ${ACTIVITI_WORKDIR} && \
    mkdir ${TOMCAT_HOME}/webapps/activiti-app && \
    mkdir ${TOMCAT_HOME}/webapps/activiti-rest && \
	unzip ${ACTIVITI_WORKDIR}/activiti-${ACTIVITI_VERSION}/wars/activiti-app.war -d  ${TOMCAT_HOME}/webapps/activiti-app && \
	unzip ${ACTIVITI_WORKDIR}/activiti-${ACTIVITI_VERSION}/wars/activiti-rest.war -d ${TOMCAT_HOME}/webapps/activiti-rest && \
	rm -f /tmp/activiti.zip

# Add PostgreSQL connector to application
RUN wget ${POSTGRESQL_URL}-${POSTGRESQL_JDBC_DRIVER_VERSION}.jar -O /tmp/postgresql-${POSTGRESQL_JDBC_DRIVER_VERSION}.jar && \
	cp /tmp/postgresql-${POSTGRESQL_JDBC_DRIVER_VERSION}.jar ${TOMCAT_HOME}/webapps/activiti-app/WEB-INF/lib/ && \
	cp /tmp/postgresql-${POSTGRESQL_JDBC_DRIVER_VERSION}.jar ${TOMCAT_HOME}/webapps/activiti-rest/WEB-INF/lib/ && \
	rm -rf /tmp/postgresql-${POSTGRESQL_JDBC_DRIVER_VERSION}.jar 

# Add roles
ADD assets /assets
RUN cp /assets/config/tomcat/tomcat-users.xml ${TOMCAT_HOME}/conf/

CMD ["/assets/init"]

