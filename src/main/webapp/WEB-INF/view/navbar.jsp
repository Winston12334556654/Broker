<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Navbar Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            background: linear-gradient(to bottom, #c6d2e1, #C4C1A0);
            font-family: 'EB Garamond', Arial, sans-serif;
            font-weight: 900;
        }
        .container-fluid {
            display: flex;
            justify-content: space-between; /* Distribute items with equal space */
            justify-content: flex-end; /* Align items to the right */
            align-items: center;
            font-family: 'EB Garamond', Arial, sans-serif;
            padding: 8px;
        }

        .navbar {
            flex-grow: 1; /* Allow the navbar to grow and take available space */
            padding: 20px;

            background-size: cover;
            background-position: center;
            border-radius: 30px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s, background-color 0.3s, transform-origin 0.3s, scale 0.3s;
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            transform-origin: center;
        }
        .navbar:hover {
            background-color: #eef2f5;
            transform: scale(1.02);
        }
        .navbar-brand {
            font-weight: bold;
            font-family: 'EB Garamond', Arial, sans-serif;
            margin-right: 20px;
            font-size: 26px;
            text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3);
            border: 2px solid #555;
            border-radius: 8px;
            padding: 5px 10px;
        }
        .search-form {
            display: flex;
            align-items: center;
            margin-left: 20px;
            margin-top: 20px;
            margin-bottom: 10px;
            flex-grow: 1; /* Allow the search form to grow and take available space */
        }
        .search-input {

            padding: 5px;
            border: none;
            border-radius: 20px;
            background-color: #ddd;
            text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3);
            width: 100%; /* Allow the input to take all available width */
        }
        .search-button {
            padding: 5px 10px;
            background-color: #555;
            color: #fff;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            margin-left: 10px;
        }
        .search-button:hover {
            background-color: #333;
        }
        .navbar-secondary {
            font-weight: bold;
            text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3);
        }

        .nav-link {
            margin: 0 10px; /* Add equal margin to all nav links for spacing */
            padding: 5px 10px;
            font-weight: bold;
            color: #555;
            text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3);
        }
        .social-icons {
            display: flex;
            align-items: center;
            margin-left: 10px;
        }

        .social-icon {
            font-size: 18px;
            color: #555;
            margin: 0 8px; /* Adjust margin as needed */
            text-decoration: none;
        }

        @media (max-width: 768px) {
            .container-fluid {
                flex-direction: column;
                align-items: flex-start;
            }
            .navbar {
                width: 100%;
                padding: 10px; /* Adjust padding for smaller screens */
            }
            .navbar-brand {
                margin-bottom: 10px;
                margin-top: 10px; /* Add margin at the top for smaller screens */
            }
            .search-form {
                margin-top: 10px;
            }
            .search-input,
            .search-button {
                width: 100%;
                margin-top: 10px; /* Add margin at the top for smaller screens */
            }
            .nav-link {
                margin: 5px 0;
            }
            .social-icons {
                margin-left: auto;
                margin-right: 5px; /* Adjust margin for smaller screens */
            }
        }
        #warning-container-wrapper0 {
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

        #warning-container0 {
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

        #warning-container0::before {
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

        #dialog-yes0 {
            background-color: green;
            color: white;
        }

        #dialog-no0 {
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
<div class="container-fluid">
    <nav class="navbar navbar-expand-lg navbar-light">
        <span class="navbar-brand"><b>Shal<i>Chate</i></b></span>
        <span class="navbar-secondary">Online Market Place</span>

        <form class="search-form" action="/search" method="get">
            <input class="search-input" type="text" placeholder="Search..." name="query">
            <button class="search-button" type="submit">Search</button>
        </form>

        <div class="home">
            <a href="/customer/homeCustomer" class="nav-link">Home</a>
        </div>

        <div class="products">
            <a href="/productsByRole" class="nav-link">Products</a>
        </div>

        <div class="categories">
            <a href="/product/productView" class="nav-link">Categories</a>
        </div>



        <div class="sell">
            <a class="nav-link" href="/product/productCreate">Sell</a>
        </div>

        <div class="logout">
            <a href="/" class="nav-link"id="logout_item">Logout</a>
        </div>

        <div class="social-icons">
            <a href="#" class="social-icon"><i class="fab fa-facebook"></i></a>
            <a href="#" class="social-icon"><i class="fab fa-twitter"></i></a>
            <a href="#" class="social-icon"><i class="fab fa-instagram"></i></a>
        </div>
    </nav>
