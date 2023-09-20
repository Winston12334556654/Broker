<%@ page import="app.daos.ProductDao" %>

<%@ page import="app.model.Product" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/view/header.jsp" %>
<%@ include file="/WEB-INF/view/navbar.jsp" %>

<html>
<head>
    <title>Electronic Devices</title>
    <style>
        /* Your existing CSS styles here */

        /* Add CSS for the product containers */
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
        .product-reaction {
            display: flex;
            justify-content: flex-end; /* Align the reaction button to the right */
            margin-top: 10px; /* Adjust the margin as needed */
        }

        .poke-button {
            background-color: #3498db; /* Button background color */
            color: #fff; /* Button text color */
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
        }

        .poke-button:hover {
            background-color: #2980b9; /* Hover color */
        }
    </style>
</head>
<body>
<h1>Sports</h1>
<c:set var="products" value="<%= new app.daos.ProductDao().getProductsByCategory(12) %>" />
<c:if test="${not empty products}">
    <div class="main-container">
        <c:forEach items="${products}" var="product">
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
                <div class="product-reaction">
                    <!-- Define the URL with a parameter to the "Poke" button -->
                    <button class="poke-button" onclick="pokeProduct( ${product.id})">Poke</button>
                    <!-- You can replace "Poke" with your desired label or icon -->
                </div>
                <div class="image-container">
                    <img src="../productImage/${product.product_image_path}" alt="${product.productName}" class="product-image">
                </div>
                <h2>${product.productName}</h2>
                <p>${product.price}MMK</p>
                <p>Condition: ${condition}</p>

                <c:set var="CustomerDao" value="<%= new app.daos.CustomerDao() %>" />
                <c:set var="seller" value="${CustomerDao.getCustomerById(product.user_id)}" />
                <p>Seller: ${seller.name}</p>
                <p>Contact Info: ${product.contact_info_for_product}</p>
                <!-- Add more information as needed -->
            </div>
        </c:forEach>
    </div>
</c:if>
<c:if test="${empty products}">
    <p>No products found for this category.</p>
