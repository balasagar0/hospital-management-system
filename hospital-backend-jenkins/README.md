# Hospital Management System - Backend

This is the backend API for the Hospital Management System built with Spring Boot.

## Features

- User Authentication (Signup/Login)
- JWT Token-based Security
- RESTful API endpoints
- H2 Database for development
- MySQL support for production

## API Endpoints

### Authentication
- `POST /auth/signup` - User registration
- `POST /auth/login` - User login

### Example Usage

#### Signup
```bash
curl -X POST http://localhost:8081/auth/signup \
  -H "Content-Type: application/json" \
  -d '{"username":"testuser","email":"testuser@gmail.com","password":"admin123"}'
```

#### Login
```bash
curl -X POST http://localhost:8081/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"testuser","password":"admin123"}'
```

## Local Development

### Prerequisites
- Java 11 or higher
- Maven 3.6+

### Running Locally

1. Clone the repository
2. Navigate to the project directory
3. Run the application:
   ```bash
   mvn spring-boot:run
   ```
4. The application will start on `http://localhost:8081`

### Building
```bash
mvn clean package
```

## Jenkins Deployment

### Prerequisites
- Jenkins server
- Java 11 installed on Jenkins server
- Maven installed on Jenkins server

### Jenkins Pipeline

The project includes a `Jenkinsfile` for automated CI/CD pipeline:

1. **Checkout**: Clone the repository
2. **Build**: Compile the project
3. **Test**: Run unit tests
4. **Package**: Create WAR file
5. **Deploy**: Deploy to port 8080

### Manual Deployment

Use the deployment script:
```bash
chmod +x deploy.sh
./deploy.sh
```

### Docker Deployment

Build and run with Docker:
```bash
docker build -t hospital-backend .
docker run -p 8080:8080 hospital-backend
```

Or use docker-compose:
```bash
docker-compose up -d
```

## Configuration

### Application Properties

The application uses H2 database by default. To use MySQL:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/hospital
spring.datasource.username=root
spring.datasource.password=root
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
```

### Environment Variables

- `SPRING_PROFILES_ACTIVE`: Set to `prod` for production
- `SERVER_PORT`: Override default port (default: 8081)

## Health Check

The application provides health check endpoints:
- `GET /actuator/health` - Application health status

## Logs

Application logs are written to:
- Console output
- `app.log` file (when deployed)

## Troubleshooting

### Common Issues

1. **Port already in use**: Change the port in `application.properties`
2. **Database connection issues**: Check database configuration
3. **Build failures**: Ensure Java 11+ and Maven 3.6+ are installed

### Verification

After deployment, verify the application is running:
```bash
curl http://localhost:8080/auth/signup \
  -X POST \
  -H "Content-Type: application/json" \
  -d '{"username":"testuser","email":"testuser@gmail.com","password":"admin123"}'
```

Expected response: `"User registered successfully!"`

## CI/CD Pipeline

The Jenkins pipeline automatically:
1. Builds the application
2. Runs tests
3. Packages the WAR file
4. Deploys to port 8080
5. Performs health checks
6. Archives artifacts

## Security

- JWT tokens for authentication
- BCrypt password encoding
- CORS enabled for frontend integration
- CSRF disabled for API usage
