<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/view/header.jsp" %>
<%@ include file="/WEB-INF/view/navbar.jsp" %>
<html>
<head>
    <style>
        /* Your existing styles */


        .posted-products-column {

            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 5px;
            float: left; /* Float the container to the left side */
            clear: left; /* Clear the float */
            width: calc(100% - 40px); /* Adjust the width to account for margin and padding */
            /* Other styles... */
        }
        .product {


            display: flex;

            /*align-items: center;*/
            border: 1px solid #ddd;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 5px;
            box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .product img {
            max-width: 80px; /* Adjust the width of the image */
            max-height: 80px; /* Adjust the height of the image */
            margin-right: 10px;
        }

        .product-details {
            flex: 1;
        }

        /* Adjust the width and center the content container */
        .content-container {
            max-width: 700px;
            padding: 20px;
            margin-left: 20px;
            margin-bottom: 60px; /* Add margin at the bottom to create space for the footer */
        }
        .flex-container {
            display: flex;
            position: fixed;
            top: 200px;
            left: 650px;
            height: 350px;
            width: 350px;
            background-color: dimgrey;
            color: white;
            padding: 20px;
            border-radius: 20px;
            box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .flex-container:hover {
            transform: scale(1.1);
            box-shadow: 0px 5px 20px rgba(0, 0, 0, 0.4); /* Adjust shadow on hover */
        }

        #user-profile {
            flex: 1;
            position: relative; /* Add relative positioning for the "Edit Profile" button */
        }

        .edit-profile-link {
            position: absolute;
            bottom: 10px; /* Adjust the distance from the bottom */
            left: 50%; /* Center the link horizontally */
            transform: translateX(-50%); /* Center the link using transform */
            color: #fff;
            text-decoration: underline;
        }
        .image-container {
            width: 100px; /* Set a fixed width for the container */
            height: 100px; /* Set a fixed height for the container */
            margin-right: 10px;
            border-radius: 50%; /* Make the container appear as a circle */
            overflow: hidden; /* Hide any overflowing content */
            transition: transform 0.3s; /* Add transition for smooth scaling */
            position: relative; /* Position the image container */

            /* Additional styles for hover effect */
            transform-origin: center; /* Set the transform origin to the center of the container */
        }

        /* Style for the image inside the container */
        .image-container img {
            width: 100%; /* Make the image take full width of the container */
            height: 100%; /* Make the image take full height of the container */
            object-fit: cover; /* Ensure the entire image is visible and maintains aspect ratio */
        }

        .image-container:hover {
            transform: scale(1.2); /* Increase the size of the container on hover */
            border-radius: 0; /* Restore the original border-radius on hover */
        }

        #product-list {
            flex: 2; /* Adjust flex property as needed */
            /* Other styling for the product listing section */
        }

        .centered-profile {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start; /* Align content to the top */
            text-align: center;
        }

        /* Adjust alignment and spacing on smaller screens */
        @media (max-width: 768px) {
            .product {
                flex-direction: column; /* Stack the elements vertically on smaller screens */
                align-items: flex-start; /* Align items to the left on smaller screens */
            }

            .product img {
                max-width: 100%; /* Make the image take full width on smaller screens */

                margin-right: 0; /* Remove margin for better spacing */
                margin-bottom: 10px; /* Add some space between product elements */
            }
        }

        /* Add media query for larger screens (e.g., projectors) */
        @media (min-width: 1200px) {
            .product {
                flex-direction: row; /* Reset to original layout on larger screens */
            }

            .product img {
                max-width: 80px; /* Restore original image size on larger screens */
                max-height: 80px; /* Restore original image size on larger screens */
                margin-right: 10px;
                margin-bottom: 0; /* Remove space between product elements */
            }
        }
        .uploaded-products-heading {
            text-align: center; /* Center-align the heading */
            background-color: coral; /* Background color for the heading */
            color: black; /* Text color for the heading */
            padding: 20px; /* Add some padding to the heading for spacing */
            border-radius: 5px; /* Add rounded corners to the heading */
        }

        .uploaded-products-heading h2 {
            margin: 0; /* Remove margin to align text properly within the heading */
            font-size: 24px; /* Adjust the font size as needed */
        }
        #warning-container-wrapper4 {
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

        #warning-container4 {
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

        #warning-container4::before {
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

        #dialog-yes4 {
            background-color: green;
            color: white;
        }

        #dialog-no4 {
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

        .notification-icon {
            position: relative;
            cursor: pointer;
        }

        .notification-dot {
            position: absolute;
            top: 0;
            right: 0;
            background-color: red; /* Red dot color */
            width: 10px;
            height: 10px;
            border-radius: 50%; /* Make it a circle */
            display: none; /* Initially hide the dot */
        }


    </style>

</head>

