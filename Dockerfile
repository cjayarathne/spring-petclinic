FROM java:7 

# Install maven
RUN apt-get update
RUN apt-get install -y wget git-core maven

WORKDIR /spring-petclinic-demo

# Pull project
RUN git clone https://github.com/cjayarathne/spring-petclinic.git

# Prepare by downloading dependencies
ADD pom.xml /spring-petclinic-demo/pom.xml
RUN ["mvn", "dependency:resolve"]
RUN ["mvn", "verify"]

# Adding source, compile and package into a fat jar
ADD src /spring-petclinic-demo/src
RUN ["mvn", "package"]

EXPOSE 9966
CMD ["mvn", "tomcat7:run"]