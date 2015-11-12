FROM java:7

# Install maven
RUN apt-get update
RUN apt-get install -y wget git-core maven

WORKDIR /spring-petclinic

# Pull project
#RUN git clone https://github.com/cjayarathne/spring-petclinic.git

# Prepare by downloading dependencies
COPY src /spring-petclinic/src
COPY pom.xml /spring-petclinic/pom.xml

RUN ["mvn", "dependency:resolve"]
RUN ["mvn", "verify"]

#RUN cd /spring-petclinic && mvn package

# Adding source, compile and package into a fat jar
#ADD src /spring-petclinic/src
#RUN ["mvn", "package"]

EXPOSE 9966
CMD ["mvn", "tomcat7:run"]
