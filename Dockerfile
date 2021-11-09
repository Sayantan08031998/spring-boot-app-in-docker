FROM openjdk:11
EXPOSE 8000
ADD target/spring-kalai-docker.jar spring-kalai-docker.jar
ENTRYPOINT ["java","-jar","/spring-kalai-docker.jar"]
