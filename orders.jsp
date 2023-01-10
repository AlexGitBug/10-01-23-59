<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
  <title>Заказы</title>
</head>
<body>

<%@include file="header.jsp" %>
_____________________________________________________________________________<br>
<%--<form action="/order" method="post">--%>
<%--    <label><br>--%>
<%--        <br>--%>
<%--        Список всех комнат:--%>
<%--        <ul><c:forEach var="room" items="${requestScope.roomlist}">--%>
<%--            <li>--%>
<%--                <img width="210" height="170" src="${pageContext.request.contextPath}/users/users${room.image}" alt="No image"><br>--%>
<%--                <a href="/room?id=${room.id}">Описание(номер комнаты, статус): ${room.number} - ${room.status}</a>--%>
<%--            </li>--%>
<%--        </c:forEach>--%>
<%--        </ul>--%>
<%--    </label><br>--%>
<h1>Оформление заказа</h1>
<form action="/order" method="post">
  <label>Rooms:
    <select name="roomid" id="roomid">
      <c:forEach var="roomid" items="${requestScope.roomid}">
        <option value="${roomid.id}">${roomid.number}</option>
      </c:forEach>
    </select>
  </label><br>
  <label for="begintime">Begin Time:
    <input type="date" name="begintime" id="begintime">
  </label><br>
  <label for="endtime">End Time:
    <input type="date" name="endtime" id="endtime">
  </label><br>
  <label>Condition:
    <input type="radio" name="conditions" value="WANT_TO_RESERVE"> Want to reserve
    <%--        <select name="conditions" id="conditions">--%>
    <%--            <c:forEach var="conditions" items="${requestScope.conditions}">--%>
    <%--                <option value="${conditions}">${conditions}</option>--%>
    <%--            </c:forEach>--%>
    <%--        </select>--%>
  </label><br>Message:
  <label for="message">
    <input type="text" name="message" id="message">
  </label><br>
  <button type="submit">Send</button><br>
</form>
<br>
<form action="/userorderlist" method="get">
  <button type="submit">List of my orders</button>
</form>
<br>
<form action="${pageContext.request.contextPath}/findallfreeroom" method="get">
  <button type="submit">Display all free rooms</button>
</form>
_____________________________________________________________________________
<%@include file="footer.jsp"%>

</body>
</html>