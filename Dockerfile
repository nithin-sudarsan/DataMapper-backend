FROM maven:3.8.5-openjdk-17 AS build
COPY . .
ENV GITHUB_TOKEN=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
RUN mvn  -DskipTests -Dmaven.repo.local=/m2repo clean install

FROM openjdk:17.0.1-jdk-slim
COPY --from=build /target/DataMapperDemo-0.0.1-SNAPSHOT.jar demo.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","demo.jar"]
