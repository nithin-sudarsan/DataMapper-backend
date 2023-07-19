FROM maven:3.8.5-openjdk-17 AS build
COPY . .
ARG GITHUB_TOKEN
ENV GITHUB_TOKEN=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
RUN mvn clean package -DskipTests -Dmaven.repo.local=/m2repo

FROM openjdk:17.0.1-jdk-slim
COPY --from=build /target/DataMapperDemo-0.0.1-SNAPSHOT.jar demo.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","demo.jar"]
