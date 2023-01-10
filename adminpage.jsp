<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Admin Page</title>
</head>

<body>
<%@ include file="header.jsp" %><br>
_____________________________________________________________________________<br>
<h1>Administration page</h1>

<form action="${pageContext.request.contextPath}/addroom" method="get">
  <button type="submit">Add room</button>
</form>
<form action="${pageContext.request.contextPath}/seeallordersforadmin" method="get">
  <button type="submit">List of all orders for admin</button>
</form>
<form action="${pageContext.request.contextPath}/findallrooms" method="get">
  <button type="submit">Display all rooms</button>
</form>
<form action="${pageContext.request.contextPath}/download_admin_report" method="get">
  <button type="submit">Download all orders</button>
</form>
_____________________________________________________________________________<br>
<%@include file="footer.jsp" %>

</body>
</html>