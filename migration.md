# Java 8 to Java 21 Migration

## Scope

This project was migrated from Java 8/Spring Boot 2.5.15 to Java 21/Spring Boot 3.2.12.

The Java 8 dependency baseline is preserved in `build-java8-final.gradle`. The Java 21 dependency source is preserved in `build-java21.gradle`, and the active build is `build.gradle`.

## Build and runtime changes

- Java 8 -> Java 21
- Spring Boot 2.5.15 -> 3.2.12
- Gradle wrapper 7.6.4 -> 8.10
- Project version `1.0.0` -> `2.0.0`
- Tomcat 9 -> managed Tomcat 10.1.x
- SQL Server JDBC Java 8 artifact -> `mssql-jdbc:12.4.2.jre11`
- Springfox -> Springdoc OpenAPI
- JUnit 4/Mockito 2-era dependencies -> Spring Boot 3 test stack and Mockito 5
- WireMock Java 8 artifact -> WireMock 3
- Java toolchain configured for 21

## Source migration

The test import was updated from the Spring Boot 2 package:

```java
org.springframework.boot.web.server.LocalServerPort
```

to the Spring Boot 3 package:

```java
org.springframework.boot.test.web.server.LocalServerPort
```

No `javax.*` imports were present in the application source, so no additional namespace conversion was required.

The endpoint response was updated to identify the migrated runtime:

```json
{"message":"Hello from Java 21 Spring Boot"}
```

## Java and Gradle configuration

`gradle.properties` selects the installed Java 21 runtime:

```properties
org.gradle.java.home=C:/Program Files/Eclipse Adoptium/jdk-21.0.12.101-hotspot
org.gradle.daemon=false
```

The project wrapper is Gradle 8.10. The global Gradle executable is 9.7.1, but its test executor was incompatible with this build and failed to load the JUnit Platform. Therefore, the target Gradle 8.10 wrapper is the supported build command:

```powershell
.\gradlew.bat clean test bootJar --no-daemon
```

## Validation

- Java 21 build: successful
- Gradle 8.10 wrapper: successful
- Tests: 1 passed, 0 failures, 0 errors
- JaCoCo report: successful
- Executable JAR: created successfully
- Live endpoint verification: successful with `run-api.ps1`
- Live response: HTTP `200`, `{"message":"Hello from Java 21 Spring Boot"}`

## Endpoint

```text
GET http://localhost:8080/api/v1/hello
```

Expected response:

```json
{"message":"Hello from Java 21 Spring Boot"}
```
