<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="app.daos.AdminDao, app.model.User, java.util.List" %>

<jsp:include page="/WEB-INF/view/admin/header.jsp" />
<jsp:include page="/WEB-INF/view/admin/navbar.jsp" />
<html>
<head>
    <style>
        /* Your existing CSS styles */

        /* Additional styles for the table */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }

        /* Add the following style to adjust image size */
        .product-image {
            max-width: 100px; /* Adjust the maximum width as needed */
            max-height: 100px; /* Adjust the maximum height as needed */
        }
        .user-image {
            max-width: 100px;
            max-height: 100px;
            width: auto; /* Ensures the image scales proportionally */
            height: auto; /* Ensures the image scales proportionally */
        }
        #warning-container-wrapper1 {
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

        #warning-container1 {
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

        #dialog-yes1 {
            background-color: green;
            color: white;
        }

        #dialog-no1 {
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
<div class="container">
    <h1>View Users</h1>

    <%-- Retrieve the list of users from the request attribute --%>
    <c:set var="users" value="${requestScope.customers}" />

    <table class="table">
        <thead class="thead-dark">
        <tr>
            <th scope="col">Id</th>
            <th scope="col">Image</th>
            <th scope="col">Name</th>
            <th scope="col">Mail</th>
            <th scope="col">Phone</th>
            <th scope="col">Address</th>
            <th scope="col">Created Date</th>
            <th scope="col">Locked</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${users}" var="user">
            <tr>
                <td>${user.getId()}</td>
                <td><img src="../productImage/${user.user_image_path}" alt="${user.getName()}" class="user-image"></td>


                <td>${user.getName()}</td>
                <td>${user.getMail()}</td>
                <td>${user.getPhone()}</td>
                <td>${user.getAddress()}</td>
                <td>${user.getCreated_date()}</td>

                <td>
                    <form action="/toggleLock" method="post">
                        <input type="hidden" name="id" value="${user.getId()}">
                        <input type="hidden" name="lockStatus" value="${user.isLocked()}">

                        <button type="submit" class="btn btn-link ban-button"
                                name="action" value="toggleLock">
                                ${user.isLocked() ? "Unban" : "Ban"}
                        </button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<div id="warning-container-wrapper1" style="display: none;">
    <div id="warning-container1">
        <h2>Are you sure you want to ban/unban this user?</h2>
        <div class="dialog-buttons">
            <button class="dialog-button" id="dialog-yes1">Yes</button>
            <button class="dialog-button" id="dialog-no1">No</button>
        </div>
    </div>
</div>
<script>
    ////For customerView ban

    document.addEventListener("DOMContentLoaded", function () {
        // JavaScript code to handle the ban and unban button click events
        const banButtons = document.querySelectorAll(".ban-button");

        function showConfirmationDialog(dialogId) {
            // Show the specified dialog and blur the background
            document.getElementById(dialogId).style.display = "flex";
            document.body.style.overflow = "hidden";
        }

        function hideConfirmationDialog(dialogId) {
            // Hide the specified dialog and remove the background blur
            document.getElementById(dialogId).style.display = "none";
            document.body.style.overflow = "auto";
        }

        banButtons.forEach(function (banButton) {
            banButton.addEventListener("click", function (e) {
                e.preventDefault(); // Prevent the default link behavior
                showConfirmationDialog("warning-container-wrapper1");

                // Set up the "Yes" button action to continue with the form submission
                document.getElementById("dialog-yes1").addEventListener("click", function () {
                    // Submit the form associated with the clicked button
                    const form = e.target.closest("form");
                    if (form) {
                        form.submit();
                    }
                });

                // Handle the "No" button click event
                document.getElementById("dialog-no1").addEventListener("click", function () {
                    hideConfirmationDialog("warning-container-wrapper1");
                });
            });
        });
    });
</script>
</body>
</html>
<jsp:include page="/WEB-INF/view/admin/footer.jsp" />




<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<%--<%@ page import="app.daos.AdminDao, app.model.User, java.util.List" %>--%>