</c:if>
<script>
    // Function to handle the confirmation dialog before poking
    function confirmPoke(productId) {
        const confirmation = confirm("Are you sure you want to poke this product?");
        if (confirmation) {
            pokeProduct(productId);
        }
    }

    // Add an event listener to each "poke" button
    document.querySelectorAll(".poke-button").forEach(button => {
        button.addEventListener("click", function () {
            // Get the product ID associated with this button
            const productId = button.getAttribute("data-product-id");

            // Check if the user has already poked this product
            const hasPoked = checkIfUserHasPoked(productId);

            if (!hasPoked) {
                // User hasn't poked this product, ask for confirmation
                confirmPoke(productId);
            }
        });
    });

    // Function to check if the user has already poked the product
    function checkIfUserHasPoked(productId) {
        // You can implement this function to make an AJAX request to the server
        // and check if the user has poked the product based on their session or user ID
        // Return true if the user has poked, false otherwise
        // Example AJAX request:
        // Use fetch or jQuery.ajax to check with the server
        // Replace 'checkPokeStatusUrl' with the actual URL for checking poke status
        // and 'productId' with the product ID

        return fetch(`/checkPokeStatus?productId=${productId}`)
            .then(response => response.json())
            .then(data => {
                return data.hasPoked; // Adjust this based on your server response format
            })
            .catch(error => {
                console.error('Error checking poke status:', error);
                return false; // Assume the check failed, allow the user to poke
            });
    }

    // Function to handle the poke action
    function pokeProduct(productId) {
        // Define the URL for the POST request
        var pokeUrl = '/pokeProduct';

        // Create a FormData object to send data to the server
        var formData = new FormData();
        formData.append('productId', productId);

        // Send a POST request to the server
        fetch(pokeUrl, {
            method: 'POST',
            body: formData,
            credentials: 'same-origin' // Include this if you need to send cookies
        })
            .then(response => {
                if (response.ok) {
                    // Handle success (e.g., update the UI, disable the button)
                    alert("You poked this product successfully!");
                } else if (response.status === 409) {
                    // User has already poked this product, display appropriate message
                    alert("You've already poked this product.");
                } else {
                    // Handle other errors (e.g., display an error message)
                    alert("Error poking this product.");
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }


</script>


<%--<script>--%>
<%--    // Function to handle the confirmation dialog before poking--%>
<%--    function confirmPoke(productId) {--%>
<%--        const confirmation = confirm("Are you sure you want to poke this product?");--%>
<%--        if (confirmation) {--%>
<%--            pokeProduct(productId);--%>
<%--        }--%>
<%--    }--%>

<%--    // Function to check if the user has already poked the product--%>
<%--    function checkIfUserHasPoked(productId) {--%>
<%--        // You can implement this function to make an AJAX request to the server--%>
<%--        // and check if the user has poked the product based on their session or user ID--%>
<%--        // Return true if the user has poked, false otherwise--%>
<%--        // Example AJAX request:--%>
<%--        // Use fetch or jQuery.ajax to check with the server--%>
<%--        // Replace 'checkPokeStatusUrl' with the actual URL for checking poke status--%>
<%--        // and 'productId' with the product ID--%>

<%--        return fetch(`/checkPokeStatus?productId=${productId}`)--%>
<%--            .then(response => response.json())--%>
<%--            .then(data => {--%>
<%--                return data.hasPoked; // Adjust this based on your server response format--%>
<%--            })--%>
<%--            .catch(error => {--%>
<%--                console.error('Error checking poke status:', error);--%>
<%--                return false; // Assume the check failed, allow the user to poke--%>
<%--            });--%>
<%--    }--%>

<%--    // Function to handle the poke action--%>
<%--    function pokeProduct(productId) {--%>
<%--        // Define the URL for the POST request--%>
<%--        var pokeUrl = '/pokeProduct';--%>

<%--        // Create a FormData object to send data to the server--%>
<%--        var formData = new FormData();--%>
<%--        formData.append('productId', productId);--%>

<%--        // Send a POST request to the server--%>
<%--        fetch(pokeUrl, {--%>
<%--            method: 'POST',--%>
<%--            body: formData,--%>
<%--            credentials: 'same-origin' // Include this if you need to send cookies--%>
<%--        })--%>
<%--            .then(response => {--%>
<%--                if (response.ok) {--%>
<%--                    // Handle success (e.g., update the UI, disable the button)--%>
<%--                    alert("You poked this product successfully!");--%>
<%--                } else {--%>
<%--                    // Handle error (e.g., display an error message)--%>
<%--                    alert("Error poking this product.");--%>
<%--                }--%>
<%--            })--%>
<%--            .catch(error => {--%>
<%--                console.error('Error:', error);--%>
<%--            });--%>
<%--    }--%>

<%--    // Add an event listener to each "poke" button--%>
<%--    document.querySelectorAll(".poke-button").forEach(button => {--%>
<%--        button.addEventListener("click", function () {--%>
<%--            // Get the product ID associated with this button--%>
<%--            const productId = button.getAttribute("data-product-id");--%>

<%--            // Check if the user has already poked this product--%>
<%--            const hasPoked = checkIfUserHasPoked(productId);--%>

<%--            if (hasPoked) {--%>
<%--                // Display an alert if the user has already poked this product--%>
<%--                alert("You've already poked this product.");--%>
<%--            } else {--%>
<%--                // User hasn't poked this product, ask for confirmation--%>
<%--                confirmPoke(productId);--%>
<%--            }--%>
<%--        });--%>
<%--    });--%>
<%--</script>--%>


<%--<script>--%>


<%--    // Function to check if the user has already poked the product--%>
<%--    function checkIfUserHasPoked(productId) {--%>
<%--        // You can implement this function to make an AJAX request to the server--%>
<%--        // and check if the user has poked the product based on their session or user ID--%>
<%--        // Return true if the user has poked, false otherwise--%>
<%--        // Example AJAX request:--%>
<%--        // Use fetch or jQuery.ajax to check with the server--%>
<%--        // Replace 'checkPokeStatusUrl' with the actual URL for checking poke status--%>
<%--        // and 'productId' with the product ID--%>

<%--        return fetch(`/checkPokeStatus?productId=${productId}`)--%>
<%--            .then(response => response.json())--%>
<%--            .then(data => {--%>
<%--                return data.hasPoked; // Adjust this based on your server response format--%>
<%--            })--%>
<%--            .catch(error => {--%>
<%--                console.error('Error checking poke status:', error);--%>
<%--                return false; // Assume the check failed, allow the user to poke--%>
<%--            });--%>
<%--    }--%>

<%--    // Function to handle the poke action--%>
<%--    function pokeProduct(productId, button) {--%>
<%--        // Define the URL for the POST request--%>
<%--        var pokeUrl = '/pokeProduct';--%>

<%--        // Create a FormData object to send data to the server--%>
<%--        var formData = new FormData();--%>
<%--        formData.append('productId', productId);--%>

<%--        // Send a POST request to the server--%>
<%--        fetch(pokeUrl, {--%>
<%--            method: 'POST',--%>
<%--            body: formData,--%>
<%--            credentials: 'same-origin' // Include this if you need to send cookies--%>
<%--        })--%>
<%--            .then(response => {--%>
<%--                if (response.ok) {--%>
<%--                    // Handle success (e.g., update the UI, disable the button)--%>
<%--                    alert("You successfully poked this product!");--%>

<%--                    // Disable the button after a successful poke--%>
<%--                    button.disabled = true;--%>
<%--                } else {--%>
<%--                    // Handle error (e.g., display an error message)--%>
<%--                    alert("Error poking this product.");--%>
<%--                }--%>
<%--            })--%>
<%--            .catch(error => {--%>
<%--                console.error('Error:', error);--%>
<%--            });--%>
<%--    }--%>

<%--    // Add an event listener to each "poke" button--%>
<%--    document.querySelectorAll(".poke-button").forEach(button => {--%>
<%--        button.addEventListener("click", function () {--%>
<%--            // Get the product ID associated with this button--%>
<%--            const productId = button.getAttribute("data-product-id");--%>

<%--            // Check if the user has already poked this product--%>
<%--            const hasPoked = checkIfUserHasPoked(productId);--%>

<%--            if (hasPoked) {--%>
<%--                // Display an alert if the user has already poked this product--%>
<%--                alert("Are you sure you want to poked this product? ");--%>
<%--            } else {--%>
<%--                // User hasn't poked this product, proceed with the poke action--%>
<%--                pokeProduct(productId, button); // Pass the button as a parameter--%>
<%--            }--%>
<%--        });--%>
<%--    });--%>


<%--</script>--%>

<%--<script>--%>
<%--    // Add an event listener to each "poke" button--%>
<%--    document.querySelectorAll(".poke-button").forEach(button => {--%>
<%--        button.addEventListener("click", function () {--%>
<%--            // Get the product ID associated with this button--%>
<%--            const productId = button.getAttribute("data-product-id");--%>

<%--            // Check if the user has already poked this product--%>
<%--            const hasPoked = checkIfUserHasPoked(productId);--%>

<%--            if (hasPoked) {--%>
<%--                // Display an alert if the user has already poked this product--%>
<%--                alert("Are you sure you want to poke this product? ");--%>
<%--            } else {--%>
<%--                // User hasn't poked this product, proceed with the poke action--%>
<%--                pokeProduct(productId);--%>

<%--                // Disable the button to prevent further pokes--%>
<%--                button.disabled = true;--%>
<%--            }--%>
<%--        });--%>
<%--    });--%>

<%--    // Function to check if the user has already poked the product--%>
<%--    function checkIfUserHasPoked(productId) {--%>
<%--        // You can implement this function to make an AJAX request to the server--%>
<%--        // and check if the user has poked the product based on their session or user ID--%>
<%--        // Return true if the user has poked, false otherwise--%>
<%--        // Example AJAX request:--%>
<%--        // Use fetch or jQuery.ajax to check with the server--%>
<%--        // Replace 'checkPokeStatusUrl' with the actual URL for checking poke status--%>
<%--        // and 'productId' with the product ID--%>

<%--        return fetch(`/checkPokeStatus?productId=${productId}`)--%>
<%--            .then(response => response.json())--%>
<%--            .then(data => {--%>
<%--                return data.hasPoked; // Adjust this based on your server response format--%>
<%--            })--%>
<%--            .catch(error => {--%>
<%--                console.error('Error checking poke status:', error);--%>
<%--                return false; // Assume the check failed, allow the user to poke--%>
<%--            });--%>
<%--    }--%>

<%--    // Function to handle the poke action--%>
<%--    function pokeProduct(productId) {--%>
<%--        // Define the URL for the POST request--%>
<%--        var pokeUrl = '/pokeProduct';--%>

<%--        // Create a FormData object to send data to the server--%>
<%--        var formData = new FormData();--%>
<%--        formData.append('productId', productId);--%>

<%--        // Send a POST request to the server--%>
<%--        fetch(pokeUrl, {--%>
<%--            method: 'POST',--%>
<%--            body: formData,--%>
<%--            credentials: 'same-origin' // Include this if you need to send cookies--%>
<%--        })--%>
<%--            .then(response => {--%>
<%--                if (response.ok) {--%>
<%--                    // Handle success (e.g., update the UI, disable the button)--%>
<%--                    alert("You successfully poked this product!");--%>
<%--                } else {--%>
<%--                    // Handle error (e.g., display an error message)--%>
<%--                    alert("Error poking this product.");--%>
<%--                }--%>
<%--            })--%>
<%--            .catch(error => {--%>
<%--                console.error('Error:', error);--%>
<%--            });--%>
<%--    }--%>
<%--</script>--%>

</body>
</html>
<%@ include file="/WEB-INF/view/footer.jsp" %>







<%--// Add an event listener to each "poke" button--%>
<%--document.querySelectorAll(".poke-button").forEach(button => {--%>
<%--button.addEventListener("click", function () {--%>
<%--// Get the product ID associated with this button--%>
<%--const productId = button.getAttribute("data-product-id");--%>

<%--// Check if the user has already poked this product--%>
<%--const hasPoked = checkIfUserHasPoked(productId);--%>

<%--if (hasPoked) {--%>
<%--// Display an alert if the user has already poked this product--%>
<%--alert("You have already poked this product.");--%>
<%--} else {--%>
<%--// User hasn't poked this product, proceed with the poke action--%>
<%--pokeProduct(productId);--%>
<%--}--%>
<%--});--%>
<%--});--%>

<%--// Function to check if the user has already poked the product--%>
<%--function checkIfUserHasPoked(productId) {--%>
<%--// You can implement this function to make an AJAX request to the server--%>
<%--// and check if the user has poked the product based on their session or user ID--%>
<%--// Return true if the user has poked, false otherwise--%>
<%--// Example AJAX request:--%>
<%--// Use fetch or jQuery.ajax to check with the server--%>
<%--// Replace 'checkPokeStatusUrl' with the actual URL for checking poke status--%>
<%--// and 'productId' with the product ID--%>

<%--return fetch(`/checkPokeStatus?productId=${productId}`)--%>
<%--.then(response => response.json())--%>
<%--.then(data => {--%>
<%--return data.hasPoked; // Adjust this based on your server response format--%>
<%--})--%>
<%--.catch(error => {--%>
<%--console.error('Error checking poke status:', error);--%>
<%--return false; // Assume the check failed, allow the user to poke--%>
<%--});--%>
<%--}--%>

<%--// Function to handle the poke action--%>
<%--function pokeProduct(productId) {--%>
<%--// Define the URL for the POST request--%>
<%--var pokeUrl = '/pokeProduct';--%>

<%--// Create a FormData object to send data to the server--%>
<%--var formData = new FormData();--%>
<%--formData.append('productId', productId);--%>

<%--// Send a POST request to the server--%>
<%--fetch(pokeUrl, {--%>
<%--method: 'POST',--%>
<%--body: formData,--%>
<%--credentials: 'same-origin' // Include this if you need to send cookies--%>
<%--})--%>
<%--.then(response => {--%>
<%--if (response.ok) {--%>
<%--// Handle success (e.g., update the UI, disable the button)--%>
<%--alert("You successfully poked this product!");--%>
<%--button.disabled = true; // Disable the button after a successful poke--%>
<%--} else {--%>
<%--// Handle error (e.g., display an error message)--%>
<%--alert("Error poking this product.");--%>
<%--}--%>
<%--})--%>
<%--.catch(error => {--%>
<%--console.error('Error:', error);--%>
<%--});--%>
<%--}--%>



















<%--// Function to handle the poke action--%>
<%--function pokeProduct(productId) {--%>
<%--// Define the URL for the POST request--%>
<%--var pokeUrl = '/pokeProduct';--%>

<%--// Create a FormData object to send data to the server--%>
<%--var formData = new FormData();--%>
<%--formData.append('productId', productId);--%>

<%--// Send a POST request to the server--%>
<%--fetch(pokeUrl, {--%>
<%--method: 'POST',--%>
<%--body: formData,--%>
<%--credentials: 'same-origin' // Include this if you need to send cookies--%>
<%--})--%>
<%--.then(response => {--%>
<%--if (response.ok) {--%>
<%--// Handle success (e.g., display a success message)--%>

<%--} else {--%>
<%--// Handle error (e.g., display an error message)--%>
<%--alert("Error poking this product.");--%>
<%--}--%>
<%--})--%>
<%--.catch(error => {--%>
<%--console.error('Error:', error);--%>
<%--});--%>
<%--}--%>