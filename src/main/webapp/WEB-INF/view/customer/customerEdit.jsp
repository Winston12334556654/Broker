


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/view/header.jsp" %>
<%@ include file="/WEB-INF/view/navbar.jsp" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Include your CSS and other styles here -->
</head>
<body>
<div class="container">
    <div class="row justify-content-start mt-3">
        <div class="col-md-6">
            <a href="/customer/homeCustomer" class="btn btn-secondary">&lt; Back to Home</a>
        </div>
    </div>
    <div class="row justify-content-center mt-5">
        <div class="col-md-6">
            <h2>Edit Profile</h2>
            <form action="/updateProfile" method="post" onsubmit="return validateForm()" enctype="multipart/form-data">

                <input type="hidden" id="id" name="id" value="${user.id}">
                <!-- Full Name -->
                <div class="form-group">
                    <label for="name">Full Name</label>
                    <input type="text" class="form-control" id="name" name="name" pattern="[A-Za-z ]+" required="true"
                           title="Please enter a valid name (only letters and spaces are allowed)"
                           value="${user.name}">
                </div>

                <div class="form-group">
                    <label for="password">New Password (at least 8 characters)</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="password" name="password"
                               pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*_])[a-zA-Z0-9!@#$%^&*_]{8,}$"
                               title="Password must contain 1 uppercase, 1 lowercase, special character, and at least 8 characters"
                               value="${user.password}">
                        <div class="input-group-append">
                            <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                <i class="fa fa-eye-slash" id="eyeIcon"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Confirm Password -->
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required
                               value="${user.confirmpassword}">
                        <div class="input-group-append">
                            <button class="btn btn-outline-secondary" type="button" id="toggleConfirmPassword">
                                <i class="fa fa-eye-slash" id="eyeIconConfirm"></i>
                            </button>
                        </div>
                    </div>
                    <span class="error" id="passwordMismatchError"></span>
                </div>
                <!-- Email -->
                <div class="form-group">
                    <label for="mail">Email</label>
                    <input type="email" class="form-control" id="mail" name="mail"
                           pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" required
                           value="${user.mail}">
                </div>

                <!-- Phone Number -->
                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" class="form-control" id="phone" name="phone" required
                           value="${user.phone}">
                    <span class="error" id="phoneMismatchError"></span>
                </div>

                <!-- Address -->
                <div class="form-group">
                    <label for="address">Address</label>
                    <input type="text" class="form-control" id="address" name="address" required
                           value="${user.address}">
                </div>

                <input type="hidden" id="createdDate" name="createdDate" value="${user.created_date}">


                <!-- Profile Image -->
                <div class="form-group">
                    <label for="profileImage">Profile Image</label>
                    <div class="profile-image-container">
                        <img src="<c:url value='../productImage/${user.user_image_path}' />" alt="User Profile Image" class="profile-image">
                        <input type="file" class="form-control-file" id="profileImage" name="profileImage" required>
                    </div>
                </div>

                <!-- Save Button -->
                <button type="submit" class="btn btn-primary">Save Changes</button>
            </form>
        </div>
    </div>
</div>
<%-- Include your footer content --%>
<script>
    function validateForm() {
        var password = document.getElementById("password").value;
        var confirmPassword = document.getElementById("confirmPassword").value;
        var passwordMismatchError = document.getElementById("passwordMismatchError");
        var phoneMismatchError = document.getElementById("phoneMismatchError");
        var phone = document.getElementById("phone").value;
        var phoneRegex = /^(09|\+959)\d{8,9}$/; // Myanmar phone number format regex

        if (password.length > 0 && password.length < 8) {
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
    const togglePasswordButton = document.getElementById('togglePassword');
    const passwordInput = document.getElementById('password');
    const eyeIcon = document.getElementById('eyeIcon');

    const toggleConfirmPasswordButton = document.getElementById('toggleConfirmPassword');
    const confirmPasswordInput = document.getElementById('confirmPassword');
    const eyeIconConfirm = document.getElementById('eyeIconConfirm');

    togglePasswordButton.addEventListener('click', () => {
        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            eyeIcon.classList.remove('fa-eye-slash');
            eyeIcon.classList.add('fa-eye');
        } else {
            passwordInput.type = 'password';
            eyeIcon.classList.remove('fa-eye');
            eyeIcon.classList.add('fa-eye-slash');
        }
    });

    toggleConfirmPasswordButton.addEventListener('click', () => {
        if (confirmPasswordInput.type === 'password') {
            confirmPasswordInput.type = 'text';
            eyeIconConfirm.classList.remove('fa-eye-slash');
            eyeIconConfirm.classList.add('fa-eye');
        } else {
            confirmPasswordInput.type = 'password';
            eyeIconConfirm.classList.remove('fa-eye');
            eyeIconConfirm.classList.add('fa-eye-slash');
        }
    });
</script>
</body>
</html>
