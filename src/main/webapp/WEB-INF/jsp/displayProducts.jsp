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
            color: #28a745;
        }

        .product-item button {
            background: #28a745;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        .product-item button:hover {
            background: #218838;
            transform: scale(1.05);
        }
        .product-image {
            width: 200px;
            height: auto;
            border-radius: 10px;
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
                        <img src="${product.productImage}" class="product-image"/>
                        <h3>${product.productName}</h3>
                        <p>Type: ${product.productType}</p>
                        <p>Price: ${product.productPrice}</p>
                        <button onclick="getFormDetails('${product.productImage}', '${product.productId}', '${product.productName}', '${product.productType}', '${product.productPrice}')">
                            Add to Cart
                        </button>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>    
                <p>No products available.</p>
            </c:otherwise>
        </c:choose> 
    </div>
    
    <form id="formName" method="post" action="addToCart">  
        <input type="hidden" name="productImage" id="productImage">
        <input type="hidden" name="productId" id="productId">
        <input type="hidden" name="productName" id="productName">
        <input type="hidden" name="productType" id="productType">
        <input type="hidden" name="productPrice" id="productPrice"> 
    </form>
</section>

<script>
    function getFormDetails(productImage, productId, productName, productType, productPrice) {
        document.getElementById("productImage").value = productImage;
        document.getElementById("productId").value = productId;
        document.getElementById("productName").value = productName;
        document.getElementById("productType").value = productType;
        document.getElementById("productPrice").value = productPrice;  
        
        document.getElementById("formName").submit();
    }
</script>
</body>
</html>
