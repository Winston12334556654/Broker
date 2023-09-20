<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<%@ include file="/WEB-INF/view/header.jsp" %>--%>
<%--<%@ include file="/WEB-INF/view/navbar.jsp" %>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <title>Update Product</title>--%>
<%--    <!-- Include your CSS styles here -->--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="content-container">--%>
<%--    <div class="update-product-form">--%>
<%--        <h2>Update Product</h2>--%>
<%--        <form action="/updateProduct" method="post" enctype="multipart/form-data">--%>
<%--            <input type="hidden" name="id" value="${product.id}">--%>

<%--            <div class="form-group">--%>
<%--                <label for="productName">Product Name</label>--%>
<%--                <input type="text" id="productName" name="productName" value="${product.productName}" required>--%>
<%--            </div>--%>

<%--            <div class="form-group">--%>
<%--                <label for="price">Price</label>--%>
<%--                <input type="number" id="price" name="price" value="${product.price}" required>--%>
<%--            </div>--%>

<%--            <div class="form-group">--%>
<%--                <label for="category">Category</label>--%>
<%--                <select id="category" name="category" required>--%>
<%--                    <option value="1" ${product.category == 1 ? 'selected' : ''}>Electronics</option>--%>
<%--                    <option value="2" ${product.category == 2 ? 'selected' : ''}>Fashion and Apparel</option>--%>
<%--                    <option value="3" ${product.category == 3 ? 'selected' : ''}>Home and Living</option>--%>
<%--                    <option value="4" ${product.category == 4 ? 'selected' : ''}>Beauty and Personal Care</option>--%>
<%--                    <option value="5" ${product.category == 5 ? 'selected' : ''}>Health and Fitness</option>--%>
<%--                    <option value="6" ${product.category == 6 ? 'selected' : ''}>Food and Beverages</option>--%>
<%--                    <option value="7" ${product.category == 7 ? 'selected' : ''}>Tech Gadgets</option>--%>
<%--                    <option value="8" ${product.category == 8 ? 'selected' : ''}>Toys and Games</option>--%>
<%--                    <option value="9" ${product.category == 9 ? 'selected' : ''}>Books and Stationary</option>--%>
<%--                    <option value="10" ${product.category == 10 ? 'selected' : ''}>Automotive and Accessories </option>--%>
<%--                    <option value="11" ${product.category == 11 ? 'selected' : ''}>Electrical Appliances</option>--%>
<%--                    <option value="12" ${product.category == 12 ? 'selected' : ''}>Sports</option>--%>
<%--                    <option value="13" ${product.category == 13 ? 'selected' : ''}>Arts and Crafts</option>--%>
<%--                    <option value="14" ${product.category == 14 ? 'selected' : ''}>Jewelry and Accessories</option>--%>
<%--                    <option value="15" ${product.category == 15 ? 'selected' : ''}>Real Estates</option>--%>
<%--                    <option value="16" ${product.category == 16 ? 'selected' : ''}>Baby and Kid Products</option>--%>
<%--                    <option value="17" ${product.category == 17 ? 'selected' : ''}>Pet Supplies</option>--%>
<%--                    <option value="18" ${product.category == 18 ? 'selected' : ''}>Gardening and Outdoor</option>--%>
<%--                    <option value="19" ${product.category == 19 ? 'selected' : ''}>Collectible and Antiques</option>--%>
<%--                    <option value="20" ${product.category == 20 ? 'selected' : ''}>Travel and Luggage</option>--%>
<%--                    <option value="21" ${product.category == 21 ? 'selected' : ''}>Others</option>--%>


<%--                    <!-- Add more options for categories as needed -->--%>
<%--                </select>--%>
<%--            </div>--%>

<%--            <div class="form-group">--%>
<%--                <label for="product_status">Product Status</label>--%>
<%--                <select id="product_status" name="product_status" required>--%>
<%--                    <option value="1" ${product.product_status == 1 ? 'selected' : ''}>Brand New</option>--%>
<%--                    <option value="2" ${product.product_status == 2 ? 'selected' : ''}>Pre Owned</option>--%>
<%--                    <!-- Add more options for product status as needed -->--%>
<%--                </select>--%>
<%--            </div>--%>

