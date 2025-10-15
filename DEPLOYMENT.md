# Hospital Management System - Deployment Guide

This guide covers the complete deployment process for the Hospital Management System using Jenkins CI/CD pipeline.

## Prerequisites

### System Requirements
- Java 11 or higher
- Maven 3.6+
- Node.js 16+
- Jenkins server
- Docker (optional)

### Jenkins Setup
1. Install Jenkins on your server
2. Install required plugins:
   - Pipeline
   - Git
   - Maven Integration
   - Docker Pipeline (optional)

## Deployment Steps

### 1. Backend Deployment via Jenkins

#### Jenkins Pipeline Configuration
The project includes a `Jenkinsfile` that automates the entire deployment process:

```groovy
pipeline {
    agent any
    stages {
        stage('Checkout') { /* Clone repository */ }
        stage('Build') { /* Compile project */ }
        stage('Test') { /* Run tests */ }
        stage('Package') { /* Create WAR file */ }
        stage('Deploy') { /* Deploy to port 8080 */ }
    }
}
```

#### Manual Jenkins Setup
1. Create a new Jenkins job
2. Select "Pipeline" project type
3. Configure Git repository: `https://github.com/suneethabulla/hospital-backend-jenkins.git`
4. Set pipeline script from SCM
5. Save and build

#### Deployment Verification
After successful deployment, verify the backend:

```bash
# Test signup endpoint
curl -X POST http://localhost:8080/auth/signup \
  -H "Content-Type: application/json" \
  -d '{"username":"testuser","email":"testuser@gmail.com","password":"admin123"}'

# Expected response: "User registered successfully!"
```

### 2. Frontend Deployment

#### Local Development
```bash
cd frontend/
npm install
npm run dev
```

#### Production Build
```bash
cd frontend/
npm run build
# Serve the dist/ folder with a web server
```

### 3. Docker Deployment (Alternative)

#### Backend Docker Deployment
```bash
cd backend/
docker build -t hospital-backend .
docker run -p 8080:8080 hospital-backend
```

#### Using Docker Compose
```bash
cd backend/
docker-compose up -d
```

## Configuration

### Backend Configuration

#### Application Properties
```properties
# Development (H2 Database)
spring.datasource.url=jdbc:h2:mem:testdb
spring.datasource.driver-class-name=org.h2.Driver
spring.datasource.username=sa
spring.datasource.password=password

# Production (MySQL)
spring.datasource.url=jdbc:mysql://localhost:3306/hospital
spring.datasource.username=root
spring.datasource.password=root
```

#### Environment Variables
```bash
export SPRING_PROFILES_ACTIVE=prod
export SERVER_PORT=8080
export SPRING_DATASOURCE_URL=jdbc:mysql://localhost:3306/hospital
```

### Frontend Configuration

#### API Configuration
Update the API base URL in frontend:
```javascript
// In src/pages/Login.jsx and Signup.jsx
const API_BASE_URL = 'http://localhost:8080'; // or your server URL
```

## Health Checks

### Backend Health Check
```bash
# Application health
curl http://localhost:8080/actuator/health

# API endpoint test
curl -X POST http://localhost:8080/auth/signup \
  -H "Content-Type: application/json" \
  -d '{"username":"testuser","email":"testuser@gmail.com","password":"admin123"}'
```

### Frontend Health Check
- Open `http://localhost:5173` in browser
- Verify login/signup pages load
- Test API integration

## Monitoring

### Application Logs
```bash
# Backend logs
tail -f backend/app.log

# Jenkins logs
# Check Jenkins console output
```

### Performance Monitoring
- Monitor application response times
- Check database connection pool
- Monitor memory usage

## Troubleshooting

### Common Issues

#### Backend Issues
1. **Port 8080 already in use**
   ```bash
   # Kill existing process
   pkill -f "hospital-1.0.0.war"
   # Or change port in application.properties
   ```

2. **Database connection issues**
   ```bash
   # Check database is running
   # Verify connection string
   # Check credentials
   ```

3. **Build failures**
   ```bash
   # Clean and rebuild
   mvn clean package
   ```

#### Frontend Issues
1. **API connection errors**
   - Check backend is running
   - Verify API URL configuration
   - Check CORS settings

2. **Build errors**
   ```bash
   # Clear cache and reinstall
   rm -rf node_modules package-lock.json
   npm install
   ```

### Jenkins Issues
1. **Build failures**
   - Check Jenkins logs
   - Verify Java/Maven installation
   - Check Git repository access

2. **Deployment failures**
   - Check port availability
   - Verify application startup
   - Check health check endpoints

## Security Considerations

### Backend Security
- JWT tokens for authentication
- BCrypt password hashing
- CORS configuration
- Input validation

### Frontend Security
- Secure API communication
- Token storage (localStorage)
- Input sanitization

## Backup and Recovery

### Database Backup
```bash
# H2 Database (development)
# Data is in-memory, no backup needed

# MySQL Database (production)
mysqldump -u root -p hospital > hospital_backup.sql
```

### Application Backup
```bash
# Backup WAR file
cp target/hospital-1.0.0.war /backup/
```

## Scaling

### Horizontal Scaling
- Use load balancer
- Multiple application instances
- Database clustering

### Vertical Scaling
- Increase server resources
- Optimize JVM settings
- Database optimization

## Maintenance

### Regular Tasks
- Monitor application logs
- Check disk space
- Update dependencies
- Security patches

### Updates
- Test in development environment
- Deploy during maintenance window
- Monitor after deployment
- Rollback if issues occur

## Support

For deployment issues:
1. Check application logs
2. Verify configuration
3. Test endpoints manually
4. Check Jenkins build logs
5. Contact system administrator
