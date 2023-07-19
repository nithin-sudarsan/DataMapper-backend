FROM maven:3.8.5-openjdk-17 AS build

# Copy the .netrc file into the container
COPY .netrc /root/.netrc

COPY . .
ARG GITHUB_TOKEN
RUN mvn clean install

# Remove the .netrc file from the build stage
RUN rm /root/.netrc

FROM openjdk:17.0.1-jdk-slim
COPY --from=build /target/DataMapperDemo-0.0.1-SNAPSHOT.jar demo.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","demo.jar"]
