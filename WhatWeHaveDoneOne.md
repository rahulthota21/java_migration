# What We Have Done

## Current project status

The project has been migrated from Java 8/Spring Boot 2.5.15 to Java 21/Spring Boot 3.2.12. The Java 8 baseline is preserved in `build-java8-final.gradle`.

## Project

Built a Java 21 Spring Boot REST API using `build-java21.gradle` as the migration source and `build.gradle` as the active build.

- Group: `com.freddiemac.infolens`
- Version: `2.0.0`
- Spring Boot: `3.2.12`
- Gradle wrapper: `8.10`
- Java: `21.0.12.1`
- Build system: Gradle only

## REST API

Endpoint:

```text
GET http://localhost:8080/api/v1/hello
```

Response verified:

```json
{"message":"Hello from Java 21 Spring Boot"}
```

The live endpoint returned HTTP `200`.

## Files added

- `settings.gradle`
- `gradle.properties`
- `gradlew`
- `gradlew.bat`
- `gradle/wrapper/`
- `src/main/java/com/freddiemac/infolens/InfolensApplication.java`
- `src/main/java/com/freddiemac/infolens/api/HelloController.java`
- `src/main/java/com/freddiemac/infolens/api/HelloResponse.java`
- `src/main/resources/application.properties`
- `src/test/java/com/freddiemac/infolens/api/HelloControllerTest.java`

## Java and Gradle configuration

`gradle.properties` contains:

```properties
org.gradle.java.home=C:/Program Files/Eclipse Adoptium/jdk-21.0.12.101-hotspot
org.gradle.daemon=false
```

The project now targets Java 21. The Java 8 baseline remains available in `build-java8-final.gradle`. The project wrapper uses Gradle 8.10.

## Validation completed

- Java 21 detected: `21.0.12.1`
- `gradlew.bat --version`: Gradle `8.10`, Java 21
- `gradlew.bat clean test bootJar --no-daemon`: successful
- Test cases executed: `1`
- Test failures: `0`
- Test errors: `0`
- JaCoCo report: successful
- Application launch script updated to Java 21
- `GET /api/v1/hello`: HTTP `200` verified with Java 21
- Response: `{"message":"Hello from Java 21 Spring Boot"}`

The internal FHLMC dependencies remain commented because no internal Artifactory URL or credentials were supplied.

## Startup script

`run-api.ps1` uses the absolute Java 21 executable and JAR path, quotes paths containing spaces, verifies the endpoint, and stops the temporary application process.
