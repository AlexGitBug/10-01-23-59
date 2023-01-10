<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Заказ</title>
</head>
<body>
<h1>Заказ:</h1>
  <c:forEach var="order" items="${requestScope.orderlist}">
    <ul>
      Order ID: ${order.id}<br>
        ${order.message}<br>
      или любая другая информация<br>
    </ul>
  </c:forEach>
  <form action="${pageContext.request.contextPath}/messageforadmintocancel" method="get">
    <button type="submit" name="id" value="${requestScope.order.id}">Send message for admin</button>
  </form>
</body>
</html>