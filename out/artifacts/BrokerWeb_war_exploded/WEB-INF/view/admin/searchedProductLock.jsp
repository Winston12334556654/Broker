<%@ page import="app.daos.ProductDao" %>
<%@ page import="app.model.Product" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/view/admin/header.jsp" %>
<%@ include file="/WEB-INF/view/admin/navbar.jsp" %>

<html>
<head>
    <title>Search Results</title>
    <style>
        /* Your existing CSS styles */

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }

        /* Add the following style to adjust image size */
        .product-image {
            max-width: 100px; /* Adjust the maximum width as needed */
            max-height: 100px; /* Adjust the maximum height as needed */
        }
    </style>
</head>
<body>
<h1>Search Results</h1>

<%
    String products = request.getParameter("products");
    List<Product> searchResults = new ProductDao().searchProductsByName(products);
%>

<c:choose>
    <c:when test="${not empty searchResults}">
        <table>
            <tr>
                <th>ID</th>
                <th>Product Image</th>
                <th>Product Name</th>
                <th>Price</th>
                <th>Category</th>
                <th>Condition</th>
                <th>User ID</th>
                <th>Contact Info</th>
                <th>Locked</th>
                <th>Ban Unban</th>
            </tr>
            <c:forEach items="${searchResults}" var="product">
                <tr>
                    <td>${product.getId()}</td>
                    <td>
                        <img src="../productImage/${product.product_image_path}" alt="${product.productName}" class="product-image">
                    </td>
                    <td>${product.getProductName()}</td>
                    <td>${product.getPrice()}</td>
                    <td>${product.getCategory()}</td>
                    <td>
                        <c:choose>
                            <c:when test="${product.getProduct_status() == 1}">New</c:when>
                            <c:when test="${product.getProduct_status() == 2}">Used</c:when>
                            <c:otherwise>Unknown</c:otherwise>
                        </c:choose>
                    </td>
                    <td>${product.getUser_id()}</td>
                    <td>${product.getContact_info_for_product()}</td>
                    <td>${product.isLocked()}</td>

                        <%-- Where Id=? hte sha sa hkrum na update galaw na --%>
                    <td>
                        <form action="/toggleSearchBanProduct" method="post" onsubmit="toggleButtonText(this)">
                            <input type="hidden" name="id" value="${product.getId()}">
                            <input type="hidden" name="lockStatus" value="${product.isLocked()}">
                            <input type="hidden" name="products" value="${product.getProductName()}"> <!-- Add the search query parameter -->
                            <button type="submit" class="btn btn-link" name="action" value="toggleStatus">
                                    ${product.isLocked() ? "Unban" : "Ban"}
                            </button>
                        </form>
                    </td>


                </tr>
            </c:forEach>
        </table>
    </c:when>
    <c:otherwise>
        <p>No products found for your search query.</p>
    </c:otherwise>
</c:choose>

<script>
    function toggleButtonText(form) {
        var button = form.querySelector("button");
        if (button.textContent === "Ban") {
            button.textContent = "Unban";
        } else {
            button.textContent = "Ban";
        }
    }
</script>
</body>
</html>

<%@ include file="/WEB-INF/view/admin/footer.jsp" %>