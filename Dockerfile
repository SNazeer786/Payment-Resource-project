FROM tomcat:latest
COPY ./target/payment-resource.war /usr/local/tomcat/webapps
