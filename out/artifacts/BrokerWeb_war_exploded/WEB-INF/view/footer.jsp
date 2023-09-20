<%--<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">--%>
<%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>--%>
<%--<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>--%>
<%--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>--%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<html>
<head>
    <style>
        body {
            margin-bottom: 200px; /* Adjust the value as needed */
        }

        footer {
            position: fixed;
            left: 0;
            bottom: 0;
            height : 150px;
            width: 100%;
            background-color: #333;
            color: #fff;
            padding: 20px 0;
            text-align: center;
            transition: opacity 0.3s, visibility 0.3s;
            opacity: 0; /* Initially hidden */
            visibility: hidden; /* Initially hidden */
            z-index: 1002; /* Adjust the value as needed */
        }


        /* Show the footer when the user scrolls */
        footer.show-footer {
            opacity: 1;
            visibility: visible;
        }

    </style>

</head>
<body>
<footer class="container-fluid bg-dark text-white">
    <div class="row py-4">
        <div class="col-md-4">
            <h4>About Us</h4>
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel risus vitae libero lacinia cursus.</p>
        </div>
        <div class="col-md-4">
            <h4>Contact Us</h4>
            <p>Email: contact@example.com</p>
            <p>Phone: +1234567890</p>
        </div>
        <div class="col-md-4">
            <h4>Follow Us</h4>
            <a href="#" class="text-white">Facebook</a><br>
            <a href="#" class="text-white">Twitter</a><br>
            <a href="#" class="text-white">Instagram</a>
        </div>
    </div>
    <div class="row bg-secondary py-2">
        <div class="col text-center">
            &copy; 2023 ShalChate. All rights reserved.
        </div>
    </div>
</footer>


<script>
    $(document).ready(function() {
        // Check if the user has scrolled down, and show the footer accordingly
        $(window).scroll(function() {
            if ($(this).scrollTop() > 100) { // Adjust the scroll value as needed
                $('footer').addClass('show-footer');
            } else {
                $('footer').removeClass('show-footer');
            }
        });
    });
</script>
</body>
</html>











<%--&lt;%&ndash;--%>
<%--  Created by IntelliJ IDEA.--%>
<%--  User: marannoepharaung--%>
<%--  Date: 7/14/23--%>
<%--  Time: 2:23 PM--%>
<%--  To change this template use File | Settings | File Templates.--%>
<%--&ndash;%&gt;--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>

<%--<style>--%>
<%--    /* CSS styling for the footer */--%>
<%--    footer {--%>
<%--        display: flex;--%>
<%--        justify-content: center;--%>
<%--        align-items: center;--%>
<%--        height: 50px;--%>
<%--        background-color: #f4f7f9;--%>
<%--        border-top: 1px solid #ccc;--%>
<%--        position: fixed;--%>
<%--        left: 0;--%>
<%--        bottom: 0;--%>
<%--        width: 100%;--%>
<%--    }--%>
<%--    .footer-text {--%>
<%--        font-size: 14px;--%>
<%--        color: #555;--%>
<%--    }--%>
<%--</style>--%>
<%--<footer>--%>
<%--    <p class="footer-text">&copy; 2023 My Website. All rights reserved.</p>--%>
<%--</footer>--%>