<body>
<div class="container">

    <div class="content-container">
        <div class="posted-products-column">
            <div class="uploaded-products-heading">
                <h2>Your Uploaded Products</h2>
            </div>
            <div class="posted-products">
                <c:forEach items="${userProducts}" var="product">
                    <div class="product">
                        <img src="../productImage/${product.product_image_path}" alt="Product Image">
                        <div class="product-details">
                            <h2>${product.productName}</h2>
                            <p>${product.price}MMK</p>
                            <!-- ... Other product information ... -->
                            <!-- Add update and delete buttons -->
                            <div>
                                <a href="/updateProduct?id=${product.id}" class="btn btn-primary">Update</a>

                            </div>
                            <br>
                            <div>
                                <form action="/deleteProduct" method="post" class="danger-form">
                                    <input type="hidden" name="id" value="${product.id}">
                                    <button type="submit" class="btn btn-danger" >Delete</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

</div>

<div class="flex-container">
    <div id="user-profile" class="centered-profile">


        <div class="notification-icon">
            <a href="/notification" id="notification-icon">
                <!-- Add your notification icon HTML here -->
                <i class="fas fa-bell"></i> <!-- You can use a suitable icon here -->
                <div class="notification-dot"></div> <!-- Red dot for unread notifications -->
            </a>
        </div>

        <div class="image-container">
            <img src="<c:url value='../productImage/${user.user_image_path}' />" alt="User Profile Image" class="product-image">
            <img src="../productImage/${user.user_image_path}" alt="User Image">
        </div>
        <p>${user.name}</p>
        <p>Email: ${user.mail}</p>
        <p>Phone Number: ${user.phone}</p>
        <p>Address: ${user.address}</p>
        <div>
            <form id="premium-form" action="/tryPremium" method="get">
                <input type="hidden" name="id" value="${user.id}">
                <a href="javascript:void(0);" class="btn btn-primary" onclick="confirmAndUpdate()">Try Premium Membership</a>
            </form>
        </div>
        <br>
        <div>
            <a href="/editProfile?id=${user.id}" class="edit-profile-link">Edit Profile</a>
        </div>

        <div class="notification-content">



            <!-- Notification messages will be displayed here -->
        </div>
    </div>

</div>

<div id="warning-container-wrapper4" style="display: none;">
    <div id="warning-container4">
        <h2>Are you sure to Delete?</h2>
        <div class="dialog-buttons">
            <button class="dialog-button" id="dialog-yes4">Yes</button>
            <button class="dialog-button" id="dialog-no4">No</button>
        </div>
    </div>
</div>

<script>
    function confirmAndUpdate() {
        var confirmed = confirm("Are you sure you want to update to Premium?");
        if (confirmed) {
            document.getElementById("premium-form").submit();
        }
    }
    ////delete

    document.addEventListener("DOMContentLoaded", function () {
        document.querySelectorAll(".danger-form").forEach(function(form) {
            form.addEventListener("submit", function (e) {
                e.preventDefault(); // Prevent the default form submission

                // Show the warning container and blur the background
                document.getElementById("warning-container-wrapper4").style.display = "flex";
                document.body.style.overflow = "hidden";

                // Handle the "yes" button click event
                document.getElementById("dialog-yes4").addEventListener("click", function () {
                    // Submit the form associated with the clicked "Delete" button
                    form.submit(); // Submit the current form
                });

                // Handle the "no" button click event
                document.getElementById("dialog-no4").addEventListener("click", function () {
                    // Hide the warning container and remove the background blur
                    document.getElementById("warning-container-wrapper4").style.display = "none";
                    document.body.style.overflow = "auto";
                });
            });
        });
    });



    // // JavaScript for handling notifications
    // const notificationDot = document.querySelector('.notification-dot');
    // const notificationContent = document.querySelector('.notification-content'); // Add a container for notification content
    //
    // // Simulate unread notifications (you'll fetch real notifications from your server)
    // const hasUnreadNotifications = true;
    //
    // if (hasUnreadNotifications) {
    //     notificationDot.style.display = 'block';
    // }
    //
    // // Add a click event listener to the notification icon
    // notificationIcon.addEventListener('click', () => {
    //     // You can fetch and populate real notification content here
    //     const notificationMessage = 'You have a new notification!';
    //     // Display the notification content
    //     notificationContent.innerHTML = notificationMessage;
    //     // Remove the red dot since the user has seen the notification
    //     notificationDot.style.display = 'none';
    // });

</script>

</body>
</html>
<%@ include file="/WEB-INF/view/footer.jsp" %>





<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<%@ include file="/WEB-INF/view/header.jsp" %>--%>
<%--<%@ include file="/WEB-INF/view/navbar.jsp" %>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <style>--%>
<%--        /* Your existing styles */--%>


