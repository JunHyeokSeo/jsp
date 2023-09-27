<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
<%
	pageContext.setAttribute("pageScope", "pageValue");
	request.setAttribute("requestScope", "requestValue");
%>
<%--지정된 페이지로 바로 포워딩, 화면상에 출력 x--%>
<jsp:forward page="requestTest5Result.jsp"></jsp:forward>
</body>
</html>