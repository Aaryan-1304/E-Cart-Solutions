<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <meta charset="UTF-8">
    <title>Add Products</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }

        .navbar {
            background-color: #2d8f29;
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 15px 0;
            font-size: 1.5rem;
            font-weight: bold;
        }

        .addProducts {
            padding: 2rem;
            text-align: center;
        }

        .addProducts h2 {
            color: #28a745;
            margin-bottom: 1.5rem;
        }

        .addProducts-grid {
            display: flex;
            flex-direction: column;
            align-items: center;
            background: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            margin: 0 auto;
        }

        .addProducts-grid label {
            font-size: 1rem;
            color: #333;
            margin: 0.5rem 0;
            text-align: left;
            width: 100%;
        }

        .addProducts-grid input {
            width: 100%;
            padding: 0.5rem;
            margin-bottom: 1rem;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .addProducts-grid button {
            background: #28a745;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        .addProducts-grid button:hover {
            background: #218838;
            transform: scale(1.05);
        }

        .back-to-home {
            margin-top: 1rem;
            text-align: center;
        }

        .back-to-home a {
            text-decoration: none;
            color: #28a745;
            font-size: 1rem;
            font-weight: bold;
            transition: color 0.3s ease;
        }

        .back-to-home a:hover {
            color: #218838;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
    <div class="navbar">
        Add New Product
    </div>
    <section class="addProducts">
        <h2>Add Product Details</h2>
        <form action="/eCart/addItems" method="post">
            <div class="addProducts-grid">
                <label for="productId">Product ID:</label>
                <input type="text" id="productId" name="productId" required>

                <label for="productName">Product Name:</label>
                <input type="text" id="productName" name="productName" required>

                <label for="productType">Product Type:</label>
                <input type="text" id="productType" name="productType" required>

                <label for="productPrice">Product Price:</label>
                <input type="number" id="productPrice" name="productPrice" required>

                <button type="submit">Add Product</button>
            </div>
        </form>
        <div class="message">
        <c:if test="${not empty message}">
            <p>${message}</p>
        </c:if>
        <c:if test="${not empty error}">
        <p>${error}</p>
    </c:if>
    </div>
        <div class="back-to-home">
            <a href="homepage">Back to Homepage</a>
        </div>
    </section>
</body>
</html>