<%--        .posted-products-column {--%>

<%--            background-color: #f9f9f9;--%>
<%--            padding: 20px;--%>
<%--            border-radius: 5px;--%>
<%--            float: left; /* Float the container to the left side */--%>
<%--            clear: left; /* Clear the float */--%>
<%--            width: calc(100% - 40px); /* Adjust the width to account for margin and padding */--%>
<%--            /* Other styles... */--%>
<%--        }--%>
<%--        .product {--%>


<%--            display: flex;--%>

<%--            /*align-items: center;*/--%>
<%--            border: 1px solid #ddd;--%>
<%--            padding: 10px;--%>
<%--            margin-bottom: 10px;--%>
<%--            border-radius: 5px;--%>
<%--            box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);--%>
<%--            transition: transform 0.3s, box-shadow 0.3s;--%>
<%--        }--%>

<%--        .product img {--%>
<%--            max-width: 80px; /* Adjust the width of the image */--%>
<%--            max-height: 80px; /* Adjust the height of the image */--%>
<%--            margin-right: 10px;--%>
<%--        }--%>

<%--        .product-details {--%>
<%--            flex: 1;--%>
<%--        }--%>

<%--        /* Adjust the width and center the content container */--%>
<%--        .content-container {--%>
<%--            max-width: 700px;--%>
<%--            padding: 20px;--%>
<%--            margin-left: 20px;--%>
<%--            margin-bottom: 60px; /* Add margin at the bottom to create space for the footer */--%>
<%--        }--%>
<%--        .flex-container {--%>
<%--            display: flex;--%>
<%--            position: fixed;--%>
<%--            top: 200px;--%>
<%--            left: 650px;--%>
<%--            height: 350px;--%>
<%--            width: 350px;--%>
<%--            background-color: dimgrey;--%>
<%--            color: white;--%>
<%--            padding: 20px;--%>
<%--            border-radius: 20px;--%>
<%--            box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.3);--%>
<%--            transition: transform 0.3s, box-shadow 0.3s;--%>
<%--        }--%>

<%--        .flex-container:hover {--%>
<%--            transform: scale(1.1);--%>
<%--            box-shadow: 0px 5px 20px rgba(0, 0, 0, 0.4); /* Adjust shadow on hover */--%>
<%--        }--%>

<%--        #user-profile {--%>
<%--            flex: 1;--%>
<%--            position: relative; /* Add relative positioning for the "Edit Profile" button */--%>
<%--        }--%>

<%--        .edit-profile-link {--%>
<%--            position: absolute;--%>
<%--            bottom: 10px; /* Adjust the distance from the bottom */--%>
<%--            left: 50%; /* Center the link horizontally */--%>
<%--            transform: translateX(-50%); /* Center the link using transform */--%>
<%--            color: #fff;--%>
<%--            text-decoration: underline;--%>
<%--        }--%>
<%--        .image-container {--%>
<%--            width: 100px; /* Set a fixed width for the container */--%>
<%--            height: 100px; /* Set a fixed height for the container */--%>
<%--            margin-right: 10px;--%>
<%--            border-radius: 50%; /* Make the container appear as a circle */--%>
<%--            overflow: hidden; /* Hide any overflowing content */--%>
<%--            transition: transform 0.3s; /* Add transition for smooth scaling */--%>
<%--            position: relative; /* Position the image container */--%>

<%--            /* Additional styles for hover effect */--%>
<%--            transform-origin: center; /* Set the transform origin to the center of the container */--%>
<%--        }--%>

<%--        /* Style for the image inside the container */--%>
<%--        .image-container img {--%>
<%--            width: 100%; /* Make the image take full width of the container */--%>
<%--            height: 100%; /* Make the image take full height of the container */--%>
<%--            object-fit: cover; /* Ensure the entire image is visible and maintains aspect ratio */--%>
<%--        }--%>

<%--        .image-container:hover {--%>
<%--            transform: scale(1.2); /* Increase the size of the container on hover */--%>
<%--            border-radius: 0; /* Restore the original border-radius on hover */--%>
<%--        }--%>

<%--        #product-list {--%>
<%--            flex: 2; /* Adjust flex property as needed */--%>
<%--            /* Other styling for the product listing section */--%>
<%--        }--%>


<%--        .centered-profile {--%>
<%--            display: flex;--%>
<%--            flex-direction: column;--%>
<%--            align-items: center;--%>
<%--            justify-content: flex-start; /* Align content to the top */--%>
<%--            text-align: center;--%>
<%--        }--%>

<%--        /* Adjust alignment and spacing on smaller screens */--%>
<%--        @media (max-width: 768px) {--%>
<%--            .product {--%>
<%--                flex-direction: column; /* Stack the elements vertically on smaller screens */--%>
<%--                align-items: flex-start; /* Align items to the left on smaller screens */--%>
<%--            }--%>

<%--            .product img {--%>
<%--                max-width: 100%; /* Make the image take full width on smaller screens */--%>

<%--                margin-right: 0; /* Remove margin for better spacing */--%>
<%--                margin-bottom: 10px; /* Add some space between product elements */--%>
<%--            }--%>
<%--        }--%>

