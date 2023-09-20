<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="app.model.User, java.util.List" %>

<jsp:include page="/WEB-INF/view/admin/header.jsp" />
<jsp:include page="/WEB-INF/view/admin/navbar.jsp" />

<html>
<head>
    <style>
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
        .admin-image {
            max-width: 100px;
            max-height: 100px;
            width: auto; /* Ensures the image scales proportionally */
            height: auto; /* Ensures the image scales proportionally */
        }
    </style>
</head>
<body>
<div class="container">
    <h1>View Admins</h1>

    <c:set var="admins" value="${requestScope.admins}" />

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
        <c:forEach items="${admins}" var="admin">
            <tr> <!-- Move the opening <tr> tag here -->
                <td>${admin.getId()}</td>
                <td><img src="../productImage/${admin.user_image_path}" alt="${admin.getName()}" class="admin-image"></td>

                <td>${admin.getName()}</td>
                <td>${admin.getMail()}</td>
                <td>${admin.getPhone()}</td>
                <td>${admin.getAddress()}</td>
                <td>${admin.getCreated_date()}</td>
                <td>
                    <c:if test="${admin.getId() != id}">
                        <form action="/toggleLockAdmin" method="post">
                            <input type="hidden" name="id" value="${admin.getId()}">
                            <input type="hidden" name="lockStatus" value="${admin.isLocked()}">
                            <button type="submit" class="btn btn-link" name="action" value="toggleLock">
                                    ${admin.isLocked() ? "Unban" : "Ban"}
                            </button>
                        </form>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>

<jsp:include page="/WEB-INF/view/admin/footer.jsp" />
