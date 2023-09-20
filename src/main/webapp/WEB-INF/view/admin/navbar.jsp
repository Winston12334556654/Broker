<html>
<head>
    <style>
        .navbar-brand {
            color: #f2f2f2;
            font-weight: bold;
            font-family: 'EB Garamond', Arial, sans-serif;
            margin-right: 20px;
            font-size: 26px; /* Adjust the value as per your requirement */
            text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3); /* Add shadow effect */
            border: 2px solid #555; /* Add border */
            border-radius: 8px; /* Adjust the value as per your requirement */
            padding: 5px 10px; /* Adjust the value as per your requirement */
        }
        .navbar-secondary {
            font-weight: bold;
            text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3);
        }

        .navbar-logo {
            display: flex;
            align-items: center;
        }
        .navbar-logo-text {
            margin-left: 10px; /* Adjust the value as needed */
        }

        #warning-container-wrapper {
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

        #warning-container {
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

        #warning-container1::before {
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

        #dialog-yes {
            background-color: green;
            color: white;
        }

        #dialog-no {
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
<div class="container-fluid bg-dark">
    <div class="col-md-6 offset-md-3">
        <nav class="navbar navbar-expand-lg navbar-light">

            <div class="navbar-logo" id="navbarContainer">
                <span class="navbar-brand"><b>Shal<i>Chate</i></b></span>
            </div>

            <button class="navbar-toggler" type="button" data-toggle="collapse"
                    data-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent" aria-expanded="false"
                    aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ml-auto">

                    <li class="nav-item"><a class="nav-link text-white" href="/admin/viewCustomer">Users</a></li>
                    <li class="nav-item"><a class="nav-link text-white" href="/admin/viewProduct">Products</a></li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-white" href="#" role="button"
                           data-toggle="dropdown" aria-expanded="false"> Admin </a>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="#">Profile</a>
                            <a class="dropdown-item" href="/admin/viewAdmin">View Admins</a>
                            <div class="logout">
                                <a class="dropdown-item" href="/" id="logout_item">Logout</a>
                            </div>
                            <div class="dropdown-divider"></div>

                        </div>
                    </li>
                    <form class="search-form" action="/admin/searchProducts" method="get">
                        <input class="search-input" type="text" placeholder="Search Products..." name="products">
                        <button class="search-button" type="submit">Search</button>
                    </form>
                    <p> >    < </p>
                    <form class="search-form" action="/admin/searchUsers" method="get">
                        <input class="search-input" type="text" placeholder="Search Users..." name="users">
                        <button class="search-button" type="submit">Search</button>
                    </form>
                </ul>
            </div>
        </nav>
    </div>
</div>

<div id="warning-container-wrapper" style="display: none;">
    <div id="warning-container">
        <h2>Are you sure to logout?</h2>
        <div class="dialog-buttons">
            <button class="dialog-button" id="dialog-yes">Logout</button>
            <button class="dialog-button" id="dialog-no">Back</button>
        </div>
    </div>
</div>
<script>
    // Get a reference to the div element
    var navbarContainer = document.getElementById("navbarContainer");

    // Add a click event listener to the div
    navbarContainer.addEventListener("click", function() {
        // Navigate to the specified link when the div is clicked
        window.location.href = "/admin"; // Replace with the actual link
    });
    //
    // Add an event listener to ensure that the script runs after the DOM is fully loaded.
    document.addEventListener("DOMContentLoaded", function () {
        // JavaScript code to handle the shopping cart icon click event
        document.getElementById("logout_item").addEventListener("click", function (e) {
            e.preventDefault(); // Prevent the default link behavior

            // Show the warning container and blur the background
            document.getElementById("warning-container-wrapper").style.display = "flex";
            document.body.style.overflow = "hidden";
        });

        // Handle the "yes" button click event
        document.getElementById("dialog-yes").addEventListener("click", function () {
            // Redirect to the specified page
            window.location.href = "/";
        });

        // Handle the "no" button click event
        document.getElementById("dialog-no").addEventListener("click", function () {
            // Hide the warning container and remove the background blur
            document.getElementById("warning-container-wrapper").style.display = "none";
            document.body.style.overflow = "auto";
        });
    });
