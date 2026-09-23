# Infolens Java Migration API

A Spring Boot REST API migrated from Java 8/Spring Boot 2.5 to Java 21/Spring Boot 3.2.

## Technology Stack

- Java 21
- Spring Boot 3.2.12
- Gradle 8.10 wrapper
- Spring Web and Actuator
- Spring Data REST
- Spring Security 6.x
- OpenFeign
- SQL Server JDBC
- Springdoc OpenAPI
- JUnit 5, Mockito, WireMock
- JaCoCo

## API

### Hello

```http
GET http://localhost:8080/api/v1/hello
```

Response:

```json
{
  "message": "Hello from Java 21 Spring Boot"
}
```

Actuator health endpoint:

```http
GET http://localhost:8080/actuator/health
```

OpenAPI UI:

```text
http://localhost:8080/swagger-ui.html
```

## Requirements

- Java 21 installed at:
  `C:\Program Files\Eclipse Adoptium\jdk-21.0.12.101-hotspot`
- PowerShell on Windows
- Internet access for Maven Central dependency resolution

The project uses the Gradle wrapper. Do not use the globally installed Gradle version for the project build.

## Build and Test

From the project root:

```powershell
.\gradlew.bat clean test bootJar --no-daemon
```

The build runs tests and generates the JaCoCo report.

The executable JAR is generated under:

```text
build\libs\infolens-java8-api-2.0.0.jar
```

## Run the Application

Using the project launch script:

```powershell
.\run-api.ps1
```

The script uses Java 21, starts the application, verifies `/api/v1/hello`, prints the response, and stops the temporary process.

Alternatively:

```powershell
& 'C:\Program Files\Eclipse Adoptium\jdk-21.0.12.101-hotspot\bin\java.exe' `
  -jar '.\build\libs\infolens-java8-api-2.0.0.jar'
```

## Migration

The Java 8 dependency baseline is preserved in:

```text
build-java8-final.gradle
```

The Java 21 dependency reference is preserved in:

```text
build-java21.gradle
```

The active build is:

```text
build.gradle
```

Migration highlights:

- Java 8 to Java 21
- Spring Boot 2.5.15 to 3.2.12
- Gradle 7.6.4 to 8.10
- `javax`-era Spring Boot APIs migrated to Boot 3 APIs where required
- Springfox replaced with Springdoc OpenAPI
- Tomcat 9 replaced by managed Tomcat 10.1
- Java 8 SQL Server driver replaced with the Java 11+ compatible driver
- JUnit 4-era testing replaced by the Spring Boot 3/JUnit 5 test stack

See [`migration.md`](migration.md) for details.

## Project Structure

```text
src/main/java/       Application and REST API source
src/main/resources/  Application configuration
src/test/java/       Integration tests
build.gradle         Active Java 21 Gradle build
build-java8-final.gradle  Preserved Java 8 baseline
build-java21.gradle  Preserved Java 21 dependency reference
gradlew.bat           Gradle 8.10 wrapper entry point
migration.md         Migration notes
```

## Verification

The project was verified with:

- Java 21.0.12.1
- Gradle wrapper 8.10
- One integration test passing
- JaCoCo report generation
- `GET /api/v1/hello` returning HTTP 200

Expected live response:

```json
{"message":"Hello from Java 21 Spring Boot"}
```

## Internal Dependencies

Internal FHLMC dependencies remain commented because the required private repository URL and credentials are not part of this repository.
