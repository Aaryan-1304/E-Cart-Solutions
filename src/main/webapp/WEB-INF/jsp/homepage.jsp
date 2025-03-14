<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Cache-Control" content="no-store, no-cache, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>E-Cart Homepage</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        :root {
            --primary: #28a745;
            --primary-dark: #218838;
            --white: #ffffff;
            --gray-light: #f9f9f9;
            --gray: #e2e2e2;
        }

        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--gray-light);
        }

        .container {
            width: 80%;
            margin: auto;
            overflow: hidden;
        }

        /* Header styles - moved to main file to ensure consistency */
        .header {
            background: var(--primary);
            color: var(--white);
            padding: 1rem 0;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .header .container {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header .logo {
            font-size: 2rem;
            font-weight: bolder;
            text-decoration: none;
            color: var(--white);
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

        .header .nav li {
            margin: 0;
        }

        .header .nav a {
            color: var(--white);
            text-decoration: none;
            font-size: 1rem;
            padding: 5px 10px;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .header .nav a:hover {
            background-color: rgba(255, 255, 255, 0.2);
        }

        .header .user-info {
            display: flex;
            align-items: flex-end;
            flex-direction: column;
            justify-content: center;
        }

        .header .user-name {
            color: var(--white);
            font-size: 1rem;
            font-weight: bold;
        }

        .header .sign-out {
            margin-top: 0.5rem;
            color: var(--white);
            text-decoration: none;
            background-color: rgba(255, 255, 255, 0.2);
            padding: 5px 10px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .header .sign-out:hover {
            background-color: rgba(255, 255, 255, 0.4);
        }

        /* Banner Section */
        .banner {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: var(--white);
            padding: 3rem 0;
            text-align: center;
            margin-bottom: 2rem;
        }

        .banner h2 {
            margin: 0;
            font-size: 2.5rem;
            font-weight: bold;
        }

        .banner p {
            margin: 1rem 0 0;
            font-size: 1.2rem;
            opacity: 0.9;
        }

        /* Search Section */
        .search-bar {
            padding: 2rem 0;
            text-align: center;
            background: var(--white);
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            margin-bottom: 10px;
        }

        .search-bar form {
            display: flex;
            max-width: 600px;
            margin: 0 auto;
        }

        .search-bar input {
            flex: 1;
            padding: 1rem;
            border: 2px solid var(--gray);
            border-radius: 5px 0 0 5px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        .search-bar input:focus {
            outline: none;
            border-color: var(--primary);
        }

        .search-bar button {
            padding: 0 1.5rem;
            background: var(--primary);
            border: none;
            color: var(--white);
            border-radius: 0 5px 5px 0;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .search-bar button:hover {
            background: var(--primary-dark);
        }

        /* Action Buttons */
        .button-group {
            display: flex;
            justify-content: center;
            gap: 1.5rem;
            margin: 2rem 0;
        }

        .btn-action {
            background-color: var(--primary);
            color: var(--white);
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-action:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
        }

        /* Products Section */
        .products {
            padding: 2rem 0;
        }

        .products h2 {
            text-align: center;
            margin-bottom: 2rem;
            font-size: 2rem;
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            padding: 0 1rem;
        }

        .search-results {
            display: flex;
            justify-content: center; /* Centers the items horizontally */
            gap: 20px; /* Adds spacing between the items */
            flex-wrap: wrap; /* Ensures responsiveness */
        }

        .product-item {
            background: var(--white);
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }

        .product-item:hover {
            transform: translateY(-5px);
        }

        .product-item img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 5px;
            margin-bottom: 1rem;
        }

        .product-item h3 {
            margin: 1rem 0;
            font-size: 1.2rem;
        }

        .product-item p {
            color: var(--primary);
            font-size: 1.2rem;
            font-weight: bold;
            margin: 0.5rem 0;
        }

        .product-item button {
            width: 100%;
            background: var(--primary);
            color: var(--white);
            border: none;
            padding: 0.8rem;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            margin-top: 1rem;
        }

        .product-item button:hover {
            background: var(--primary-dark);
        }
        .featured-products {
            display: grid;
            grid-template-columns: repeat(3, 1fr); /* Creates 3 equal columns */
            gap: 2rem;
            padding: 0 1rem;
        }

        /* Footer */
        .footer {
            background: #333;
            color: white;
            text-align: center;
            padding: 1rem 0;
            margin-top: 2rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            /* Existing styles */
            .container {
                width: 90%;
            }

            .header .container {
                flex-direction: column;
                text-align: center;
            }

            .header .navbar {
                flex-direction: column;
                gap: 1rem;
            }

            .header .nav {
                flex-wrap: wrap;
                justify-content: center;
            }

            .button-group {
                flex-direction: column;
                padding: 0 1rem;
            }

            .search-bar form {
                width: 90%;
            }

            .product-grid {
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            }

            /* New featured products styles */
            .featured-products {
                grid-template-columns: repeat(2, 1fr);
                gap: 1rem;
            }
        }

        @media (max-width: 480px) {
            .featured-products {
                grid-template-columns: 1fr;
                padding: 0 0.5rem;
            }

            .product-item {
                margin-bottom: 1rem;
            }
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>
    <section class="banner">
        <div class="container">
            <h2>Welcome to E-Cart Solutions</h2>
            <p>Your one-stop solution for all your shopping needs!</p>
        </div>
    </section>

    <section class="search-bar">
    <div class="container">
        <form action="/searchProducts" method="GET">
            <input type="text" name="searchInput" id="searchInput" 
                   value="${query}" placeholder="Search for products...">
            <button type="submit">
                <i class="fas fa-search"></i>
            </button>
        </form>

        <div class="search-results" id="searchResults">
            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>

            <c:if test="${not empty searchResults}">
                <h3>Search Results:</h3>
                <c:forEach var="product" items="${searchResults}">
                    <div class="product-item">
                        <h3>${product.name}</h3>
                        <p>Category: ${product.category}</p>
                        <p>Price: $${product.price}</p>
                        <c:if test="${not empty product.image}">
                            <img src="${product.image}" alt="${product.name}">
                        </c:if>
                    </div>
                </c:forEach>
            </c:if>
            <c:if test="${empty searchResults && not empty searchInput}">
                <div class="info-message">No products found matching your search.</div>
            </c:if>
        </div>
    </div>
</section>


<div class="button-group">    
	        <c:if test="${sessionScope.userRole eq 'admin'}">
	        	<button class="btn-action" onclick="window.location.href='/eCart/allProducts'">
	        		<i class="fas fa-search"></i> Edit Items
	        	</button>
		        <button class="btn-action" onclick="window.location.href='/eCart/addItems'">
		            <i class="fas fa-plus"></i> 
		            Add Items
		        </button>
		        <button class="btn-action" onclick="window.location.href='/eCart/removeItemsPage'">
		            <i class="fas fa-minus"></i> 
		            Remove Items
		        </button>
		    </c:if>
</div>
    
<section class="products">
    <div class="container">
        <h2>Featured Products</h2>
        <form action="/expensiveProducts" method="POST">
        <div class="featured-products">
            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>
            
            <c:if test="${not empty message}">
                <div class="info-message">${message}</div>
            </c:if>
            <c:if test="${not empty topThreeProducts}">
                <c:forEach var="product" items="${topThreeProducts}">
                    <div class="product-item">
                    	<div class="product-image-container">
                    	<img src="<c:url value='/images/${product.productImage}' />" alt="${product.productName}">
                    	</div>
                        <h3>${product.productName}</h3>
                        <p>Rs. ${product.productPrice}</p>
                        <input type="hidden" name="productId_${product.productId}" value="${product.productId}">
                   </div>
                </c:forEach>
            </c:if>
        </div>
        </form>
    </div>
</section>

<div>
    <footer class="footer">
        <div class="container">
            <p>&copy; 2025 E-Cart Solutions. All rights reserved.</p>
        </div>
    </footer>
<div>
	  </body>
</html>

<script>
function searchProducts() {
	document.forms[0].method = "POST";
	document.forms[0].action= "searchProducts";
	document.getElementById("searchForm").submit();
}
function displayFeaturedProducts() {
	document.forms[1].method = "POST";
	document.forms[1].action= "displayFeaturedProducts";
	document.getElementById("featuredProducts").submit();
	}
function searchProducts() {
    document.getElementById("searchForm").submit();
}

function displayFeaturedProducts() {
    document.getElementById("featuredProducts").submit();
}

</script>
