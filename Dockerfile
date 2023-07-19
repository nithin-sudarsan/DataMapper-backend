FROM maven:3.8.5-openjdk-17 AS build
COPY . .
ENV GITHUB_TOKEN=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
RUN mvn clean package

FROM openjdk:17.0.1-jdk-slim
COPY --from=build /target/DataMapperDemo-0.0.1-SNAPSHOT.jar demo.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","demo.jar"]
