
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
            input[type="text"], input[type="email"], input[type="password"] {
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
            input[type="text"], input[type="email"], input[type="password"] {
                border-radius: 5px;
            }
            input[type="submit"] {
                color: #fff;
                background-color: #000;
            }
            .create-account a {
                color: #000;
            }
            /* Style for the error message */
            .error {
                color: red;
            }

            /* Add your head content here */
        </style>
    </head>
    <body>
    <div class="container">
        <h1><span>Shal<em>Chate</em></span></h1>
        <h2><em>OTP Validation</em></h2>
        <form action="/verifyOtp" method="post" onsubmit="return validateOTP()">
            <span class="error" id="otpErrorMessage">${error}</span>
            <input type="text" placeholder="Enter OTP code" name="otp" id="otpInput" required>

            <input type="submit" value="Done">
        </form>
    </div>

    <script>

        function validateOTP() {
            const otpInput = document.getElementById("otpInput");
            const otpErrorMessage = document.getElementById("otpErrorMessage");

            // Remove any existing error message
            otpErrorMessage.textContent = "";

            // Check if the input contains only numbers and is exactly 6 digits
            const inputValue = otpInput.value;
            if (!/^\d+$/.test(inputValue)) {
                otpErrorMessage.textContent = "Only numbers are allowed in the OTP.";
                return false; // Prevent form submission
            } else if (inputValue.length !== 6) {
                otpErrorMessage.textContent = "OTP must have six digits.";
                return false; // Prevent form submission
            }

            // Allow form submission if validation passes
            return true;
        }
    </script>


    </body>
    </html>

<%@ include file="/WEB-INF/view/footer.jsp" %>
