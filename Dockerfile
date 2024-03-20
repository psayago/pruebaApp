# Build Stage for Spring boot application image
FROM openjdk:8-jdk-slim as build

WORKDIR /app

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
#AGREGO LA SIGUIENTE LINEA PARA QUE SE EJECUTEN EN WINDOWS LOS COMANDOS LINUX
#BORRARLA SI SE EJECUTA EN LINUX!!
RUN sed -i 's/\r$//' mvnw

RUN chmod +x ./mvnw
RUN ls
RUN pwd
RUN apt update
RUN apt install tree
RUN tree

# download the dependency if needed or if the pom file is changed
RUN ./mvnw dependency:go-offline -B

COPY src src

RUN ./mvnw package
RUN mkdir -p target/dependency && (cd target/dependency; jar -xf ../*.jar)
RUN tree

# Production Stage for Spring boot application image
FROM openjdk:8-jdk-slim as production
ARG DEPENDENCY=/app/target/dependency

# Copy the dependency application file from build stage artifact
COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=build ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /app

# Run the Spring boot application
ENTRYPOINT ["java", "-cp", "app:app/lib/*","com.example.pruebaApp.Application"]
EXPOSE 8080
