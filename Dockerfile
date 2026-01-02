# Builder stage
FROM eclipse-temurin:21-jdk-alpine AS builder
WORKDIR /app

COPY gradlew .
COPY gradle ./gradle
COPY *.gradle .
RUN ./gradlew dependencies --no-daemon

COPY src ./src
RUN ./gradlew build -x test --no-daemon


# Runner stage
FROM eclipse-temurin:21-jre-alpine AS runner
WORKDIR /app

COPY --from=builder /app/build/app/* .

ENV PORT=8080
EXPOSE $PORT

ENTRYPOINT ["java", "-cp", "*", "com.dencode.web.server.ServerMain"]
