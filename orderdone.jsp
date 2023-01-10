
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Заказ на обработке</title>
</head>
<body>
<%@include file="header.jsp" %><br>
_____________________________________________________________________________
<form action="/orderdone" method="get">
    Заказ на обработке. Подтверждение будет выслано на почту
</form><br>
<%--<form action="${pageContext.request.contextPath}/order" method="get">--%>
<%--  <button type="submit">Back to the order page</button>--%>
<%--</form><br>--%>
_____________________________________________________________________________
<%@include file="footer.jsp" %>
</body>
</html>