<%--        /* Add media query for larger screens (e.g., projectors) */--%>
<%--        @media (min-width: 1200px) {--%>
<%--            .product {--%>
<%--                flex-direction: row; /* Reset to original layout on larger screens */--%>
<%--            }--%>

<%--            .product img {--%>
<%--                max-width: 80px; /* Restore original image size on larger screens */--%>
<%--                max-height: 80px; /* Restore original image size on larger screens */--%>
<%--                margin-right: 10px;--%>
<%--                margin-bottom: 0; /* Remove space between product elements */--%>
<%--            }--%>
<%--        }--%>

<%--        /* Style for the premium message */--%>
<%--        .premium-message {--%>
<%--            background-color: #FFD700; /* Set the background color to gold */--%>
<%--            padding: 10px;--%>
<%--            border-radius: 5px;--%>
<%--            text-align: center;--%>
<%--            font-size: 16px;--%>
<%--            font-weight: bold;--%>
<%--            margin-bottom: 20px; /* Add margin at the bottom to separate it from products */--%>
<%--            box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.2);--%>
<%--        }--%>

<%--        /* Additional styles for the premium message on hover */--%>
<%--        .premium-message:hover {--%>
<%--            background-color: #FFA500; /* Change background color on hover to orange */--%>
<%--        }--%>

<%--        .edit-profile-button {--%>
<%--            margin-top: 10px; /* Add margin to move it away from the "Update Premium" button */--%>
<%--        }--%>

<%--    </style>--%>

<%--</head>--%>

<%--<body>--%>
<%--<div class="content-container">--%>

<%--<div class="posted-products-column">--%>
<%--<div class="premium-message">--%>
<%--    View your uploaded products here. Enhance your experience with a premium membership to unlock access to additional content shared by other users.--%>
<%--</div>--%>
<%--<div class="posted-products">--%>
<%--<c:forEach items="${userProducts}" var="product">--%>
<%--    <div class="product">--%>
<%--    <img src="../productImage/${product.product_image_path}" alt="Product Image">--%>
<%--    <div class="product-details">--%>
<%--    <h2>${product.productName}</h2>--%>
<%--    <p>${product.price}MMK</p>--%>
<%--    <!-- ... Other product information ... -->--%>
<%--    <!-- Add update and delete buttons -->--%>
<%--    <div>--%>
<%--    <a href="/updateProduct?id=${product.id}" class="btn btn-primary">Update</a>--%>

<%--    </div>--%>
<%--        <form action="/deleteProduct" method="post">--%>
<%--            <input type="hidden" name="id" value="${product.id}">--%>
<%--            <button type="submit" class="btn btn-danger">Delete</button>--%>
<%--        </form>--%>
<%--    </div>--%>
<%--    </div>--%>
<%--</c:forEach>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>

<%--<div class="flex-container">--%>
<%--    <div id="user-profile" class="centered-profile">--%>

<%--        <div class="image-container">--%>
<%--            <img src="<c:url value='../productImage/${user.user_image_path}' />" alt="User Profile Image" class="product-image">--%>
<%--            <img src="../productImage/${user.user_image_path}" alt="User Image">--%>
<%--        </div>--%>
<%--        <p>${user.name}</p>--%>
<%--        <p>Email: ${user.mail}</p>--%>
<%--        <p>Phone Number: ${user.phone}</p>--%>
<%--        <p>Address: ${user.address}</p>--%>

<%--&lt;%&ndash;        <a href="customer/editProfile?id=${user.id}" class="edit-profile-link">Edit Profile</a>&ndash;%&gt;--%>


<%--        <form id="premium-form" action="/tryPremium" method="get">--%>
<%--            <input type="hidden" name="id" value="${user.id}">--%>
<%--            <a href="javascript:void(0);" class="btn btn-primary" onclick="confirmAndUpdate()">Update to Premium</a>--%>
<%--        </form>--%>


<%--        <div class="edit-profile-button">--%>
<%--            <a href="/editProfile?id=${user.id}" class="edit-profile-link">Edit Profile</a>--%>
<%--        </div>--%>

<%--    </div>--%>

<%--</div>--%>

<%--<script>--%>
<%--    function confirmAndUpdate() {--%>
<%--        var confirmed = confirm("Are you sure you want to update to Premium?");--%>
<%--        if (confirmed) {--%>
<%--            document.getElementById("premium-form").submit();--%>
<%--        }--%>
<%--    }--%>
<%--</script>--%>

<%--</body>--%>
<%--</html>--%>
<%--<%@ include file="/WEB-INF/view/footer.jsp" %>--%>