</div>
<div id="warning-container-wrapper0" style="display: none;">
    <div id="warning-container0">
        <h2>Are you sure to logout?</h2>
        <div class="dialog-buttons">
            <button class="dialog-button" id="dialog-yes0">Logout</button>
            <button class="dialog-button" id="dialog-no0">Back</button>
        </div>
    </div>
</div>
<script>
    // Add an event listener to ensure that the script runs after the DOM is fully loaded.
    document.addEventListener("DOMContentLoaded", function () {
        // JavaScript code to handle the shopping cart icon click event
        document.getElementById("logout_item").addEventListener("click", function (e) {
            e.preventDefault(); // Prevent the default link behavior

            // Show the warning container and blur the background
            document.getElementById("warning-container-wrapper0").style.display = "flex";
            document.body.style.overflow = "hidden";
        });

        // Handle the "yes" button click event
        document.getElementById("dialog-yes0").addEventListener("click", function () {
            // Redirect to the specified page
            window.location.href = "/";
        });

        // Handle the "no" button click event
        document.getElementById("dialog-no0").addEventListener("click", function () {
            // Hide the warning container and remove the background blur
            document.getElementById("warning-container-wrapper0").style.display = "none";
            document.body.style.overflow = "auto";
        });
    });
</script>
</body>
</html>







<%--<!DOCTYPE html>--%>
<%--<html lang="en">--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--    <title>Navbar Page</title>--%>
<%--    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">--%>
<%--    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css">--%>
<%--    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>--%>
<%--    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>--%>

<%--    <style>--%>
<%--        body {--%>
<%--            background: linear-gradient(to bottom, #c6d2e1, #C4C1A0);--%>
<%--            font-family: 'EB Garamond', Arial, sans-serif;--%>
<%--            font-weight: 900;--%>
<%--        }--%>
<%--        .container-fluid {--%>
<%--            display: flex;--%>
<%--            justify-content: space-between; /* Distribute items with equal space */--%>
<%--            justify-content: flex-end; /* Align items to the right */--%>
<%--            align-items: center;--%>
<%--            font-family: 'EB Garamond', Arial, sans-serif;--%>
<%--            padding: 8px;--%>
<%--        }--%>

<%--        .navbar {--%>
<%--            flex-grow: 1; /* Allow the navbar to grow and take available space */--%>
<%--            padding: 20px;--%>

<%--            background-size: cover;--%>
<%--            background-position: center;--%>
<%--            border-radius: 30px;--%>
<%--            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);--%>
<%--            transition: transform 0.3s, background-color 0.3s, transform-origin 0.3s, scale 0.3s;--%>
<%--            position: relative;--%>
<%--            overflow: hidden;--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            transform-origin: center;--%>
<%--        }--%>
<%--        .navbar:hover {--%>
<%--            background-color: #eef2f5;--%>
<%--            transform: scale(1.02);--%>
<%--        }--%>
<%--        .navbar-brand {--%>
<%--            font-weight: bold;--%>
<%--            font-family: 'EB Garamond', Arial, sans-serif;--%>
<%--            margin-right: 20px;--%>
<%--            font-size: 26px;--%>
<%--            text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3);--%>
<%--            border: 2px solid #555;--%>
<%--            border-radius: 8px;--%>
<%--            padding: 5px 10px;--%>
<%--        }--%>
<%--        .search-form {--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            margin-left: 20px;--%>
<%--            margin-top: 20px;--%>
<%--            margin-bottom: 10px;--%>
<%--            flex-grow: 1; /* Allow the search form to grow and take available space */--%>
<%--        }--%>
<%--        /*.search-input {*/--%>
<%--        /*    padding: 5px;*/--%>
<%--        /*    border: none;*/--%>
<%--        /*    border-radius: 20px;*/--%>
<%--        /*    background-color: #ddd;*/--%>
<%--        /*    width: 100%; !* Set width to 100% *!*/--%>
<%--        /*    max-width: 600px; !* Set a maximum width *!*/--%>
<%--        /*    text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3);*/--%>
<%--        /*}*/--%>
<%--        .search-input {--%>

<%--            padding: 5px;--%>
<%--            border: none;--%>
<%--            border-radius: 20px;--%>
<%--            background-color: #ddd;--%>
<%--            text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3);--%>
<%--            width: 100%; /* Allow the input to take all available width */--%>
<%--        }--%>
<%--        .search-button {--%>
<%--            padding: 5px 10px;--%>
<%--            background-color: #555;--%>
<%--            color: #fff;--%>
<%--            border: none;--%>
<%--            border-radius: 20px;--%>
<%--            cursor: pointer;--%>
<%--            margin-left: 10px;--%>
<%--        }--%>
<%--        .search-button:hover {--%>
<%--            background-color: #333;--%>
<%--        }--%>
<%--        .navbar-secondary {--%>
<%--            font-weight: bold;--%>
<%--            text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3);--%>
<%--        }--%>

