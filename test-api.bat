@echo off
echo Testing Hospital Management System API...
echo.
echo Testing Signup Endpoint...
curl -X POST http://localhost:8081/auth/signup -H "Content-Type: application/json" -d "{\"username\":\"testuser\",\"email\":\"testuser@gmail.com\",\"password\":\"admin123\"}"
echo.
echo.
echo Testing Login Endpoint...
curl -X POST http://localhost:8081/auth/login -H "Content-Type: application/json" -d "{\"username\":\"testuser\",\"password\":\"admin123\"}"
echo.
echo.
echo API Test Complete!
pause
