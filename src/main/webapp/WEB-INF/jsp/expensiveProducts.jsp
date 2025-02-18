<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="product-grid">
    <c:choose>
        <c:when test="${not empty topThreeProducts}">
            <c:forEach var="product" items="${topThreeProducts}">
                <div class="product-item">
                    <h3>${product.productName}</h3>
                    <p>Rs. ${product.productPrice}</p>
                    <form action="${pageContext.request.contextPath}/addToCart" method="POST">
                        <input type="hidden" name="productId" value="${product.productId}">
                        <button type="submit" onClick="getFormDetails('${product.productId}', '${product.productName}', '${product.productType}', '${product.productPrice}')">
                            <i class="fas fa-cart-plus"></i> Add to Cart
                        </button>
                    </form>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p>No featured products available.</p>
        </c:otherwise>
    </c:choose>
</div>