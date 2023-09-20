
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
        input[type="text"], input[type="email"], input[type="password"], input[type="number"],input[type="file"],input[type="tel"]{
            width: 50%;
            padding: 8px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }
        input[type="address"]{
            width: 100%;
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
        select#category, select#productStatus {
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
        input[type="text"], input[type="email"], input[type="password"],input[type="file"],input[type="number"],input[type="tel"],input[type="address"]{
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
    <div class="register-form">
        <h1><span>Shal<em>Chate</em></span></h1>
        <h2>Register form</h2>

        <form action="/customer/customerCreate" method="post" onsubmit="return validateForm()" enctype="multipart/form-data">

            <div class="form-group">
                <label for="name">Full Name</label>
                <label for="profileImage">Profile Image</label>
            </div>

            <div class="form-group">
                <input type="text" class="form-control" id="name" name="name" pattern="[A-Za-z ]+" required="true"
                       title="Please enter a valid name (only letters and spaces are allowed)" placeholder="Your name">
                <input type="file" class="form-control-file" id="profileImage" name="profileImage">
            </div>

            <div class="form-group">
                <label for="password">Password </label>
                <span class="error" id="passwordMismatchError"></span>
                <label for="confirmPassword">Confirm Password</label>
            </div>

            <div class = "form-group">
                <input type="password" class="form-control" id="password" name="password"placeholder="at least 8 characters"
                       pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*_])[a-zA-Z0-9!@#$%^&*_]{8,}$"
                       required="true" title="Password must contain 1 uppercase, 1 lowercase,special character and at least 8 letters">
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm your Password">
            </div>

            <div class="form-group">
                <label for="mail">Email</label>
                <label for="phone">Phone Number</label>
            </div>

            <div class="form-group">
                <input type="email" class="form-control" id="mail" name="mail" placeholder="Example@gmail.com"
                       pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" required>
                <input type="tel" class="form-control" id="phone" name="phone"  placeholder="09/+959" required>
                <span class="error" id="phoneMismatchError"></span>
            </div>

            <div class="form-group">
                <label for="address">Address</label>
            </div>

            <div class="form-group">
                <input type="address" class="form-control" id="address" name="address"placeholder="Street, City, Country" required>
            </div>


            <button type="submit" class="btn btn-primary">Create</button>
            <a href="/" class="btn btn-danger float-right">Back</a>
        </form>
    </div>
</div>
</body>
</html>

<script>
    function validateForm() {
        var password = document.getElementById("password").value;
        var confirmPassword = document.getElementById("confirmPassword").value;
        var passwordMismatchError = document.getElementById("passwordMismatchError");
        var phoneMismatchError = document.getElementById("phoneMismatchError");
        var phone = document.getElementById("phone").value;
        var phoneRegex = /^(09|\+959)\d{8,9}$/; // Myanmar phone number format regex

        if (password.length < 8) {
            passwordMismatchError.innerText = "Password must be at least 8 characters";
            return false; // Prevent form submission
        } else if (password !== confirmPassword) {
            passwordMismatchError.innerText = "(Passwords do not match)";
            passwordMismatchError.style.color = "red";
            return false; // Prevent form submission
        } else if (!phone.match(phoneRegex)) {
            // Check if phone number matches the Myanmar phone number format
            phoneMismatchError.innerText = "Please enter a valid Myanmar phone number";
            phoneMismatchError.style.color = "red";
            return false; // Prevent form submission
        } else {
            passwordMismatchError.innerText = ""; // Clear any previous error message
            return true; // Allow form submission
        }
    }
</script>








<%--







--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<html lang="en">--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--    <title>Login Form</title>--%>
<%--    <style>--%>
<%--        /* CSS styling for the login form */--%>
<%--        body {--%>
<%--            background: linear-gradient(to bottom, #c6d2e1, #C4C1A0);--%>
<%--            display: flex;--%>
<%--            justify-content: center;--%>
<%--            align-items: center;--%>
<%--            height: 100vh;--%>
<%--            font-family: Arial, sans-serif;--%>
<%--        }--%>
<%--        .container {--%>
<%--            width: 450px;--%>
<%--            padding: 40px;--%>
<%--            background-image: url('path_to_your_image.jpg'); /* Replace 'path_to_your_image.jpg' with the path to your photo */--%>
<%--            background-size: cover;--%>
<%--            background-position: center;--%>
<%--            border-radius: 30px;--%>
<%--            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);--%>
<%--            transition: transform 0.3s, background-color 0.3s;--%>
<%--            position: relative;--%>
<%--            overflow: hidden;--%>
<%--            text-align: center; /* Center the content within the container */--%>
<%--        }--%>
<%--        .container:before {--%>
<%--            content: '';--%>
<%--            position: absolute;--%>
<%--            top: -30px;--%>
<%--            left: -30px;--%>
<%--            right: -30px;--%>
<%--            bottom: -30px;--%>
<%--            z-index: -1;--%>
<%--            background: linear-gradient(to bottom, rgba(255, 255, 255, 0.6), rgba(0, 0, 0, 0.2));--%>
<%--            border-radius: 30px;--%>
<%--        }--%>
<%--        .container:hover {--%>
<%--            transform: scale(1.05);--%>
<%--            background-color: #f4f7f9;--%>
<%--        }--%>
<%--        h1 {--%>
<%--            text-align: center;--%>
<%--            color: #555;--%>
<%--            margin-bottom: 30px;--%>
<%--            font-weight: bold;--%>
<%--            font-family: 'EB Garamond', Arial, sans-serif;--%>
<%--            font-size: 26px;--%>
<%--            text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3);--%>
<%--            display: inline-block;--%>
<%--            margin-right: 10px; /* Adjust the margin as per your preference */--%>
<%--        }--%>
<%--        h1 span {--%>
<%--            display: inline-block;--%>
<%--            padding: 5px 10px;--%>
<%--            border: 2px solid #555;--%>
<%--            border-radius: 8px;--%>
<%--        }--%>
<%--        h1 span em {--%>
<%--            font-style: italic; /* Make the word "Chate" italic */--%>
<%--        }--%>
<%--        h2 {--%>
<%--            text-align: center;--%>
<%--            color: #555;--%>
<%--            margin-bottom: 30px;--%>
<%--            text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3); /* Add shadow effect */--%>
<%--            font-style: italic; /* Make the "Sign in to ShalChate" italic */--%>
<%--        }--%>
<%--        input[type="text"], input[type="mail"], input[type="password"] {--%>
<%--            width: 100%;--%>
<%--            padding: 12px;--%>
<%--            margin-bottom: 20px;--%>
<%--            border: 1px solid #ccc;--%>
<%--            border-radius: 4px;--%>
<%--            box-sizing: border-box;--%>
<%--            font-size: 14px;--%>
<%--        }--%>
<%--        input[type="submit"] {--%>
<%--            width: 100%;--%>
<%--            padding: 12px;--%>
<%--            background-color: #4CAF50;--%>
<%--            color: white;--%>
<%--            border: none;--%>
<%--            border-radius: 4px;--%>
<%--            cursor: pointer;--%>
<%--            font-size: 14px;--%>
<%--        }--%>
<%--        .create-account {--%>
<%--            text-align: center;--%>
<%--            margin-top: 20px;--%>
<%--            font-size: 14px;--%>
<%--        }--%>
<%--        .create-account a {--%>
<%--            color: #4CAF50;--%>
<%--            text-decoration: none;--%>
<%--        }--%>
<%--        /* Additional styling */--%>
<%--        .container {--%>
<%--            border: 2px solid #ccc;--%>
<%--        }--%>
<%--        h2 {--%>
<%--            text-transform: uppercase;--%>
<%--            font-weight: bold;--%>
<%--        }--%>
<%--        input[type="text"], input[type="mail"], input[type="password"] {--%>
<%--            border-radius: 5px;--%>
<%--        }--%>
<%--        input[type="submit"] {--%>
<%--            color: #fff;--%>
<%--            background-color: #000;--%>
<%--        }--%>
<%--        .create-account a {--%>
<%--            color: #000;--%>
<%--        }--%>
<%--        /* Style for the error message */--%>
<%--        .error {--%>
<%--            color: red;--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<html lang="en">--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--    <title>Login Form</title>--%>
<%--    <style>--%>
<%--        /* CSS styling for the login form */--%>
<%--        body {--%>
<%--            background: linear-gradient(to bottom, #c6d2e1, #C4C1A0);--%>
<%--            display: flex;--%>
<%--            justify-content: center;--%>
<%--            align-items: center;--%>
<%--            height: 100vh;--%>
<%--            font-family: Arial, sans-serif;--%>
<%--        }--%>
<%--        .container {--%>
<%--            width: 450px;--%>
<%--            padding: 40px;--%>
<%--            background-image: url('path_to_your_image.jpg'); /* Replace 'path_to_your_image.jpg' with the path to your photo */--%>
<%--            background-size: cover;--%>
<%--            background-position: center;--%>
<%--            border-radius: 30px;--%>
<%--            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);--%>
<%--            transition: transform 0.3s, background-color 0.3s;--%>
<%--            position: relative;--%>
<%--            overflow: hidden;--%>
<%--            text-align: center; /* Center the content within the container */--%>
<%--        }--%>
<%--        .container:before {--%>
<%--            content: '';--%>
<%--            position: absolute;--%>
<%--            top: -30px;--%>
<%--            left: -30px;--%>
<%--            right: -30px;--%>
<%--            bottom: -30px;--%>
<%--            z-index: -1;--%>
<%--            background: linear-gradient(to bottom, rgba(255, 255, 255, 0.6), rgba(0, 0, 0, 0.2));--%>
<%--            border-radius: 30px;--%>
<%--        }--%>
<%--        .container:hover {--%>
<%--            transform: scale(1.05);--%>
<%--            background-color: #f4f7f9;--%>
<%--        }--%>
<%--        h1 {--%>
<%--            text-align: center;--%>
<%--            color: #555;--%>
<%--            margin-bottom: 30px;--%>
<%--            font-weight: bold;--%>
<%--            font-family: 'EB Garamond', Arial, sans-serif;--%>
<%--            font-size: 26px;--%>
<%--            text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3);--%>
<%--            display: inline-block;--%>
<%--            margin-right: 10px; /* Adjust the margin as per your preference */--%>
<%--        }--%>
<%--        h1 span {--%>
<%--            display: inline-block;--%>
<%--            padding: 5px 10px;--%>
<%--            border: 2px solid #555;--%>
<%--            border-radius: 8px;--%>
<%--        }--%>
<%--        h1 span em {--%>
<%--            font-style: italic; /* Make the word "Chate" italic */--%>
<%--        }--%>
<%--        h2 {--%>
<%--            text-align: center;--%>
<%--            color: #555;--%>
<%--            margin-bottom: 30px;--%>
<%--            text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3); /* Add shadow effect */--%>
<%--            font-style: italic; /* Make the "Sign in to ShalChate" italic */--%>
<%--        }--%>
<%--        input[type="text"], input[type="mail"], input[type="password"] {--%>
<%--            width: 100%;--%>
<%--            padding: 12px;--%>
<%--            margin-bottom: 20px;--%>
<%--            border: 1px solid #ccc;--%>
<%--            border-radius: 4px;--%>
<%--            box-sizing: border-box;--%>
<%--            font-size: 14px;--%>
<%--        }--%>
<%--        input[type="submit"] {--%>
<%--            width: 100%;--%>
<%--            padding: 12px;--%>
<%--            background-color: #4CAF50;--%>
<%--            color: white;--%>
<%--            border: none;--%>
<%--            border-radius: 4px;--%>
<%--            cursor: pointer;--%>
<%--            font-size: 14px;--%>
<%--        }--%>
<%--        .create-account {--%>
<%--            text-align: center;--%>
<%--            margin-top: 20px;--%>
<%--            font-size: 14px;--%>
<%--        }--%>
<%--        .create-account a {--%>
<%--            color: #4CAF50;--%>
<%--            text-decoration: none;--%>
<%--        }--%>
<%--        /* Additional styling */--%>
<%--        .container {--%>
<%--            border: 2px solid #ccc;--%>
<%--        }--%>
<%--        h2 {--%>
<%--            text-transform: uppercase;--%>
<%--            font-weight: bold;--%>
<%--        }--%>
<%--        input[type="text"], input[type="mail"], input[type="password"] {--%>
<%--            border-radius: 5px;--%>
<%--        }--%>
<%--        input[type="submit"] {--%>
<%--            color: #fff;--%>
<%--            background-color: #000;--%>
<%--        }--%>
<%--        .create-account a {--%>
<%--            color: #000;--%>
<%--        }--%>
<%--        /* Style for the error message */--%>
<%--        .error {--%>
<%--            color: red;--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<html lang="en">--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--    <title>Login Form</title>--%>
<%--    <style>--%>
<%--        /* CSS styling for the login form */--%>
<%--        body {--%>
<%--            background: linear-gradient(to bottom, #c6d2e1, #C4C1A0);--%>
<%--            display: flex;--%>
<%--            justify-content: center;--%>
<%--            align-items: center;--%>
<%--            height: 100vh;--%>
<%--            font-family: Arial, sans-serif;--%>
<%--        }--%>
<%--        .container {--%>
<%--            width: 450px;--%>
<%--            padding: 40px;--%>
<%--            background-image: url('path_to_your_image.jpg'); /* Replace 'path_to_your_image.jpg' with the path to your photo */--%>
<%--            background-size: cover;--%>
<%--            background-position: center;--%>
<%--            border-radius: 30px;--%>
<%--            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);--%>
<%--            transition: transform 0.3s, background-color 0.3s;--%>
<%--            position: relative;--%>
<%--            overflow: hidden;--%>
<%--            text-align: center; /* Center the content within the container */--%>
<%--        }--%>
<%--        .container:before {--%>
<%--            content: '';--%>
<%--            position: absolute;--%>
<%--            top: -30px;--%>
<%--            left: -30px;--%>
<%--            right: -30px;--%>
<%--            bottom: -30px;--%>
<%--            z-index: -1;--%>
<%--            background: linear-gradient(to bottom, rgba(255, 255, 255, 0.6), rgba(0, 0, 0, 0.2));--%>
<%--            border-radius: 30px;--%>
<%--        }--%>
<%--        .container:hover {--%>
<%--            transform: scale(1.05);--%>
<%--            background-color: #f4f7f9;--%>
<%--        }--%>
<%--        h1 {--%>
<%--            text-align: center;--%>
<%--            color: #555;--%>
<%--            margin-bottom: 30px;--%>
<%--            font-weight: bold;--%>
<%--            font-family: 'EB Garamond', Arial, sans-serif;--%>
<%--            font-size: 26px;--%>
<%--            text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3);--%>
<%--            display: inline-block;--%>
<%--            margin-right: 10px; /* Adjust the margin as per your preference */--%>
<%--        }--%>
<%--        h1 span {--%>
<%--            display: inline-block;--%>
<%--            padding: 5px 10px;--%>
<%--            border: 2px solid #555;--%>
<%--            border-radius: 8px;--%>
<%--        }--%>
<%--        h1 span em {--%>
<%--            font-style: italic; /* Make the word "Chate" italic */--%>
<%--        }--%>
<%--        h2 {--%>
<%--            text-align: center;--%>
<%--            color: #555;--%>
<%--            margin-bottom: 30px;--%>
<%--            text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3); /* Add shadow effect */--%>
<%--            font-style: italic; /* Make the "Sign in to ShalChate" italic */--%>
<%--        }--%>
<%--        input[type="text"], input[type="email"], input[type="password"],input[type="tel"],input[type="file"] {--%>
<%--            width: 50%;--%>
<%--            padding: 12px;--%>
<%--            margin-bottom: 20px;--%>
<%--            border: 1px solid #ccc;--%>
<%--            border-radius: 4px;--%>
<%--            box-sizing: border-box;--%>
<%--            font-size: 14px;--%>
<%--        }--%>
<%--        input[type="address"] {--%>
<%--             width: 100%;--%>
<%--             padding: 12px;--%>
<%--             margin-bottom: 20px;--%>
<%--             border: 1px solid #ccc;--%>
<%--             border-radius: 4px;--%>
<%--             box-sizing: border-box;--%>
<%--             font-size: 14px;--%>
<%--        }--%>
<%--        input[type="submit"] {--%>
<%--            width: 100%;--%>
<%--            padding: 12px;--%>
<%--            background-color: #4CAF50;--%>
<%--            color: white;--%>
<%--            border: none;--%>
<%--            border-radius: 4px;--%>
<%--            cursor: pointer;--%>
<%--            font-size: 14px;--%>
<%--        }--%>
<%--        .create-account {--%>
<%--            text-align: center;--%>
<%--            margin-top: 20px;--%>
<%--            font-size: 14px;--%>
<%--        }--%>
<%--        .create-account a {--%>
<%--            color: #4CAF50;--%>
<%--            text-decoration: none;--%>
<%--        }--%>
<%--        /* Additional styling */--%>
<%--        .container {--%>
<%--            border: 2px solid #ccc;--%>
<%--        }--%>
<%--        h2 {--%>
<%--            text-transform: uppercase;--%>
<%--            font-weight: bold;--%>
<%--        }--%>
<%--        input[type="text"], input[type="mail"], input[type="password"] ,input[type="tel"],input[type="file"],input[type="address"] {--%>
<%--            border-radius: 5px;--%>
<%--        }--%>
<%--        input[type="submit"] {--%>
<%--            color: #fff;--%>
<%--            background-color: #000;--%>
<%--        }--%>
<%--        .create-account a {--%>
<%--            color: #000;--%>
<%--        }--%>
<%--        /* Style for the error message */--%>
<%--        .error {--%>
<%--            color: red;--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>
<%--<body>--%>

<%--<div class="container col-md-6 offset-md-3">--%>
<%--    <h1><span>Shal<em>Chate</em></span></h1>--%>
<%--        <h2><em>Register Form</em></h2>--%>
<%--    <form action="/customer/customerCreate" method="post" onsubmit="return validateForm()" enctype="multipart/form-data">--%>

<%--        <div class="form-group">--%>
<%--            <label for="name">Full Name</label>--%>
<%--            <label for="profileImage">Profile Image</label>--%>
<%--        </div>--%>

<%--         <div class="form-group">--%>
<%--              <input type="text" class="form-control" id="name" name="name" pattern="[A-Za-z ]+" required="true"--%>
<%--                     title="Please enter a valid name (only letters and spaces are allowed)">--%>
<%--              <input type="file" class="form-control-file" id="profileImage" name="profileImage">--%>
<%--         </div>--%>

<%--         <div>--%>
<%--                <label for="password">Password (at least 8 characters)</label>--%>
<%--                <label for="confirmPassword">Confirm Password</label>--%>
<%--        </div>--%>
<%--        <div>--%>
<%--             <input type="password" class="form-control" id="password" name="password"--%>
<%--             pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*_])[a-zA-Z0-9!@#$%^&*_]{8,}$"--%>
<%--             required="true" title="Password must contain 1 uppercase, 1 lowercase,special character and at least 8 letters">--%>
<%--            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword">--%>
<%--            <span class="error" id="passwordMismatchError"></span>--%>
<%--        </div>--%>
<%--        <div class="form-group">--%>
<%--            <label for="mail">Email</label>--%>
<%--            <label for="phone">Phone Number</label>--%>
<%--        </div>--%>

<%--        <div class="form-group">--%>
<%--             <input type="email" class="form-control" id="mail" name="mail"--%>
<%--                    pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" required>--%>
<%--            <input type="tel" class="form-control" id="phone" name="phone" required>--%>
<%--            <span class="error" id="phoneMismatchError"></span>--%>
<%--        </div>--%>

<%--        <div class="form-group">--%>
<%--            <label for="address">Address</label>--%>
<%--        </div>--%>
<%--        <div>--%>
<%--            <input type="address" class="form-control" id="address" name="address" required>--%>
<%--        </div>--%>

<%--        <button type="submit" class="btn btn-primary">Create</button>--%>
<%--        <a href="/" class="btn btn-danger float-right">Back</a>--%>
<%--    </form>--%>


<%--</div>--%>

<%--<script>--%>
<%--    function validateForm() {--%>
<%--        var password = document.getElementById("password").value;--%>
<%--        var confirmPassword = document.getElementById("confirmPassword").value;--%>
<%--        var passwordMismatchError = document.getElementById("passwordMismatchError");--%>
<%--        var phoneMismatchError = document.getElementById("phoneMismatchError");--%>
<%--        var phone = document.getElementById("phone").value;--%>
<%--        var phoneRegex = /^(09|\+959)\d{8,9}$/; // Myanmar phone number format regex--%>

<%--        if (password.length < 8) {--%>
<%--            passwordMismatchError.innerText = "Password must be at least 8 characters";--%>
<%--            return false; // Prevent form submission--%>
<%--        } else if (password !== confirmPassword) {--%>
<%--            passwordMismatchError.innerText = "(Passwords do not match)";--%>
<%--            passwordMismatchError.style.color = "red";--%>
<%--            return false; // Prevent form submission--%>
<%--        } else if (!phone.match(phoneRegex)) {--%>
<%--            // Check if phone number matches the Myanmar phone number format--%>
<%--            phoneMismatchError.innerText = "Please enter a valid Myanmar phone number";--%>
<%--            phoneMismatchError.style.color = "red";--%>
<%--            return false; // Prevent form submission--%>
<%--        } else {--%>
<%--            passwordMismatchError.innerText = ""; // Clear any previous error message--%>
<%--            return true; // Allow form submission--%>
<%--        }--%>
<%--    }--%>
<%--</script>--%>
<%--<%@ include file="/WEB-INF/view/footer.jsp" %>--%>