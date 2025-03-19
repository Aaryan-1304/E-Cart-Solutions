<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error - E-Cart</title>
    <style>
        .container { width: 80%; margin: 0 auto; padding: 20px; }
        .error-box { background-color: #f8d7da; border-left: 5px solid #dc3545; padding: 20px; margin: 20px 0; }
        .btn { display: inline-block; padding: 10px 15px; background-color: #007bff; color: white; text-decoration: none; border-radius: 4px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Something went wrong</h1>
        
        <div class="error-box">
            <h3>Error Details</h3>
            <p>${errorMessage}</p>
        </div>
        
        <a href="${pageContext.request.contextPath}/" class="btn">Back to Homepage</a>
    </div>
</body>
</html>