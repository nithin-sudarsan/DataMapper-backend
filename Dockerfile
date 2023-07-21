# Use the official Maven base image
FROM maven:3.8.5-openjdk-17 AS build

# Set a build argument for the GitHub token
ENV GITHUB_USER=nithin-sudarsan
ENV GITHUB_TOKEN=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


# Create a directory to store the settings.xml
RUN mkdir -p /usr/share/maven/ref/

# Copy the custom settings.xml to the image
COPY settings.xml /usr/share/maven/ref/settings.xml

# Continue with the rest of the Dockerfile
COPY . .

# Build the Maven project
RUN mvn clean install -Dmaven.repo.local=/m2repo

# Rest of your Dockerfile
FROM openjdk:17.0.1-jdk-slim
COPY --from=build /target/DataMapperDemo-0.0.1-SNAPSHOT.jar demo.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "demo.jar"]





# FROM maven:3.8.5-openjdk-17 AS build
# COPY . .
# ARG GITHUB_TOKEN
# # Install the necessary dependencies using the GitHub token during the build process
# RUN if [ -n "$GITHUB_TOKEN" ]; then \
#         echo "machine github.com login nithin-sudarsan password $GITHUB_TOKEN" > ~/.netrc && \
#         echo "Using GitHub token to install dependencies" && \
#         mvn clean install \
#     ; else \
#         echo "No GitHub token provided. Installing dependencies without token." && \
#         mvn clean install \
#     ; fi
#
#
# FROM openjdk:17.0.1-jdk-slim
# COPY --from=build /target/DataMapperDemo-0.0.1-SNAPSHOT.jar demo.jar
# EXPOSE 8080
# ENTRYPOINT ["java","-jar","demo.jar"]
