

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

                    <%--                    <li class="nav-item dropdown">--%>
                    <%--                        <a class="nav-link dropdown-toggle text-white" href="#" role="button"--%>
                    <%--                           data-toggle="dropdown" aria-expanded="false">Product Categories</a>--%>
                    <%--                        <div class="dropdown-menu">--%>
                    <%--                            <a class="dropdown-item" href="#">Electronics</a>--%>
                    <%--                            <a class="dropdown-item" href="#">Fashion & Apparel</a>--%>
                    <%--                            <div class="dropdown-divider"></div>--%>

                    <%--                        </div>--%>
                    <%--                    </li>--%>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-white" href="#" role="button"
                           data-toggle="dropdown" aria-expanded="false"> Admin </a>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="#">Profile</a>
                            <a class="dropdown-item" href="/admin/viewAdmin">View Admins</a>
                            <a class="dropdown-item" href="/">Logout</a>
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
<script>
    // Get a reference to the div element
    var navbarContainer = document.getElementById("navbarContainer");

    // Add a click event listener to the div
    navbarContainer.addEventListener("click", function() {
        // Navigate to the specified link when the div is clicked
        window.location.href = "/admin"; // Replace with the actual link
    });
</script>
</body>
</html>