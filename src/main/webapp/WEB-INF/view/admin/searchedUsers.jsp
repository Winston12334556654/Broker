<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="app.model.User, java.util.List" %>

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
    </style>
</head>
<body>
<div class="container">
    <h1>Searched Users</h1>

    <c:set var="searchedUsers" value="${requestScope.searchedUsers}" />

    <table class="table">
        <thead class="thead-dark">
        <tr>
            <th scope="col">Id</th>
            <th scope="col">Name</th>
            <th scope="col">Mail</th>
            <th scope="col">Phone</th>
            <th scope="col">Address</th>
            <th scope="col">Created Date</th>
            <th scope="col">Locked</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${searchedUsers}" var="user">
            <tr>
                <td>${user.getId()}</td>
                <td>${user.getName()}</td>
                <td>${user.getMail()}</td>
                <td>${user.getPhone()}</td>
                <td>${user.getAddress()}</td>
                <td>${user.getCreated_date()}</td>
                <td>
                    <form action="/toggleLock" method="post">
                        <input type="hidden" name="id" value="${user.getId()}">
                        <input type="hidden" name="lockStatus" value="${user.isLocked()}">
                        <button type="submit" class="btn btn-link" name="action" value="toggleLock">
                                ${user.isLocked() ? "Unban" : "Ban"}
                        </button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>

<jsp:include page="/WEB-INF/view/admin/footer.jsp" />
