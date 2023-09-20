<%@ page import="app.daos.ProductDao" %>
<%@ page import="app.model.Product" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/view/header.jsp" %>
<%@ include file="/WEB-INF/view/navbar.jsp" %>

<html>
<head>
    <title>Search Results</title>
    <style>
        .main-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            margin-left: 20px; /* Adjust the left margin for the entire container area */
        }

        .product-container {
            width: calc(30% - 15px); /* 50% width with some margin */
            background-color: #ffffff;
            padding: 10px;
            margin-bottom: 20px; /* Space between containers vertically */
            margin-right: 40px; /* Space between containers horizontally */
            border-radius: 10px;

            padding: 10px 15px; /* Adjust padding for top and bottom, and add left padding */

            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .product-container h2,
        .product-container p {
            padding-left: 19px; /* Adjust the padding as needed */
        }

        /* Hover styles for the product containers */
        .product-container:hover {
            transform: scale(1.05);
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.3);
        }
        .image-container {
            width: 100%; /* Ensure the container takes full width */
            height: 200px; /* Set the desired height for the image */
            overflow: hidden; /* Hide any overflowing content */
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Style for the images */
        .product-image {
            max-width: 100%; /* Ensure the image doesn't exceed its container */
            max-height: 100%; /* Ensure the image doesn't exceed its container */
        }
    </style>
</head>
<body>


<%
    String query = request.getParameter("query");
    List<Product> searchResults = new ProductDao().searchProductsByName(query);
%>

<c:choose>
    <c:when test="${not empty searchResults}">
        <div class="main-container">
            <c:forEach items="${searchResults}" var="product">
                <!-- Create a mapping between numeric condition values and alphabet representations -->
                <c:set var="conditionMap">
                    <c:choose>
                        <c:when test="${product.product_status == 1}">
                            <c:set var="condition" value="New" />
                        </c:when>
                        <c:when test="${product.product_status == 2}">
                            <c:set var="condition" value="Used" />
                        </c:when>
                        <c:otherwise>
                            <c:set var="condition" value="Unknown" />
                        </c:otherwise>
                    </c:choose>
                </c:set>

                <div class="product-container">
                    <div class="image-container">
                        <img src="../productImage/${product.product_image_path}" alt="${product.productName}" class="product-image">
                    </div>
                    <h2>${product.productName}</h2>
                    <p>Price : ${product.price}MMK</p>
                    <p>Condition: ${condition}</p>

                    <c:set var="CustomerDao" value="<%= new app.daos.CustomerDao() %>" />
                    <c:set var="seller" value="${CustomerDao.getCustomerById(product.user_id)}" />
                    <p>Seller: ${seller.name}</p>
                    <p>Contact Info: ${product.contact_info_for_product}</p>
                    <!-- Add more information as needed -->
                </div>
            </c:forEach>
        </div>
    </c:when>
    <c:otherwise>
        <p>No products found for your search query.</p>
    </c:otherwise>
</c:choose>

</body>
</html>

<%@ include file="/WEB-INF/view/footer.jsp" %>