</script>
</body>
</html>

<%--<html>--%>
<%--<head>--%>
<%--<style>--%>
<%--    .navbar-brand {--%>
<%--        color: #f2f2f2;--%>
<%--        font-weight: bold;--%>
<%--        font-family: 'EB Garamond', Arial, sans-serif;--%>
<%--        margin-right: 20px;--%>
<%--        font-size: 26px; /* Adjust the value as per your requirement */--%>
<%--        text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3); /* Add shadow effect */--%>
<%--        border: 2px solid #555; /* Add border */--%>
<%--        border-radius: 8px; /* Adjust the value as per your requirement */--%>
<%--        padding: 5px 10px; /* Adjust the value as per your requirement */--%>
<%--    }--%>
<%--    .navbar-secondary {--%>
<%--        font-weight: bold;--%>
<%--        text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3);--%>
<%--    }--%>

<%--    .navbar-logo {--%>
<%--        display: flex;--%>
<%--        align-items: center;--%>
<%--    }--%>
<%--    .navbar-logo-text {--%>
<%--        margin-left: 10px; /* Adjust the value as needed */--%>
<%--    }--%>


<%--</style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="container-fluid bg-dark">--%>
<%--    <div class="col-md-6 offset-md-3">--%>
<%--        <nav class="navbar navbar-expand-lg navbar-light">--%>



<%--            <div class="navbar-logo" id="navbarContainer">--%>
<%--                <span class="navbar-brand"><b>Shal<i>Chate</i></b></span>--%>
<%--            </div>--%>

<%--            <button class="navbar-toggler" type="button" data-toggle="collapse"--%>
<%--                    data-target="#navbarSupportedContent"--%>
<%--                    aria-controls="navbarSupportedContent" aria-expanded="false"--%>
<%--                    aria-label="Toggle navigation">--%>
<%--                <span class="navbar-toggler-icon"></span>--%>
<%--            </button>--%>

<%--            <div class="collapse navbar-collapse" id="navbarSupportedContent">--%>
<%--                <ul class="navbar-nav ml-auto">--%>

<%--                    <li class="nav-item"><a class="nav-link text-white" href="/admin/viewCustomer">Users</a></li>--%>
<%--                    <li class="nav-item"><a class="nav-link text-white" href="/admin/viewProduct">Products</a></li>--%>


<%--                    <li class="nav-item dropdown">--%>
<%--                        <a class="nav-link dropdown-toggle text-white" href="#" role="button"--%>
<%--                           data-toggle="dropdown" aria-expanded="false"> Admin </a>--%>
<%--                        <div class="dropdown-menu">--%>

<%--                            <a class="dropdown-item" href="/admin/viewAdmin">View Admins</a>--%>
<%--                            <a class="dropdown-item" href="/">Logout</a>--%>
<%--                            <div class="dropdown-divider"></div>--%>

<%--                        </div>--%>
<%--                    </li>--%>
<%--                    <form class="search-form" action="/admin/searchProducts" method="get">--%>
<%--                        <input class="search-input" type="text" placeholder="Search Products..." name="products">--%>
<%--                        <button class="search-button" type="submit">Search</button>--%>
<%--                    </form>--%>
<%--                    <p> >    < </p>--%>
<%--                    <form class="search-form" action="/admin/searchUsers" method="get">--%>
<%--                        <input class="search-input" type="text" placeholder="Search Users..." name="users">--%>
<%--                        <button class="search-button" type="submit">Search</button>--%>
<%--                    </form>--%>



<%--                </ul>--%>
<%--            </div>--%>
<%--        </nav>--%>
<%--    </div>--%>
<%--</div>--%>
<%--<script>--%>
<%--    // Get a reference to the div element--%>
<%--    var navbarContainer = document.getElementById("navbarContainer");--%>

<%--    // Add a click event listener to the div--%>
<%--    navbarContainer.addEventListener("click", function() {--%>
<%--        // Navigate to the specified link when the div is clicked--%>
<%--        window.location.href = "/admin"; // Replace with the actual link--%>
<%--    });--%>
<%--</script>--%>
<%--</body>--%>
<%--</html>--%>