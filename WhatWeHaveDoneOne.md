# What We Have Done

## Project

Built a Java 8 Spring Boot REST API using the supplied `build.gradle` dependency set.

- Group: `com.freddiemac.infolens`
- Version: `1.0.0`
- Spring Boot: `2.5.15`
- Gradle wrapper: `7.6.4`
- Java: `C:\java\jdk8`
- Build system: Gradle only

## REST API

Endpoint:

```text
GET http://localhost:8080/api/v1/hello
```

Response verified:

```json
{"message":"Hello from Java 8 Spring Boot"}
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

## Java and Gradle isolation

`gradle.properties` contains:

```properties
org.gradle.java.home=C:/java/jdk8
org.gradle.daemon=false
```

This selects Java 8 for this project only. Global Java 21 and global Gradle were not changed. The project uses `gradlew.bat`, not the global Gradle command.

## Validation completed

- `gradlew.bat clean test --no-daemon`: successful
- Test cases executed: `1`
- Test failures: `0`
- Test errors: `0`
- `gradlew.bat bootJar --no-daemon`: successful
- Application launched with `C:\java\jdk8\bin\java.exe`: successful
- `GET /api/v1/hello`: HTTP `200`
- Expected JSON response: verified

The internal FHLMC dependencies remain commented because no internal Artifactory URL or credentials were supplied.

## Startup error fix

The command failed when `run-err.log` reported:

```text
Unable to access jarfile build\libs\infolens-java8-api-1.0.0.jar
```

This happened because `clean test` deletes the `build` directory, while `test` does not create the executable Spring Boot JAR. The JAR must be recreated with `bootJar`. The relative path was also unsafe because the project directory contains a space (`java migration`).

The fix is:

```powershell
.\gradlew.bat bootJar --no-daemon
.\run-api.ps1
```

`run-api.ps1` uses the absolute JAR path, quotes it correctly, uses Java 8 explicitly, verifies the endpoint, and stops the temporary application process.
