<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="app.daos.ProductDao, app.model.Product, java.util.List" %>

<jsp:include page="/WEB-INF/view/admin/header.jsp" />
<jsp:include page="/WEB-INF/view/admin/navbar.jsp" />
<html>
<head>
    <style>
        /* Your existing CSS styles */

        /* Additional styles for the table */
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
        #warning-container-wrapper2 {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            backdrop-filter: blur(8px); /* Apply background blur effect */
            z-index: 9999;
        }

        #warning-container2 {
            background-color: white;
            padding: 60px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            position: relative;
            width: 80%;
            max-width: 800px;
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        #warning-container2::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(255, 255, 255, 0.5);
            z-index: -1;
        }

        .dialog-buttons {
            display: flex;
            justify-content: center;
            margin-top: 30px;
        }

        .dialog-button {
            margin: 0 10px;
            padding: 10px 20px;
            border: none;
            border-radius: 20px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease-in-out;
        }

        #dialog-yes2 {
            background-color: green;
            color: white;
        }

        #dialog-no2 {
            background-color: red;
            color: white;
        }

        .dialog-button:hover {
            background-color: #333;
        }

        /* Styles for the dropdown menu */
        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropdown:hover .dropdown-content {
            display: block;
            opacity: 1;
            transform: translateY(0);
        }

    </style>
</head>
<body>
<div class="container">
    <h1>View Products</h1>

    <%-- Retrieve the list of products from the request attribute --%>
    <c:set var="products" value="${requestScope.products}" />

    <table class="table">
        <thead class="thead-dark">
        <tr>

            <th scope="col">Product Item Id</th>
            <th scope="col">Image</th>
            <th scope="col">Product Name</th>
            <th scope="col">Price</th>
            <th scope="col">User Id</th>
            <th scope="col">Contact Info</th>
            <th scope="col">Image Path</th>
            <th scope="col">Status</th>
            <th scope="col">Product Lock</th>
            <th scope="col">Ban/Unban</th>

        </tr>
        </thead>
        <tbody>
        <c:forEach items="${products}" var="product">
            <tr>

                <td>${product.getProduct_item_id()}</td>
                <td><img src="../productImage/${product.product_image_path}" alt="${product.getProductName()}" class="product-image"></td>
                <td>${product.getProductName()}</td>
                <td>${product.getPrice()}</td>

                <c:set var="CustomerDao" value="<%= new app.daos.CustomerDao() %>" />
                <c:set var="seller" value="${CustomerDao.getCustomerById(product.user_id)}" />
                <td>${seller.name}</td>
                <td>${product.getContact_info_for_product()}</td>
                <td>${product.getProduct_image_path()}</td>

                <td>
                    <c:choose>
                        <c:when test="${product.getProduct_status() == 1}">
                            Brand New
                        </c:when>
                        <c:when test="${product.getProduct_status() == 2}">
                            Pre Owned
                        </c:when>
                        <c:otherwise>
                            Unknown
                        </c:otherwise>
                    </c:choose>
                </td>

                <td>${product.isLocked()}</td>

                <td>
                    <form action="/toggleProductLock" method="post" >
                        <input type="hidden" name="id" value="${product.getId()}">
                        <input type="hidden" name="lockStatus" value="${product.isLocked()}">
                        <button type="submit" class="btn btn-link banP-button" name="action" value="toggleStatus">
                                ${product.isLocked() ? "Unban" : "Ban"}
                        </button>
                    </form>
                </td>

            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<div id="warning-container-wrapper2" style="display: none;">
    <div id="warning-container2">
        <h2>Are you sure ?</h2>
        <div class="dialog-buttons">
            <button class="dialog-button" id="dialog-yes2">Yes</button>
            <button class="dialog-button" id="dialog-no2">No</button>
        </div>
    </div>
</div>
<script>
    ///for product ban
    document.addEventListener("DOMContentLoaded", function () {
        // JavaScript code to handle the ban and unban button click events
        const banButtons = document.querySelectorAll(".banP-button");

        function showConfirmationDialog(dialogId) {
            // Show the specified dialog and blur the background
            document.getElementById(dialogId).style.display = "flex";
            document.body.style.overflow = "hidden";
        }

        function hideConfirmationDialog(dialogId) {
            // Hide the specified dialog and remove the background blur
            document.getElementById(dialogId).style.display = "none";
            document.body.style.overflow = "auto";
        }

        banButtons.forEach(function (banButton) {
            banButton.addEventListener("click", function (e) {
                e.preventDefault(); // Prevent the default link behavior
                showConfirmationDialog("warning-container-wrapper2");

    // Set up the "Yes" button action to continue with the form submission
                document.getElementById("dialog-yes2").addEventListener("click", function () {
                    // Submit the form associated with the clicked button
                    const form = e.target.closest("form");
                    if (form) {
                        form.submit();
                    }
                });

                // Handle the "No" button click event
                document.getElementById("dialog-no2").addEventListener("click", function () {
                    hideConfirmationDialog("warning-container-wrapper2");
                });
            });
        });
    });
