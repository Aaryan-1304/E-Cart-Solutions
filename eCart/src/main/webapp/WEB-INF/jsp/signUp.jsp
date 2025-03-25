<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <meta charset="ISO-8859-1">
    <title>SignUp Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            flex-direction: column;
        }

        h1 {
            color: #333;
            margin-bottom: 20px;
        }

        form {
            background: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
            text-align: center;
        }

        label {
            font-weight: bold;
            display: block;
            margin-top: 10px;
            margin-bottom: 5px;
        }

        input[type="text"], input[type="password"], select {
            width: calc(100% - 22px);
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }

        input[type="submit"] {
            background-color: #5cb85c;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #4cae4c;
            transform: scale(1.10);
        }

        .header {
            background-color: #28a745; /* Green background */
            color: white;
            padding: 1rem;
            text-align: center;
            font-size: 1.5rem;
            font-weight: bold;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 100%;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
        }

        .footer {
            background-color: #28a745; /* Green background */
            padding: 1rem;
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            text-align: center;
            color: white;
        }

        a {
            color: #28a745;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

    </style>
</head>
<body>
    <div class="header">
        Welcome to E-Cart Solutions Signup
    </div>

    <h1>SIGNUP</h1>
    <form action="/eCart/userSignup" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required><br>
        
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br>
        
        <label for="usertype">User Type:</label>
        <select id="usertype" name="usertype" required>
            <option value="admin">Admin</option>
            <option value="customer">Customer</option>
            <option value="seller">Seller</option>
            <option value="sorter">Sorter</option>
            <option value="wholeseller">Wholeseller</option>
        </select><br>
        
        <input type="submit" value="Sign Up">
    </form>

    <p>Already have an account? <a href="${pageContext.request.contextPath}/userLogin">Back to Login</a></p>

    <div class="footer">
        &copy; 2025 E-Cart Solutions. All rights reserved.
    </div>
</body>
</html>