<%--        .nav-link {--%>
<%--            margin: 0 10px; /* Add equal margin to all nav links for spacing */--%>
<%--            padding: 5px 10px;--%>
<%--            font-weight: bold;--%>
<%--            color: #555;--%>
<%--            text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3);--%>
<%--        }--%>
<%--        .social-icons {--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            margin-left: 10px;--%>
<%--        }--%>

<%--        .social-icon {--%>
<%--            font-size: 18px;--%>
<%--            color: #555;--%>
<%--            margin: 0 8px; /* Adjust margin as needed */--%>
<%--            text-decoration: none;--%>
<%--        }--%>

<%--        @media (max-width: 768px) {--%>
<%--            .container-fluid {--%>
<%--                flex-direction: column;--%>
<%--                align-items: flex-start;--%>
<%--            }--%>
<%--            .navbar {--%>
<%--                width: 100%;--%>
<%--                padding: 10px; /* Adjust padding for smaller screens */--%>
<%--            }--%>
<%--            .navbar-brand {--%>
<%--                margin-bottom: 10px;--%>
<%--                margin-top: 10px; /* Add margin at the top for smaller screens */--%>
<%--            }--%>
<%--            .search-form {--%>
<%--                margin-top: 10px;--%>
<%--            }--%>
<%--            .search-input,--%>
<%--            .search-button {--%>
<%--                width: 100%;--%>
<%--                margin-top: 10px; /* Add margin at the top for smaller screens */--%>
<%--            }--%>
<%--            .nav-link {--%>
<%--                margin: 5px 0;--%>
<%--            }--%>
<%--            .social-icons {--%>
<%--                margin-left: auto;--%>
<%--                margin-right: 5px; /* Adjust margin for smaller screens */--%>
<%--            }--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="container-fluid">--%>
<%--    <nav class="navbar navbar-expand-lg navbar-light">--%>
<%--        <span class="navbar-brand"><b>Shal<i>Chate</i></b></span>--%>
<%--        <span class="navbar-secondary">Online Market Place</span>--%>

<%--        <form class="search-form" action="/search" method="get">--%>
<%--            <input class="search-input" type="text" placeholder="Search..." name="query">--%>
<%--            <button class="search-button" type="submit">Search</button>--%>
<%--        </form>--%>

<%--        <div class="home">--%>
<%--            <a href="/customer/homeCustomer" class="nav-link">Home</a>--%>
<%--        </div>--%>

<%--        <div class="products">--%>
<%--            <a href="/productsByRole" class="nav-link">Products</a>--%>
<%--        </div>--%>

<%--        <div class="categories">--%>
<%--            <a href="/product/productView" class="nav-link">Categories</a>--%>
<%--        </div>--%>



<%--        <div class="sell">--%>
<%--            <a class="nav-link" href="/product/productCreate">Sell</a>--%>
<%--        </div>--%>

<%--        <div class="logout">--%>
<%--            <a href="/" class="nav-link">Logout</a>--%>
<%--        </div>--%>

<%--        <div class="social-icons">--%>
<%--            <a href="#" class="social-icon"><i class="fab fa-facebook"></i></a>--%>
<%--            <a href="#" class="social-icon"><i class="fab fa-twitter"></i></a>--%>
<%--            <a href="#" class="social-icon"><i class="fab fa-instagram"></i></a>--%>
<%--        </div>--%>
<%--    </nav>--%>
<%--</div>--%>
<%--</body>--%>
<%--</html>--%>
