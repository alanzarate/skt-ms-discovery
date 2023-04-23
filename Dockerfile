
FROM eclipse-temurin:11.0.18_10-jdk-alpine as build
WORKDIR /workspace/app

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src

RUN sh ./mvnw install -DskipTests
RUN mkdir -p target/dependency && (cd target/dependency; jar -xf ../*.jar)

FROM eclipse-temurin:11-jdk-alpine

VOLUME /tmp
ARG DEPENDENCY=/workspace/app/target/dependency
COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=build ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /app

ENV EUREKA_URL=$EUREKA_URL
ENV CONFIG_SERVER_URL=$CONFIG_SERVER_URL
ENV SPRING_PROFILE=$SPRING_PROFILE
ENTRYPOINT ["java", "-cp","app:app/lib/*", "com.ucb.bo.sktmsdiscovery.SktMsDiscoveryApplicationKt"]

