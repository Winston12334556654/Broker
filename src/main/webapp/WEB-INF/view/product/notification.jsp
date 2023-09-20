<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/view/header.jsp" %>
<%@ include file="/WEB-INF/view/navbar.jsp" %>




<html>
<head>
    <title>Notifications</title>
</head>
<body>
<h1>Notifications</h1>


<div class="notifications">

    <ul>
        <c:forEach items="${notifications}" var="notification">
            <c:if test="${notification.status eq 'unread'}">
                <li>${notification.senderName} poked your product ${userDao.getProductNameById(notification.productId)} - Unread</li>
            </c:if>
        </c:forEach>
    </ul>
</div>
<%--<div class="read-notifications">--%>
<%--    <h2>Read Notifications:</h2>--%>
<%--    <ul>--%>
<%--        <c:forEach items="${notifications}" var="notification">--%>
<%--            <c:if test="${notification.status eq 'read'}">--%>
<%--                <li>${notification.content} - Read</li>--%>
<%--            </c:if>--%>
<%--        </c:forEach>--%>
<%--    </ul>--%>
<%--</div>--%>
</body>
</html>


<%@ include file="/WEB-INF/view/footer.jsp" %>