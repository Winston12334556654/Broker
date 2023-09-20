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
            background-image: url('path_to_your_image.jpg'); /* Replace 'path_to_your_image.jpg' with the path to your photo */
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
        <h2>Upload Product</h2>
        <form action="/product/productCreate" method="post" enctype="multipart/form-data">

            <div class="form-group">
                <label for="productName">Product Name</label>
                <label for="price">Price</label>
            </div>

            <div class="form-group">
                <input type="text" id="productName" name="productName" placeholder="Full Product Name" required>
                <input type="text" id="price" name="price" placeholder="000000 Kyat" required>
            </div>

            <div class="form-group">
                <label for="category">Select The Product Category</label>
                <label for="product_status">Product Condition</label>
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
                    <option value="1">Brand New</option>
                    <option value="2">Pre-owned</option>
                    <!-- Add more options as needed -->
                </select>
            </div>

            <div class="form-group">
                <label for="contact_info_for_product">Contact Information</label>
            </div>
            <div>
            <textarea id="contact_info_for_product" name="contact_info_for_product" rows="3"
                      placeholder="Phone number, Address and about your upload product." required></textarea>
            </div>
            <br>
            <div class="form-group">
                <label for="multipartFile">Your Product Photo</label>
                <input type="file" id="multipartFile" name="multipartFile" required>
            </div>

            <button type="submit" class="btn btn-primary">Upload</button>
            <a href="/customer/homeCustomer" class="btn btn-danger float-right">Back</a>

        </form>
    </div>
</div>
</body>
</html>
<script>
    function toggleDropdown() {
        var dropdownList = document.getElementById("dropdownList");
        dropdownList.style.display = (dropdownList.style.display === "none") ? "block" : "none";
    }

    function selectItem(item) {
        var selectedItemInput = document.getElementById("selectedCategory");
        var hiddenCategoryInput = document.getElementById("category");
        selectedItemInput.textContent = item; // Change text content instead of value
        hiddenCategoryInput.value = item;
        toggleDropdown();
    }

    function toggleConditionDropdown() {
        var conditionDropdown = document.getElementById("conditionDropdown");
        conditionDropdown.style.display = (conditionDropdown.style.display === "none") ? "block" : "none";
    }

    function selectCondition(condition) {
        var selectedConditionInput = document.getElementById("selectedCondition");
        var hiddenConditionInput = document.getElementById("product_status");
        selectedConditionInput.textContent = (condition === 1) ? "Brand New" : "Pre-owned"; // Change text content
        hiddenConditionInput.value = condition;
        toggleConditionDropdown();
    }
</script>

</body>
</html>







<%--<%@ include file="/WEB-INF/view/header.jsp" %>--%>
<%--<%@ include file="/WEB-INF/view/navbar.jsp" %>--%>

<%--<title>Create Form</title>--%>
<%--<!-- Add CSS styles here to beautify the form -->--%>
<%--<style>--%>
<%--    body {--%>
<%--        font-family: Arial, sans-serif;--%>
<%--        background-color: #f5f5f5;--%>
<%--    }--%>

<%--    .container {--%>
<%--        max-width: 600px;--%>
<%--        margin: 0 auto;--%>
<%--        padding: 20px;--%>
<%--        background-color: #fff;--%>
<%--        border: 1px solid #ccc;--%>
<%--        border-radius: 5px;--%>
<%--        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);--%>
<%--    }--%>

<%--    .form-group {--%>
<%--        margin-bottom: 20px;--%>
<%--    }--%>

<%--    label {--%>
<%--        font-weight: bold;--%>
<%--    }--%>

<%--    input[type="text"],--%>
<%--    textarea {--%>
<%--        width: 100%;--%>
<%--        padding: 10px;--%>
<%--        border: 1px solid #ccc;--%>
<%--        border-radius: 4px;--%>
<%--    }--%>

<%--    input[type="file"] {--%>
<%--        display: none;--%>
<%--    }--%>

