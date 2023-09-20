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
        input[type="text"], input[type="mail"], input[type="password"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }
        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
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
        input[type="text"], input[type="mail"], input[type="password"] {
            border-radius: 5px;
        }
        input[type="submit"] {
            color: #fff;
            background-color: #000;
        }
        .create-account a {
            color: #000;
        }
        /* Style for the underline links */
        .underline-link {
            text-decoration: underline;
        }

        /* Position the links */
        .links-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 10px;
        }


        /* Style for the error message */
        .error {
            color: red;
        }
        input[type="email"], input[type="password"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
            border-color: #555; /* Add the same border color as the password container */
        }

        .back-button {
            position: absolute;
            top: 10px;
            left: 10px;
            background-color: #ac303f;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            padding: 10px 20px; /* Adjust padding as needed */
            text-decoration: none;
        }
        .back-button:hover {
            background-color: #45a049; /* Change color on hover */
        }
    </style>
</head>

<body>

<a href="/" class="back-button">&lt; Back</a>

<div class="container">
    <h1><span>Shal<em>Chate</em></span></h1>
    <h2><em>Sign in to ShalChate</em></h2>

    <form action="/customer/homeCustomer" method="post">

        <div style="margin-top: -10px;"> <!-- Adjust the margin-top value as needed -->
            <c:if test="${not empty error}">
                <div class="error">
                    <p>${error}</p>
                    <a href="${linkURL}">${linkText}</a>
                </div>
            </c:if>
        </div>


        <input type="email" placeholder="Please type your email address" name="email" required>
        <input type="password" placeholder="Password" name="password" id="password" required>
        <input type="checkbox" id="showPassword"> Show Password
        <input type="submit" value="Done">
    </form>
    <div class="links-container">
        <div class="underline-link">
            <a href="/customer/customerCreate">Sign up</a>
        </div>
        <div class="underline-link">
            <a href="/admin/forgotPassword">Forgot Password?</a>
        </div>
    </div>
</div>
<script>
    // Get the password input element and the show password checkbox
    const passwordInput = document.getElementById("password");
    const showPasswordCheckbox = document.getElementById("showPassword");

    // Add an event listener to the checkbox to toggle the password visibility
    showPasswordCheckbox.addEventListener("change", function () {
        if (this.checked) {
            passwordInput.type = "text"; // Show the password
        } else {
            passwordInput.type = "password"; // Hide the password
        }
    });
</script>

</body>
</html>
<%@ include file="footer.jsp" %>



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
<%--        input[type="text"], input[type="email"], input[type="password"] {--%>
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
<%--        input[type="text"], input[type="email"], input[type="password"] {--%>
<%--            border-radius: 5px;--%>
<%--        }--%>
<%--        input[type="submit"] {--%>
<%--            color: #fff;--%>
<%--            background-color: #000;--%>
<%--        }--%>
<%--        .create-account a {--%>
<%--            color: #000;--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="container">--%>
<%--    <h1><span>Shal<em>Chate</em></span></h1>--%>
<%--    <h2><em>Sign in to ShalChate</em></h2>--%>
<%--    <form action="/customer/homeCustomer" method="post">--%>
<%--        <input type="text" placeholder="Name" name="name" required>--%>

<%--        <input type="password" placeholder="Password" name="password" required>--%>
<%--        <input type="submit" value="Done">--%>
<%--    </form>--%>
<%--    <div class="create-account">--%>
<%--        By proceeding, you agree to our Terms of Use and confirm you have read our Privacy and Cookie Statement.--%>
<%--        This site is protected by reCAPTCHA and the Google Privacy Policy and Terms of Service apply. <a href="/customer/customerCreate">Sign up</a>--%>
<%--    </div>--%>
<%--</div>--%>
<%--</body>--%>
<%--<%@ include file="/WEB-INF/view/footer.jsp" %>--%>
<%--</html>--%>
