#!/bin/bash

# Hospital Management System - Backend Deployment Script
# This script deploys the Spring Boot application via Jenkins

set -e  # Exit on any error

echo "Starting Hospital Backend Deployment..."

# Variables
APP_NAME="hospital-backend"
JAR_FILE="target/hospital-1.0.0.war"
PORT=8080
LOG_FILE="deployment.log"

# Function to log messages
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a $LOG_FILE
}

# Check if JAR file exists
if [ ! -f "$JAR_FILE" ]; then
    log "ERROR: JAR file $JAR_FILE not found. Please build the project first."
    exit 1
fi

# Stop existing application
log "Stopping existing application..."
pkill -f "$JAR_FILE" || log "No existing application found to stop"

# Wait for port to be free
log "Waiting for port $PORT to be free..."
while lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null; do
    sleep 1
done

# Start the application
log "Starting application on port $PORT..."
nohup java -jar $JAR_FILE --server.port=$PORT > app.log 2>&1 &
APP_PID=$!

# Wait for application to start
log "Waiting for application to start..."
sleep 30

# Health check
log "Performing health check..."
for i in {1..10}; do
    if curl -f -s http://localhost:$PORT/auth/signup \
        -X POST \
        -H "Content-Type: application/json" \
        -d '{"username":"testuser","email":"testuser@gmail.com","password":"admin123"}' > /dev/null; then
        log "Health check passed! Application is running successfully."
        break
    else
        log "Health check attempt $i failed. Retrying in 5 seconds..."
        sleep 5
    fi
    
    if [ $i -eq 10 ]; then
        log "ERROR: Health check failed after 10 attempts. Deployment failed."
        kill $APP_PID || true
        exit 1
    fi
done

# Test the signup endpoint as specified in requirements
log "Testing signup endpoint with required parameters..."
curl -f http://localhost:$PORT/auth/signup \
    -X POST \
    -H "Content-Type: application/json" \
    -d '{"username":"testuser","email":"testuser@gmail.com","password":"admin123"}' \
    -w "\nHTTP Status: %{http_code}\n" || {
    log "ERROR: Signup endpoint test failed"
    exit 1
}

log "Deployment completed successfully!"
log "Application is running on http://localhost:$PORT"
log "Test endpoint: http://localhost:$PORT/auth/signup?username=testuser&email=testuser@gmail.com&password=admin123"

# Display application info
echo ""
echo "=== Deployment Summary ==="
echo "Application: $APP_NAME"
echo "Port: $PORT"
echo "PID: $APP_PID"
echo "Log file: app.log"
echo "Deployment log: $LOG_FILE"
echo "=========================="