<%--    .custom-file-upload {--%>
<%--        display: inline-block;--%>
<%--        padding: 6px 12px;--%>
<%--        cursor: pointer;--%>
<%--        background-color: #007bff;--%>
<%--        color: #fff;--%>
<%--        border: none;--%>
<%--        border-radius: 4px;--%>
<%--    }--%>

<%--    .custom-file-upload:hover {--%>
<%--        background-color: #0056b3;--%>
<%--    }--%>

<%--    button {--%>
<%--        background-color: #007bff;--%>
<%--        color: #fff;--%>
<%--        border: none;--%>
<%--        border-radius: 4px;--%>
<%--        padding: 10px 20px;--%>
<%--        cursor: pointer;--%>
<%--    }--%>

<%--    button:hover {--%>
<%--        background-color: #0056b3;--%>
<%--    }--%>

<%--    .btn-danger {--%>
<%--        background-color: #dc3545;--%>
<%--        margin-left: 10px;--%>
<%--    }--%>

<%--    .btn-danger:hover {--%>
<%--        background-color: #ac303f;--%>
<%--    }--%>

<%--    .float-right {--%>
<%--        float: right;--%>
<%--    }--%>
<%--    .selection-dropdown {--%>
<%--        position: relative;--%>
<%--        display: inline-block;--%>
<%--    }--%>

<%--    .selected-item {--%>
<%--        background-color: #f0f0f0;--%>
<%--        padding: 10px;--%>
<%--        cursor: pointer;--%>
<%--    }--%>

<%--    .dropdown-list {--%>
<%--        position: absolute;--%>
<%--        top: 100%;--%>
<%--        left: 0;--%>
<%--        background-color: #fff;--%>
<%--        border: 1px solid #ccc;--%>
<%--        display: none;--%>
<%--        z-index: 1;--%>
<%--    }--%>

<%--    .dropdown-item {--%>
<%--        padding: 10px;--%>
<%--        cursor: pointer;--%>
<%--    }--%>

<%--    .dropdown-item:hover {--%>
<%--        background-color: #f0f0f0;--%>
<%--    }--%>
<%--    .btn-primary {--%>
<%--        background-color: #007bff;--%>
<%--        color: #fff;--%>
<%--        border: none;--%>
<%--        border-radius: 4px;--%>
<%--        padding: 10px 20px;--%>
<%--        cursor: pointer;--%>
<%--        float: right; /* Float the "Create" button to the right */--%>
<%--    }--%>

<%--    .btn-primary:hover {--%>
<%--        background-color: #0056b3;--%>
<%--    }--%>

<%--    .btn-danger {--%>
<%--        background-color: #dc3545;--%>
<%--        margin-left: 10px;--%>
<%--        float: left; /* Float the "Back" button to the left */--%>
<%--    }--%>

<%--    .btn-danger:hover {--%>
<%--        background-color: #ac303f;--%>
<%--    }--%>
<%--    .btn-primary {--%>
<%--        background-color: #007bff;--%>
<%--        color: #fff;--%>
<%--        border: none;--%>
<%--        border-radius: 4px;--%>
<%--        padding: 10px 20px;--%>
<%--        cursor: pointer;--%>
<%--        position: absolute; /* Change position to absolute */--%>
<%--        bottom: 100px; /* Adjust the bottom value to move the button up */--%>
<%--        right:460px; /* Adjust the right value to position the button from the right edge */--%>
<%--    }--%>

<%--    .btn-primary:hover {--%>
<%--        background-color: #0056b3;--%>
<%--    }--%>

<%--    .btn-danger {--%>
<%--        background-color: #dc3545;--%>
<%--        margin-left: 10px;--%>
<%--        position: absolute; /* Change position to absolute */--%>
<%--        bottom: 100px; /* Adjust the bottom value to move the button up */--%>
<%--        left: 460px; /* Adjust the left value to position the button from the left edge */--%>
<%--    }--%>

