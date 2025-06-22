# Use a base image with Tomcat since you're deploying a WAR file
FROM tomcat:10.1-jdk17-corretto

# Set the working directory
WORKDIR /usr/local/tomcat

# Remove default apps if needed
RUN rm -rf webapps/*

# Copy your WAR file from the target folder into Tomcat's webapps directory
ARG WAR_FILE=target/simple-webapp.war
COPY ${WAR_FILE} webapps/ROOT.war

# Expose port
EXPOSE 8080

# Start Tomcat (default CMD is already set in base image)
