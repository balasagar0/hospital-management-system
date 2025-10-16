# Hospital Management System - Demo Guide

## Project Overview
This is a Hospital Management System with:
- **Backend**: Spring Boot REST API
- **Frontend**: React application
- **Database**: MySQL database
- **Authentication**: JWT-based login/signup

## Demo Steps

### 1. Backend API Endpoints
The backend provides these REST endpoints:

#### Signup Endpoint
- **URL**: `POST /auth/signup`
- **Body**: 
```json
{
  "username": "testuser",
  "email": "testuser@gmail.com", 
  "password": "admin123"
}
```
- **Response**: `"User registered successfully!"`

#### Login Endpoint
- **URL**: `POST /auth/login`
- **Body**:
```json
{
  "username": "testuser",
  "password": "admin123"
}
```
- **Response**: JWT token

### 2. Frontend Features
- Login page with username/password
- Signup page with username/email/password
- Dashboard showing hospital modules
- Navigation between pages

### 3. Technology Stack
- **Backend**: Spring Boot 2.7.18, Spring Security, JWT
- **Frontend**: React 19, Vite, Axios
- **Database**: H2 (development), MySQL (production)
- **Build Tool**: Maven
- **CI/CD**: Jenkins pipeline

### 4. Project Structure
```
hospital-management-system/
├── hospital-backend-jenkins/    # Spring Boot API
│   ├── src/main/java/          # Java source code
│   ├── Jenkinsfile             # CI/CD pipeline
│   └── pom.xml                 # Maven configuration
├── hospital-frontend/          # React application
│   ├── src/                    # React source code
│   └── package.json            # Node.js dependencies
└── README.md                   # Project documentation
```

### 5. Jenkins CI/CD Pipeline
The Jenkins pipeline includes:
1. **Checkout**: Clone from GitHub
2. **Build**: Compile with Maven
3. **Deploy**: Run on port 8080
4. **Health Check**: Verify endpoints

### 6. Local Development
```bash
# Backend
cd hospital-backend-jenkins
mvn spring-boot:run

# Frontend  
cd hospital-frontend
npm install
npm run dev
```

### 7. API Testing
Use tools like Postman or curl to test:
```bash
curl -X POST http://localhost:8081/auth/signup \
  -H "Content-Type: application/json" \
  -d '{"username":"testuser","email":"testuser@gmail.com","password":"admin123"}'
```

## Key Features Demonstrated
- RESTful API design
- User authentication system
- Modern React frontend
- CI/CD pipeline with Jenkins
- Docker containerization support
- Comprehensive project documentation