<%--    .btn-danger:hover {--%>
<%--        background-color: #ac303f;--%>
<%--    }--%>
<%--    .selection-dropdown {--%>
<%--        position: relative;--%>
<%--        display: inline-block;--%>
<%--        max-height: 300px; /* Adjust the maximum height as needed */--%>
<%--        overflow: auto;--%>
<%--    }--%>
<%--    .dropdown {--%>
<%--        position: relative;--%>
<%--        display: inline-block;--%>
<%--    }--%>

<%--    .dropdown-label {--%>
<%--        display: block;--%>
<%--        font-weight: bold;--%>
<%--    }--%>

<%--    .dropdown-toggle {--%>
<%--        padding: 10px;--%>
<%--        border: 1px solid #ccc;--%>
<%--        border-radius: 4px;--%>
<%--        cursor: pointer;--%>
<%--    }--%>

<%--    .dropdown-list {--%>
<%--        position: absolute;--%>
<%--        top: 100%;--%>
<%--        left: 0;--%>
<%--        background-color: #fff;--%>
<%--        border: 1px solid #ccc;--%>
<%--        display: none;--%>
<%--        z-index: 1;--%>
<%--    }--%>

<%--    .dropdown-item {--%>
<%--        padding: 10px;--%>
<%--        cursor: pointer;--%>
<%--    }--%>

<%--    .dropdown-item:hover {--%>
<%--        background-color: #f0f0f0;--%>
<%--    }--%>



<%--</style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="container">--%>
<%--    <h1>Upload Product</h1>--%>

<%--    <form action="/product/productCreate" method="post" enctype="multipart/form-data">--%>

<%--        <!-- ... other HTML code ... -->--%>
<%--        <div class="form-group">--%>
<%--            <label for="productName">Product Name</label>--%>
<%--            <input type="text" id="productName" name="productName" required="required">--%>
<%--        </div>--%>

<%--        <div class="dropdown">--%>
<%--            <label class="dropdown-label" for="selectedCategory">Select The Product Category</label>--%>
<%--            <div class="dropdown-toggle" id="selectedCategory" onclick="toggleDropdown()">Select Category</div>--%>
<%--            <div class="dropdown-list" id="dropdownList">--%>

<%--                <div class="dropdown-item" onclick="selectItem(1)">Electronics</div>--%>
<%--                <div class="dropdown-item" onclick="selectItem(2)">Fashion and Apparel</div>--%>
<%--                <div class="dropdown-item" onclick="selectItem(3)">Home and Living</div>--%>
<%--                <div class="dropdown-item" onclick="selectItem(4)">Beauty and Personal care</div>--%>
<%--                <div class="dropdown-item" onclick="selectItem(5)">Health and Fitness</div>--%>
<%--                <div class="dropdown-item" onclick="selectItem(6)">Food and Beverages</div>--%>
<%--                <div class="dropdown-item" onclick="selectItem(7)">Tech Gadgets</div>--%>
<%--                <div class="dropdown-item" onclick="selectItem(8)">Toys and Games</div>--%>
<%--                <div class="dropdown-item" onclick="selectItem(9)">Books and Stationary</div>--%>
<%--                <div class="dropdown-item" onclick="selectItem(10)">Automotive and Accessories</div>--%>
<%--                <div class="dropdown-item" onclick="selectItem(11)">Electrical Appliances</div>--%>
<%--                <div class="dropdown-item" onclick="selectItem(12)">Sports</div>--%>
<%--                <div class="dropdown-item" onclick="selectItem(13)">Arts and Crafts</div>--%>
<%--                <div class="dropdown-item" onclick="selectItem(14)">Jewelry and Accessories</div>--%>
<%--                <div class="dropdown-item" onclick="selectItem(15)">Real Estates</div>--%>
<%--                <div class="dropdown-item" onclick="selectItem(16)">Baby and Kid Products</div>--%>
<%--                <div class="dropdown-item" onclick="selectItem(17)">Pet Supplies</div>--%>
<%--                <div class="dropdown-item" onclick="selectItem(18)">Gardening And Outdoor</div>--%>
<%--                <div class="dropdown-item" onclick="selectItem(19)">Collectibles and Antiques</div>--%>
<%--                <div class="dropdown-item" onclick="selectItem(20)">Travel and Luggage</div>--%>
<%--                <div class="dropdown-item" onclick="selectItem(21)">Others</div>--%>
<%--            </div>--%>
<%--            <input type="hidden" id="category" name="category" value="-1">--%>
<%--        </div>--%>