<%--            <div class="form-group">--%>
<%--                <label for="contact_info_for_product">Contact Information</label>--%>
<%--                <input type="text" id="contact_info_for_product" name="contact_info_for_product" value="${product.contact_info_for_product}" required>--%>
<%--            </div>--%>

<%--            <div class="form-group">--%>
<%--                <label for="productImage">Product Image</label>--%>
<%--                <input type="file" id="productImage" name="productImage">--%>
<%--            </div>--%>

<%--            <button type="submit" class="btn btn-primary">Update Product</button>--%>
<%--        </form>--%>
<%--    </div>--%>
<%--</div>--%>
<%--</body>--%>
<%--</html>--%>
<%--<%@ include file="/WEB-INF/view/footer.jsp" %>--%>



<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Form</title>
    <style>
        /* CSS styling for the login form */
        body {
            background: linear-gradient(to bottom, #c6d2e1, #C4C1A0);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: Arial, sans-serif;
        }
        .container {
            width: 450px;
            padding: 40px;

            background-size: cover;
            background-position: center;
            border-radius: 30px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s, background-color 0.3s;
            position: relative;
            overflow: hidden;
            text-align: center; /* Center the content within the container */
        }
        .container:before {
            content: '';
            position: absolute;
            top: -30px;
            left: -30px;
            right: -30px;
            bottom: -30px;
            z-index: -1;
            background: linear-gradient(to bottom, rgba(255, 255, 255, 0.6), rgba(0, 0, 0, 0.2));
            border-radius: 30px;
        }
        .container:hover {
            transform: scale(1.05);
            background-color: #f4f7f9;
        }
        h1 {
            text-align: center;
            color: #555;
            margin-bottom: 30px;
            font-weight: bold;
            font-family: 'EB Garamond', Arial, sans-serif;
            font-size: 26px;
            text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3);
            display: inline-block;
            margin-right: 10px; /* Adjust the margin as per your preference */
        }
        h1 span {
            display: inline-block;
            padding: 5px 10px;
            border: 2px solid #555;
            border-radius: 8px;
        }
        h1 span em {
            font-style: italic; /* Make the word "Chate" italic */
        }
        h2 {
            text-align: center;
            color: #555;
            margin-bottom: 30px;
            text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3); /* Add shadow effect */
            font-style: italic; /* Make the "Sign in to ShalChate" italic */
        }
        input[type="text"], input[type="email"], input[type="password"], input[type="number"],input[type="file"] {
            width: 50%;
            padding: 8px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }
        button[type="submit"] {
            width: 20%;
            padding: 20px; /* Increase padding to make the button larger */
            margin-bottom: 20px;
            background-color: antiquewhite; /* Change the background color to blue */
            color: black; /* Set text color to white for better contrast */
            border: 1px solid #ccc;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            text-align: left;
        }
        select#category, select#product_status {
            border-radius: 4px;
            width: 50%; /* Make the width match other input fields */
            padding: 8px; /* Adjust the padding as needed */
            font-size: 14px; /* Match the font size with other input fields */
        }

        .create-account {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
        }
        .create-account a {
            color: #4CAF50;
            text-decoration: none;
        }
        /* Additional styling */
        .container {
            border: 2px solid #ccc;
        }
        h2 {
            text-transform: uppercase;
            font-weight: bold;
        }
        input[type="text"], input[type="email"], input[type="password"],input[type="file"],input[type="number"]{
            border-radius: 5px;
        }
        .form-group {
            display: flex;
            align-items: center;
            margin-bottom: 20px; /* Add margin between input groups */
        }
        label {
            display: block; /* Make labels full-width to stack them vertically */
            margin-bottom: 5px; /* Add spacing between label and input */
            font-weight: bold; /* Enhance label readability */
            flex: 1;
            margin-right: 10px;
        }
        textarea {
            border-radius: 5px;
            width: 100%;
            padding: 8px;
            font-size: 14px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            resize: vertical; /* Allow vertical resizing of textarea */
        }
        }
        .create-account a {
            color: #000;
        }
        /* Style for the error message */
        .error {
            color: red;
        }
    </style> <!-- Add your head content here -->
