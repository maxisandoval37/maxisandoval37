FROM eclipse-temurin:17-jdk-alpine AS build

COPY . .

RUN chmod +x ./mvnw \
    && ./mvnw dependency:go-offline -B \
    && ./mvnw clean package -DskipTests

FROM eclipse-temurin:17-jre-alpine

EXPOSE 8080

COPY --from=build target/*.jar demo.jar

ENTRYPOINT ["java", "-jar", "demo.jar"]