<%--        <div class="form-group">--%>
<%--            <label for="price">Price</label>--%>
<%--            <input type="text" id="price" name="price" required="true">--%>
<%--        </div>--%>

<%--        <div class="dropdown">--%>
<%--            <label class="dropdown-label" for="selectedCondition">Product Condition</label>--%>
<%--            <div class="dropdown-toggle" id="selectedCondition" onclick="toggleConditionDropdown()">Select Condition</div>--%>
<%--            <div class="dropdown-list" id="conditionDropdown">--%>
<%--                <div class="dropdown-item" onclick="selectCondition(1)">Brand New</div>--%>
<%--                <div class="dropdown-item" onclick="selectCondition(2)">Pre-owned</div>--%>
<%--                <!-- Add more condition options as needed -->--%>
<%--            </div>--%>
<%--            <input type="hidden" id="product_status" name="product_status" value="-1">--%>
<%--        </div>--%>

<%--        <div class="form-group">--%>
<%--            <label for="contact_info_for_product">Contact Info</label>--%>
<%--            <textarea id="contact_info_for_product" name="contact_info_for_product" required="true"></textarea>--%>
<%--        </div>--%>

<%--        <div class="form-group">--%>
<%--            <label for="multipartFile">Your Product Photo</label>--%>
<%--            <label class="custom-file-upload">--%>
<%--                <input type="file" id="multipartFile" name="multipartFile" accept="image/*">--%>
<%--                Upload Photo--%>
<%--            </label>--%>
<%--        </div>--%>


<%--        <a href="/product/productCreateBack" class="btn btn-danger float-left" id="backLink">Back</a>--%>
<%--        <!-- Move the "Create" button inside the form -->--%>
<%--        <button type="submit" class="btn btn-primary float-right">Upload</button>--%>


<%--    </form>--%>

<%--</div>--%>
<%--<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>--%>
<%--<script>--%>



<%--    function toggleDropdown() {--%>
<%--        var dropdownList = document.getElementById("dropdownList");--%>
<%--        dropdownList.style.display = (dropdownList.style.display === "none") ? "block" : "none";--%>
<%--    }--%>

<%--    function selectItem(item) {--%>
<%--        var selectedItemInput = document.getElementById("selectedCategory");--%>
<%--        var hiddenCategoryInput = document.getElementById("category");--%>
<%--        selectedItemInput.textContent = item; // Change text content instead of value--%>
<%--        hiddenCategoryInput.value = item;--%>
<%--        toggleDropdown();--%>
<%--    }--%>

<%--    function toggleConditionDropdown() {--%>
<%--        var conditionDropdown = document.getElementById("conditionDropdown");--%>
<%--        conditionDropdown.style.display = (conditionDropdown.style.display === "none") ? "block" : "none";--%>
<%--    }--%>

<%--    function selectCondition(condition) {--%>
<%--        var selectedConditionInput = document.getElementById("selectedCondition");--%>
<%--        var hiddenConditionInput = document.getElementById("product_status");--%>
<%--        selectedConditionInput.textContent = (condition === 1) ? "Brand New" : "Pre-owned"; // Change text content--%>
<%--        hiddenConditionInput.value = condition;--%>
<%--        toggleConditionDropdown();--%>
<%--    }--%>
<%--</script>--%>
<%--</body>--%>
<%--</html>--%>
<%--<%@ include file="/WEB-INF/view/footer.jsp" %>--%>
