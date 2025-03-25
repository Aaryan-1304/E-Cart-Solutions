<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <meta charset="UTF-8">
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

    .container {
        max-width: 900px;
        margin: auto;
        padding: 2rem;
    }

    .cart-header {
        text-align: center;
        color: #28a745;
        font-size: 2rem;
        margin-bottom: 1.5rem;
    }

    .cart-items {
        display: flex;
        flex-direction: column;
        gap: 15px;
    }

    .cart-item {
        display: flex;
        align-items: center;
        background: white;
        padding: 1.2rem;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        transition: transform 0.2s;
    }

    .cart-item:hover {
        transform: translateY(-3px);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
    }

    .product-image-container {
        width: 120px;
        height: 120px;
        margin-right: 20px;
        border-radius: 8px;
        overflow: hidden;
        flex-shrink: 0;
    }

    .product-image {
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 8px;
    }

    .cart-item .details {
        flex-grow: 1;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .product-info {
        flex-grow: 1;
    }

    .cart-item h3 {
        margin: 0 0 5px;
        font-size: 1.2rem;
        color: #333;
    }

    .cart-item p {
        margin: 3px 0;
        font-size: 1rem;
        color: #555;
    }

    .remove-btn {
        background: #dc3545;
        color: white;
        border: none;
        padding: 8px 12px;
        cursor: pointer;
        font-size: 1rem;
        border-radius: 4px;
        transition: background 0.2s;
        margin-left: 15px;
    }

    .remove-btn:hover {
        background: #c82333;
    }

    .empty-cart-message {
        text-align: center;
        padding: 2rem;
        color: #666;
        font-size: 1.2rem;
    }

    .total-section {
        background: white;
        padding: 1.5rem;
        margin-top: 2rem;
        text-align: right;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .total-section p {
        margin: 0.5rem 0;
        font-size: 1.1rem;
        color: #333;
    }

    .total-section p:last-child {
        font-size: 1.3rem;
        font-weight: bold;
        color: #28a745;
        margin-top: 10px;
        padding-top: 10px;
        border-top: 2px solid #eee;
    }

    .footer {
        background: #333;
        color: white;
        text-align: center;
        padding: 1rem 0;
        margin-top: 2rem;
    }

    .continue-checkout {
        display: inline-block;
        margin-top: 2rem;
        padding: 10px 20px;
        font-size: 1rem;
        color: #28a745;
        text-decoration: none;
        font-weight: bold;
        border: 2px solid #28a745;
        border-radius: 4px;
        transition: all 0.3s ease;
    }

    .continue-checkout:hover {
        background: #28a745;
        color: white;
    }

    .alert {
        padding: 1rem;
        margin-bottom: 1rem;
        border-radius: 4px;
        text-align: center;
    }

    .alert-success {
        background-color: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
    }

    .alert-danger {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
    } 	
</style>
</head>
<body>

<%@ include file="header.jsp" %>


<div class="container">
    <h2 class="cart-header">Your Shopping Cart</h2>
    <c:if test="${not empty message}">
        <div class="alert alert-success">
            ${message}
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            ${error}
        </div>
    </c:if>
    <c:choose>
        <c:when test="${not empty cart}">
            <div class="cart-items">
            <c:forEach var="product" items="${cart}">
            <div class="cart-item">
                <div class="product-image-container">
            	<img src="<c:url value='/images/${product.productImage}' />" alt="${product.productName}">
                </div>
                <div class="details">
                    <div class="product-info">
                        <p>ID: ${product.productId}</p>
                        <p>Type: ${product.productType}</p>
                        <p>Price: ₹${product.productPrice}</p>
                        
                        <div class="quantity-controls">
                            <form id="updateDB" method="POST" action="${contextPath}/updateQuantity">
                                <input type="hidden" name="productId" value="${product.productId}">
                                <button type="submit" name="action" value="decrease" class="quantity-btn">-</button>
                                <span>${product.quantity}</span>
                                <button type="submit" name="action" value="increase" class="quantity-btn">+</button>
                            </form>
                        </div>
                    </div>

                    <form method="POST" action="${contextPath}/removeFromCart">
                        <input type="hidden" name="productId" value="${product.productId}">
                        <button type="submit" class="remove-btn">
                            <i class="fas fa-trash"></i> Remove
                        </button>
                    </form>
                </div>
            </div>
        </c:forEach>
            </div>

            <div class="total-section">
                <c:set var="totalPrice" value="0" />
                <c:forEach var="product" items="${cart}">
                    <c:set var="totalPrice" value="${totalPrice + (product.productPrice * product.quantity)}" />
                </c:forEach>
                <p>Total Items: ${cart.size()}</p>
                <p>Total Price: ₹${totalPrice}</p>
            </div>

        </c:when>

        <c:otherwise>
            <div class="empty-cart-message">
                <i class="fas fa-shopping-cart" style="font-size: 3rem; color: #28a745; margin-bottom: 1rem;"></i>
                <p>Your cart is empty!</p>
                <p>Add some products to begin shopping.</p>
            </div>
        </c:otherwise>
    </c:choose>

	    <a href="${contextPath}/allProducts" class="continue-checkout">
	        <i class="fas fa-arrow-left"></i> Continue Shopping
	    </a>
	        
	        <form id="checkoutForm" method="POST" action="${contextPath}/checkout">
		        <c:forEach var="product" items="${cart}">
		            <input type="hidden" name="productId" value="${product.productId}">
		            <input type="hidden" name="quantity" value="${product.quantity}">
		        </c:forEach>
		        <button type="submit" class="continue-checkout">
		            Checkout <i class="fas fa-arrow-right"></i>
		        </button>
		    </form>

    </a>
</div>

<div class="footer">
    &copy; 2025 E-Cart Solutions. All rights reserved.
</div>
<script>
	function updatedDB() {
		function checkout() {
		    document.getElementById("checkoutForm").submit();
		}
	}
</script>
</body>
</html>