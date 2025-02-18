<c:choose>
    <c:when test="${empty searchResults}">
        <p>No products found.</p>
    </c:when>
    <c:otherwise>
        <ul>
            <c:forEach var="product" items="${searchResults}">
                <li>${product.productName} - ${product.productPrice}</li>
            </c:forEach>
        </ul>
    </c:otherwise>
</c:choose>
