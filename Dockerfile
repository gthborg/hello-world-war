FROM centos


RUN mkdir /opt/tomcat/

WORKDIR /opt/tomcat
RUN curl -O https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.71/bin/apache-tomcat-9.0.71.tar.gz
RUN tar xvfz apache*.tar.gz
RUN ls /opt/tomcat
RUN mv apache-tomcat-9.0.71 /opt/tomcat/.
RUN yum -y install 
RUN java -version

WORKDIR /opt/tomcat/webapps


EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]
