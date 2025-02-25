<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Product</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
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

        .updateProducts {
            padding: 2rem;
            text-align: center;
        }

        .updateProducts h2 {
            color: #28a745;
            margin-bottom: 1.5rem;
        }

        .updateProducts-grid {
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

        .updateProducts-grid label {
            font-size: 1rem;
            color: #333;
            margin: 0.5rem 0;
            text-align: left;
            width: 100%;
        }

        .updateProducts-grid input, .updateProducts-grid select {
            width: 100%;
            padding: 0.5rem;
            margin-bottom: 1rem;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .button-group {
            display: flex;
            justify-content: space-between;
            width: 100%;
            margin-top: 1rem;
        }

        .button-group button {
            background: #FFED29;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
            flex: 1;
            margin: 0 5px;
        }

        .button-group button:hover {
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
    <div class="navbar">
        Update Product
    </div>
    <section class="updateProducts">
        <h2>Update Product Details</h2>
        <form action="${pageContext.request.contextPath}/updateProduct" method="post">
            <div class="updateProducts-grid">
                <img src="<c:url value='src/main/resources/images/${product.productImage}' />" alt="${product.productName}">
                <label for="productId">Product ID:</label>
                <input type="text" id="productId" name="productId" value="${product.productId}" readonly>
                
                <label for="productName">Product Name:</label>
                <input type="text" id="productName" name="productName" value="${product.productName}" readonly>
                
                <label for="productType">Product Type:</label>
                <select id="productType" name="productType">
	                <c:forEach items="${productTypes}" var="type">
	                    <option value="${type}" ${type eq product.productType ? 'selected' : ''}>
	                        ${type}
	                    </option>
	                </c:forEach>
                </select>


                
                <label for="productPrice">Product Price:</label>
                <input type="text" id="productPrice" name="productPrice" value="${product.productPrice}">
                
                <input type="hidden" name="productImage" value="${product.productImage}">
                
                <div class="button-group">
                    <button type="submit">Update Product</button>
                    <button type="button" onclick="location.href='${pageContext.request.contextPath}/allProducts'">Cancel</button>
                </div>
            </div>
        </form>
        <div class="back-to-home">
            <a href="allProducts">Back to Search Products</a>
        </div>
    </section>
</body>
</html>
