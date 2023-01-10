<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Добавление комнаты</title>
</head>
<body>
<%@ include file="header.jsp" %><br>
_____________________________________________________________________________
<h1>Добавление комнаты</h1>
<form action="/addroom" method="post" enctype="multipart/form-data">
    <label for="number_room"> Room Number:
        <select name="number_room" id="number_room">
            <c:forEach var="number_room" items="${requestScope.numbers}">
                <option value="${number_room}">${number_room}</option>
            </c:forEach>
        </select>
    </label><br>
    <label for="quantitybed"> Quantity Bed:
        <select name="quantity_bed_id" id="quantitybed">
            <c:forEach var="quantitybed" items="${requestScope.quantitybed}">
                <option value="${quantitybed.id}">${quantitybed.capacity}</option>
            </c:forEach>
        </select>
    </label><br>
    <label for="categoryroom"> Category Room:
        <select name="category_room_id" id="categoryroom">
            <c:forEach var="categoryroom" items="${requestScope.categoryroom}">
                <option value="${categoryroom.id}">${categoryroom.kind}</option>
            </c:forEach>
        </select>
    </label><br>
    <label for="floors"> Floor:
        <select name="floor" id="floors">
            <c:forEach var="floors" items="${requestScope.floors}">
                <option value="${floors}">${floors}</option>
            </c:forEach>
        </select>
    </label><br>
    <label for="dayprice">Day price:
        <input type="dayprice" name="day_price" id="dayprice" required>
    </label><br>
    <label for="statuses"> Status:
        <select name="status" id="statuses">
            <c:forEach var="statuses" items="${requestScope.statuses}">
                <option value="${statuses}">${statuses}</option>
            </c:forEach>
        </select>
    </label><br>
    <label for="imageid"> Картинка:
        <input type="file" name="image" id="imageid" required>
    </label><br>
    <button type="submit">Send</button>
</form><br>
_____________________________________________________________________________
<%@ include file="footer.jsp" %>
</body>
</html>