<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Remove Products</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }

        .header {
            background: #d9534f; /* Red theme */
            color: white;
            padding: 1rem 0;
        }

        .header .container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 80%;
            margin: auto;
        }

        .header .logo {
            font-size: 2rem;
            font-weight: bold;
            text-decoration: none;
            color: white;
        }

        .header .navbar {
            display: flex;
            align-items: center;
            gap: 2rem;
        }

        .header .nav {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
            gap: 1.5rem;
        }

        .header .nav a {
            color: white;
            text-decoration: none;
            font-size: 1rem;
            padding: 5px 10px;
            border-radius: 5px;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .header .nav a:hover {
            background-color: rgba(255, 255, 255, 0.2);
            transform: scale(1.05);
        }

        .header .user-info {
            display: flex;
            align-items: center;
        }

        .header .user-name {
            color: white;
            margin-right: 10px;
            font-size: 1rem;
            font-weight: bold;
        }

        .header .sign-out {
            color: white;
            text-decoration: none;
            padding: 5px 10px;
            background-color: rgba(255, 255, 255, 0.2);
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .header .sign-out:hover {
            background-color: rgba(255, 255, 255, 0.4);
        }

        .alert {
            padding: 15px;
            margin: 20px;
            background-color: #f8d7da; /* Red alert background */
            border: 1px solid #f5c6cb;
            border-radius: 4px;
            color: #721c24;
            text-align: center;
        }

        .products {
            padding: 2rem;
            text-align: center;
        }

        .products h2 {
            color: #d9534f;
            margin-bottom: 1.5rem;
        }

        .product-grid {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
        }

        .product-item {
            background: white;
            padding: 1rem;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            margin: 1rem;
            width: 250px;
            transition: transform 0.2s ease;
        }

        .product-item:hover {
            transform: scale(1.05);
        }

        .product-item h3 {
            margin: 0.5rem 0;
            font-size: 1.2rem;
            color: #333;
        }

        .product-item p {
            margin: 0.5rem 0;
            font-size: 1rem;
            color: #d9534f;
        }

        .product-item form {
            margin-top: 1rem;
        }

        .product-item button {
            background: #d9534f;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        .product-item button:hover {
            background: #c9302c;
            transform: scale(1.05);
        }

        .footer {
            background: #333;
            color: white;
            text-align: center;
            padding: 1rem 0;
            margin-top: 2rem;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
    <!-- <header class="header">
        <div class="container">
            <a href="/eCart/homepage" class="logo">E-Cart Solutions</a>
            <nav class="navbar">
                <ul class="nav">
                    <li><a href="/eCart/homepage">Home</a></li>
                    <li><a href="/eCart/shop">Shop</a></li>
                    <li><a href="/eCart/about">About</a></li>
                    <li><a href="/eCart/contact">Contact</a></li>
                    <li><a href="#"><i class="fas fa-search"></i></a></li>
                    <li><a href="/eCart/cart"><i class="fas fa-shopping-cart"></i></a></li>
                </ul>
                <div class="user-info">
                    <span class="user-name">Welcome, ${sessionScope.loggedInUser}!</span>
                    <a href="${pageContext.request.contextPath}/userLogin" class="sign-out">Sign Out</a>
                </div>
            </nav>
        </div>
    </header>-->

    <c:if test="${not empty message}">
        <div class="alert">${message}</div>
    </c:if>

    <section class="products">
        <h2>Select a product to remove</h2>
        <div class="product-grid">
            <c:choose>
                <c:when test="${not empty productsList}">
                    <c:forEach var="product" items="${productsList}">
                        <div class="product-item">
                            <h3>${product.productName}</h3>
                            <p>Type: ${product.productType}</p>
                            <p>Price: ${product.productPrice}</p>
                            <form action="${pageContext.request.contextPath}/removeItemsPage" method="post">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <input type="hidden" name="productName" value="${product.productName}" />
                            <button type="submit" onclick="return confirm('Are you sure you want to remove this product?')">
                                Remove
                            </button>
                        </form>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p>No products available.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <footer class="footer">
        <p>&copy; 2025 E-Cart Solutions. All rights reserved.</p>
    </footer>
</body>
</html>
