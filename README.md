# Hospital Management System

A full-stack Hospital Management System with Spring Boot backend and React frontend, deployed using CI/CD best practices with Jenkins.

## Project Structure

```
hospital-management-system/
├── backend/                 # Spring Boot API
│   ├── src/
│   ├── Jenkinsfile
│   ├── Dockerfile
│   ├── docker-compose.yml
│   ├── deploy.sh
│   └── README.md
├── frontend/               # React Application
│   ├── src/
│   ├── package.json
│   └── README.md
└── README.md              # This file
```

## Features

### Backend (Spring Boot)
- User Authentication (Signup/Login)
- JWT Token-based Security
- RESTful API endpoints
- H2 Database for development
- MySQL support for production
- Jenkins CI/CD pipeline

### Frontend (React + Vite)
- Modern React application
- User authentication pages
- Hospital dashboard
- Responsive design
- API integration

## Quick Start

### Backend Setup
1. Navigate to `backend/` directory
2. Run: `mvn spring-boot:run`
3. Backend runs on `http://localhost:8081`

### Frontend Setup
1. Navigate to `frontend/` directory
2. Run: `npm install && npm run dev`
3. Frontend runs on `http://localhost:5173`

## API Endpoints

### Authentication
- `POST /auth/signup` - User registration
- `POST /auth/login` - User login

### Example API Usage
```bash
# Signup
curl -X POST http://localhost:8081/auth/signup \
  -H "Content-Type: application/json" \
  -d '{"username":"testuser","email":"testuser@gmail.com","password":"admin123"}'

# Login
curl -X POST http://localhost:8081/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"testuser","password":"admin123"}'
```

## Jenkins Deployment

### Prerequisites
- Jenkins server
- Java 11+
- Maven 3.6+

### Deployment Process
1. Jenkins automatically builds the project
2. Runs tests and quality checks
3. Packages the application
4. Deploys to port 8080
5. Performs health checks

### Manual Deployment
```bash
cd backend/
chmod +x deploy.sh
./deploy.sh
```

### Docker Deployment
```bash
cd backend/
docker-compose up -d
```

## Verification

After deployment, verify the system:

### Backend Health Check
```bash
curl http://localhost:8080/auth/signup \
  -X POST \
  -H "Content-Type: application/json" \
  -d '{"username":"testuser","email":"testuser@gmail.com","password":"admin123"}'
```

Expected response: `"User registered successfully!"`

### Frontend Access
- Open `http://localhost:5173` in your browser
- Test login/signup functionality

## Technology Stack

### Backend
- Spring Boot 2.7.18
- Spring Security
- JWT Authentication
- H2 Database (dev) / MySQL (prod)
- Maven

### Frontend
- React 19
- Vite
- Axios
- React Router

### DevOps
- Jenkins
- Docker
- Docker Compose

## Development

### Backend Development
```bash
cd backend/
mvn spring-boot:run
```

### Frontend Development
```bash
cd frontend/
npm run dev
```

## Production Deployment

### Using Jenkins
1. Push code to repository
2. Jenkins automatically triggers pipeline
3. Application deployed to port 8080

### Using Docker
```bash
docker-compose -f backend/docker-compose.yml up -d
```

## Configuration

### Environment Variables
- `SPRING_PROFILES_ACTIVE`: Set to `prod` for production
- `SERVER_PORT`: Override default port
- `SPRING_DATASOURCE_URL`: Database connection URL

### Database Configuration
- Development: H2 in-memory database
- Production: MySQL database

## Security Features
- JWT token authentication
- BCrypt password encoding
- CORS configuration
- CSRF protection (disabled for API)

## Monitoring
- Health check endpoints
- Application logs
- Jenkins build status

## Contributing
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License
This project is for educational purposes.

## Support
For issues and questions, please create an issue in the repository.
