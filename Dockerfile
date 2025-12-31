# Use OpenJDK 21 as the base image
FROM eclipse-temurin:21-alpine

# Set environment variables!
ENV APP_HOME=/app

# Create application directory
WORKDIR $APP_HOME

# Copy the project files to the container
COPY . .

# Grant execute permission for gradlew
RUN chmod +x ./gradlew

# Set GRADLE_USER_HOME to avoid permission issues
ENV GRADLE_USER_HOME=$APP_HOME/gradle-cache

# Run the Gradle build to fetch dependencies and build the project
RUN ./gradlew clean build --no-daemon

# Expose the default port the app runs on
EXPOSE 8080

# Command to run the application
CMD ["./gradlew", "runApp", "--no-daemon"]
