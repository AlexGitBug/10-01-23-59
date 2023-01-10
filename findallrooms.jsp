<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>All rooms</title>
</head>
<body>

<%@include file="header.jsp" %>
_____________________________________________________________________________
<form action="/findallrooms" method="get" enctype="multipart/form-data">
  <label><br>
    Список всех комнат:
    <ul><c:forEach var="room" items="${requestScope.roomlist}">
      <li>
        <img width="210" height="170" src="${pageContext.request.contextPath}/users/users${room.image}" alt="No image"><br>
        <a href="/room?id=${room.id}">Описание(номер комнаты, статус): ${room.number} - ${room.status}</a>
      </li>
    </c:forEach>
    </ul>
  </label>
</form><br>
<form action="${pageContext.request.contextPath}/order" method="get">
  <button type="submit">Back to make a new order</button>
</form>
_____________________________________________________________________________
<br>
<%@include file="footer.jsp" %>
</body>