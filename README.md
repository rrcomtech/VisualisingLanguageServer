# Xtext Language Server Example

## Quickstart

- Run `./gradlew run`

This will start the server with the help of `org.xtext.example.mydsl.websockets.RunWebSocketServer3`.

## Project Structure

- `org.xtext.example.mydsl` (contains the dsl)
- `org.xtext.example.mydsl.ide` (contains the dsl specific customizations of the Xtext language server)
- `org.xtext.example.mydsl.tests`
- `org.xtext.example.mydsl.websockets` (contains the code to launch a websocket and the server and tie them to each other)

## Building in Details

1. Make sure that `java -version` is executable and pointing to a Java 8+ JDK.

### Scenario 1 (build LSP binary )

1. Run `./gradlew distZip`.
2. Go to zip file of the ide sub project (, e.g. `find . -name "*ide*zip"`)
3. Inflate it
4. Find the binary file `mydsl-socket`, and
5. start it as follows:
- `mydsl-socket [PORT_THE_LSP_SHOULD_RUN_ON]`

### Scenario 2 (install language into local Maven repository)

1. Set the language name in `settings.gradle` file with the help of the `rootProject.name` attribute. Do it, for instance, as follows:
- `rootProject.name = 'grammar_MDR_simplified'`
2. Set the language version in `gradle.properties` file as follows:
- `version = VERSION`, e.g., `version = 1.0.0-SNAPSHOT`
3. Run `./gradlew install`.

### Scenario 3 (client-only with separate server process)

1. Run `./gradlew run` or launch RunServer from Eclipse.