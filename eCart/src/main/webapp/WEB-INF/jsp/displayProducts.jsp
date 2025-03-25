<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <meta charset="UTF-8">
    <title>All Products</title>
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
        .header {
            background: #28a745;
            color: white;
            padding: 1rem;
            text-align: center;
        }

        .header h1 {
            margin: 0;
            font-size: 2rem;
            font-weight: bolder;
        }

        .products {
            padding: 2rem;
            text-align: center;
        }

        .products h2 {
            color: #28a745;
            margin-bottom: 1.5rem;
        }

        .product-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }

        .product-item {
            background: white;
            padding: 1rem;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            margin: 1rem;
            width: 250px;
            transition: transform 0.2s ease-in-out;
        }

        .product-item:hover {
            transform: scale(1.05);
        }

        .product-image {
            width: 100%;
            height: 180px;
            object-fit: contain;
            border-radius: 10px;
        }

        .product-item h3 {
            margin: 0.5rem 0;
            font-size: 1.2rem;
            color: #333;
        }

        .product-item p {
            margin: 0.5rem 0;
            font-size: 1rem;
            color: #28a745;
        }

        .product-item button {
            background: #FFED29;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
            width: 100%;
        }

        .product-item button:hover {
            background: #218838;
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
<%@ include file="header.jsp"%>
<div class="navbar">
    All Products
</div>
<section class="products">
    <div class="product-grid">
        <c:choose>
            <c:when test="${not empty productsList}">
                <c:forEach var="product" items="${productsList}">
                    <div class="product-item">
                        <img class="product-image" src="<c:url value='/images/${product.productImage}' />" alt="${product.productName}">
                        <h3>${product.productName}</h3>
                        <p>Type: ${product.productType}</p>
                        <p>Price: ${product.productPrice}</p>
                        <c:choose>
                            <c:when test="${userRole == 'admin'}">
                                <form action="${pageContext.request.contextPath}/updateItems" method="get">
                                    <input type="hidden" name="productId" value="${product.productId}">
                                    <input type="hidden" name="productName" value="${product.productName}">
                                    <input type="hidden" name="productType" value="${product.productType}">
                                    <input type="hidden" name="productPrice" value="${product.productPrice}">
                                    <input type="hidden" name="productImage" value="${product.productImage}">
                                    <button type="submit">Edit</button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <form action="${pageContext.request.contextPath}/addToCart" method="post">
                                    <input type="hidden" name="productId" value="${product.productId}">
                                    <input type="hidden" name="productName" value="${product.productName}">
                                    <input type="hidden" name="productType" value="${product.productType}">
                                    <input type="hidden" name="productPrice" value="${product.productPrice}">
                                    <input type="hidden" name="productImage" value="${product.productImage}">
                                    <button type="submit">Add to Cart</button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p>No products available.</p>
            </c:otherwise>
        </c:choose>
    </div>
</section>
</body>
</html>
