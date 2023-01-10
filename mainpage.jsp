

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Главная страница/Страница ожидания</title>
</head>
<body>
<%@include file="header.jsp" %><br>
_____________________________________________________________________________
<ul>
    Вы на главной странице. Спасибо, что с нами
</ul>
<br>
<%--<form action="${pageContext.request.contextPath}/order" method="get">--%>
<%--    <button type="submit">Booking room</button>--%>
<%--</form>--%>
<%--<br>--%>
<form action="/userorderlist" method="get">
    <button type="submit">List of my orders</button>
</form>
<br>
_____________________________________________________________________________
<%@include file="footer.jsp" %>
</body>
</html>