<%--<jsp:include page="/WEB-INF/view/admin/header.jsp" />--%>
<%--<jsp:include page="/WEB-INF/view/admin/navbar.jsp" />--%>
<%--<html>--%>
<%--<head>--%>
<%--    <style>--%>
<%--        /* Your existing CSS styles */--%>

<%--        /* Additional styles for the table */--%>
<%--        table {--%>
<%--            width: 100%;--%>
<%--            border-collapse: collapse;--%>
<%--            margin-top: 20px;--%>
<%--        }--%>
<%--        th, td {--%>
<%--            border: 1px solid #dddddd;--%>
<%--            text-align: left;--%>
<%--            padding: 8px;--%>
<%--        }--%>
<%--        th {--%>
<%--            background-color: #f2f2f2;--%>
<%--        }--%>

<%--        /* Add the following style to adjust image size */--%>
<%--        .product-image {--%>
<%--            max-width: 100px; /* Adjust the maximum width as needed */--%>
<%--            max-height: 100px; /* Adjust the maximum height as needed */--%>
<%--        }--%>
<%--        .user-image {--%>
<%--            max-width: 100px;--%>
<%--            max-height: 100px;--%>
<%--            width: auto; /* Ensures the image scales proportionally */--%>
<%--            height: auto; /* Ensures the image scales proportionally */--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="container">--%>
<%--    <h1>View Users</h1>--%>

<%--    &lt;%&ndash; Retrieve the list of users from the request attribute &ndash;%&gt;--%>
<%--&lt;%&ndash;    <c:set var="userId" value="${sessionScope.id}" />&ndash;%&gt;--%>
<%--    <c:set var="users" value="${requestScope.customers}" />--%>


<%--    <table class="table">--%>
<%--        <thead class="thead-dark">--%>
<%--        <tr>--%>
<%--            <th scope="col">Id</th>--%>
<%--            <th scope="col">Image</th>--%>
<%--            <th scope="col">Name</th>--%>
<%--            <th scope="col">Mail</th>--%>
<%--            <th scope="col">Phone</th>--%>
<%--            <th scope="col">Address</th>--%>
<%--            <th scope="col">Created Date</th>--%>
<%--            <th scope="col">Locked</th>--%>
<%--        </tr>--%>
<%--        </thead>--%>
<%--        <tbody>--%>
<%--        <c:forEach items="${users}" var="user">--%>
<%--            <tr>--%>
<%--                <td>${user.getId()}</td>--%>
<%--                <td><img src="../productImage/${user.user_image_path}" alt="${user.getName()}" class="user-image"></td>--%>



<%--                <td>${user.getName()}</td>--%>
<%--                <td>${user.getMail()}</td>--%>
<%--                <td>${user.getPhone()}</td>--%>
<%--                <td>${user.getAddress()}</td>--%>
<%--                <td>${user.getCreated_date()}</td>--%>
<%--                    &lt;%&ndash;                Ban Unban Toggle , and the typed "userId" would go through the controller paragm--%>
<%--                                            Ndai kaw na id la na rai nga ai. dai Id hte sha controller de shang nna data base kaw--%>
<%--                                            Where Id=? hte sha sa hkrum na update galaw na &ndash;%&gt;--%>
<%--                <td>--%>
<%--                    <form action="/toggleLock" method="post">--%>
<%--                        <input type="hidden" name="id" value="${user.getId()}">--%>
<%--                            &lt;%&ndash;                 user.islocked()    model class htae ka boolean methods &ndash;%&gt;--%>
<%--                        <input type="hidden" name="lockStatus" value="${user.isLocked()}">--%>
<%--                        <button type="submit" class="btn btn-link" name="action" value="toggleLock">--%>
<%--                                ${user.isLocked() ? "Unban" : "Ban"}--%>
<%--                        </button>--%>
<%--                    </form>--%>
<%--                </td>--%>
<%--            </tr>--%>
<%--        </c:forEach>--%>
<%--        </tbody>--%>
<%--    </table>--%>
<%--</div>--%>
<%--</body>--%>
<%--</html>--%>

<%--<jsp:include page="/WEB-INF/view/admin/footer.jsp" />--%>