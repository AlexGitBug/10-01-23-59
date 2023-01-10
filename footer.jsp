
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Переход на главную страницу</title>
</head>
<body>
<%--ADMIN--%>
<c:if test="${sessionScope.user.role.id == 2}">
  <div id="main page">
    <form action="${pageContext.request.contextPath}/mainpage" method="post">
      <button type="submit">Back to main page</button>
    </form>
    <form action="${pageContext.request.contextPath}/adminpage" method="get">
      <button type="submit">Back to admin page</button>
    </form>
  </div>
</c:if>
<%--USER--%>
<c:if test="${sessionScope.user.role.id == 1}">
  <div id="main page">
    <form action="${pageContext.request.contextPath}/mainpage" method="post">
      <button type="submit">Back to main page</button>
    </form>
    <form action="${pageContext.request.contextPath}/order" method="get">
      <button type="submit">Back to order page</button>
    </form>
  </div>
</c:if>
</body>
</html>