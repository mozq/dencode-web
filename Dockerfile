# Builder stage
FROM eclipse-temurin:21-jdk-alpine AS builder

WORKDIR /app

COPY gradlew ./
COPY gradle/ ./gradle/
COPY *.gradle ./
RUN chmod +x gradlew && \
    ./gradlew dependencies --no-daemon

COPY src/ ./src/
RUN ./gradlew build -x test --no-daemon


# Runner stage
FROM eclipse-temurin:21-jre-alpine AS runner

RUN addgroup -g 1001 appgroup && \
    adduser -S -D -u 1001 -G appgroup appuser && \
	mkdir -p /app && \
	chown appuser:appgroup /app
WORKDIR /app

COPY --from=builder --chown=appuser:appgroup /app/build/app/ ./

ENV PORT=8080
EXPOSE $PORT

USER appuser
ENTRYPOINT ["java", "-XX:MaxRAMPercentage=75.0", "-cp", "*", "com.dencode.web.server.ServerMain"]
