<<<<<<< HEAD
FROM eclipse-temurin:11.0.18_10-jdk-alpine as build
WORKDIR /workspace/app

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src

RUN sh ./mvnw install -DskipTests
RUN mkdir -p target/dependency && (cd target/dependency; jar -xf ../*.jar)

FROM eclipse-temurin:11
=======
FROM eclipse-temurin:11-jdk-alpine as build
WORKDIR /workspace/app
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
RUN chmod +x mvnw
COPY src src

RUN ./mvnw install -DskipTests
RUN mkdir -p target/dependency && (cd target/dependency; jar -xf ../*.jar)

FROM eclipse-temurin:11-jdk-alpine

>>>>>>> 4894b9868fb228949acf9f0a5b96daa23780fe02

VOLUME /tmp
ARG DEPENDENCY=/workspace/app/target/dependency
COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=build ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /app
<<<<<<< HEAD

ENTRYPOINT ["java","-cp","app:app/lib/*","com.ucb.bo.sktmsdiscovery.SktMsDiscoveryApplicationKt"]
=======
ENV EUREKA_URL=$EUREKA_URL
ENV CONFIG_SERVER_URL=$CONFIG_SERVER_URL
ENV SPRING_PROFILE=$SPRING_PROFILE
ENTRYPOINT ["java", "-cp","app:app/lib/*", "com.ucb.bo.sktmsdiscovery.SktMsDiscoveryApplicationKt"]
>>>>>>> 4894b9868fb228949acf9f0a5b96daa23780fe02