</head>
<body>
<div class="container col-md-6 offset-md-3">
    <div class="update-product-form">
        <h2>Update Product</h2>
        <form action="/updateProduct" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="${product.id}">

            <div class="form-group">
                <label for="productName">Product Name</label>
                <label for="price">Price</label>
            </div>

            <div class="form-group">
                <input type="text" id="productName" name="productName" value="${product.productName}" required>
                <input type="number" id="price" name="price" value="${product.price}" required>
            </div>

            <div class="form-group">
                <label for="category">Category</label>
                <label for="product_status">Product Status</label>
            </div>

            <div class="form-group">
                <select id="category" name="category" required>
                    <option value="1" ${product.category == 1 ? 'selected' : ''}>Electronics</option>
                    <option value="2" ${product.category == 2 ? 'selected' : ''}>Fashion and Apparel</option>
                    <option value="3" ${product.category == 3 ? 'selected' : ''}>Home and Living</option>
                    <option value="4" ${product.category == 4 ? 'selected' : ''}>Beauty and Personal Care</option>
                    <option value="5" ${product.category == 5 ? 'selected' : ''}>Health and Fitness</option>
                    <option value="6" ${product.category == 6 ? 'selected' : ''}>Food and Beverages</option>
                    <option value="7" ${product.category == 7 ? 'selected' : ''}>Tech Gadgets</option>
                    <option value="8" ${product.category == 8 ? 'selected' : ''}>Toys and Games</option>
                    <option value="9" ${product.category == 9 ? 'selected' : ''}>Books and Stationary</option>
                    <option value="10" ${product.category == 10 ? 'selected' : ''}>Automotive and Accessories </option>
                    <option value="11" ${product.category == 11 ? 'selected' : ''}>Electrical Appliances</option>
                    <option value="12" ${product.category == 12 ? 'selected' : ''}>Sports</option>
                    <option value="13" ${product.category == 13 ? 'selected' : ''}>Arts and Crafts</option>
                    <option value="14" ${product.category == 14 ? 'selected' : ''}>Jewelry and Accessories</option>
                    <option value="15" ${product.category == 15 ? 'selected' : ''}>Real Estates</option>
                    <option value="16" ${product.category == 16 ? 'selected' : ''}>Baby and Kid Products</option>
                    <option value="17" ${product.category == 17 ? 'selected' : ''}>Pet Supplies</option>
                    <option value="18" ${product.category == 18 ? 'selected' : ''}>Gardening and Outdoor</option>
                    <option value="19" ${product.category == 19 ? 'selected' : ''}>Collectible and Antiques</option>
                    <option value="20" ${product.category == 20 ? 'selected' : ''}>Travel and Luggage</option>
                    <option value="21" ${product.category == 21 ? 'selected' : ''}>Others</option>
                </select>
                <select id="product_status" name="product_status" required>
                    <option value="1" ${product.product_status == 1 ? 'selected' : ''}>Brand New</option>
                    <option value="2" ${product.product_status == 2 ? 'selected' : ''}>Pre Owned</option>
                    <!-- Add more options for product status as needed -->
                </select>
            </div>

            <div class="form-group">
                <label for="contact_info_for_product">Contact Imformation</label>
            </div>
            <div class="form-group">
                <textarea id="contact_info_for_product" name="contact_info_for_product" rows="3" required>${product.contact_info_for_product}</textarea>
            </div>

            <div class="form-group">
                <label for="productImage">Product Image</label>
                <input type="file" id="productImage" name="productImage">
            </div><br>

            <div style="text-align: center">
                <button type="submit" class="btn btn-primary">Update</button>
            </div>
            <a href="/customer/homeCustomer" class="btn btn-danger float-right">Back</a>


        </form>
    </div>
</div>
</body>
</html>