</script>
</body>
</html>

<jsp:include page="/WEB-INF/view/admin/footer.jsp" />



<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<%--<%@ page import="app.daos.ProductDao, app.model.Product, java.util.List" %>--%>

<%--<jsp:include page="/WEB-INF/view/admin/header.jsp" />--%>
<%--<jsp:include page="/WEB-INF/view/admin/navbar.jsp" />--%>
<%--<html>--%>
<%--<head>--%>
<%--    <style>--%>
<%--        /* Your existing CSS styles */--%>

<%--        /* Additional styles for the table */--%>
<%--        table {--%>
<%--            width: 100%;--%>
<%--            border-collapse: collapse;--%>
<%--            margin-top: 20px;--%>
<%--        }--%>
<%--        th, td {--%>
<%--            border: 1px solid #dddddd;--%>
<%--            text-align: left;--%>
<%--            padding: 8px;--%>
<%--        }--%>
<%--        th {--%>
<%--            background-color: #f2f2f2;--%>
<%--        }--%>

<%--        /* Add the following style to adjust image size */--%>
<%--        .product-image {--%>
<%--            max-width: 100px; /* Adjust the maximum width as needed */--%>
<%--            max-height: 100px; /* Adjust the maximum height as needed */--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="container">--%>
<%--    <h1>View Products</h1>--%>

<%--    &lt;%&ndash; Retrieve the list of products from the request attribute &ndash;%&gt;--%>
<%--    <c:set var="products" value="${requestScope.products}" />--%>

<%--    <table class="table">--%>
<%--        <thead class="thead-dark">--%>
<%--        <tr>--%>

<%--            <th scope="col">Product Item Id</th>--%>
<%--            <th scope="col">Image</th>--%>
<%--            <th scope="col">Product Name</th>--%>
<%--            <th scope="col">Price</th>--%>
<%--            <th scope="col">User Id</th>--%>
<%--            <th scope="col">Contact Info</th>--%>
<%--            <th scope="col">Image Path</th>--%>
<%--            <th scope="col">Status</th>--%>
<%--            <th scope="col">Product Lock</th>--%>
<%--            <th scope="col">Ban/Unban</th>--%>

<%--        </tr>--%>
<%--        </thead>--%>
<%--        <tbody>--%>
<%--        <c:forEach items="${products}" var="product">--%>
<%--            <tr>--%>

<%--                <td>${product.getProduct_item_id()}</td>--%>
<%--                <td><img src="../productImage/${product.product_image_path}" alt="${product.getProductName()}" class="product-image"></td>--%>
<%--                <td>${product.getProductName()}</td>--%>
<%--                <td>${product.getPrice()}</td>--%>

<%--                <c:set var="CustomerDao" value="<%= new app.daos.CustomerDao() %>" />--%>
<%--                <c:set var="seller" value="${CustomerDao.getCustomerById(product.user_id)}" />--%>
<%--                <td>${seller.name}</td>--%>
<%--                <td>${product.getContact_info_for_product()}</td>--%>
<%--                <td>${product.getProduct_image_path()}</td>--%>

<%--                <td>--%>
<%--                    <c:choose>--%>
<%--                        <c:when test="${product.getProduct_status() == 1}">--%>
<%--                            Brand New--%>
<%--                        </c:when>--%>
<%--                        <c:when test="${product.getProduct_status() == 2}">--%>
<%--                            Pre Owned--%>
<%--                        </c:when>--%>
<%--                        <c:otherwise>--%>
<%--                            Unknown--%>
<%--                        </c:otherwise>--%>
<%--                    </c:choose>--%>
<%--                </td>--%>

<%--                <td>${product.isLocked()}</td>--%>

<%--                <td>--%>
<%--                    <form action="/toggleProductLock" method="post" >--%>
<%--                        <input type="hidden" name="id" value="${product.getId()}">--%>
<%--                        <input type="hidden" name="lockStatus" value="${product.isLocked()}">--%>
<%--                        <button type="submit" class="btn btn-link" name="action" value="toggleStatus">--%>
<%--                                ${product.isLocked() ? "Unban" : "Ban"}--%>
<%--                        </button>--%>
<%--                    </form>--%>
<%--                </td>--%>



<%--            </tr>--%>
<%--        </c:forEach>--%>
<%--        </tbody>--%>
<%--    </table>--%>
<%--</div>--%>

<%--</body>--%>
<%--</html>--%>


<%--<jsp:include page="/WEB-INF/view/admin/footer.jsp" />--%>