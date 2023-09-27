<%@ page contentType = "text/html; charset=utf-8" %>

<html>
	<head><title>include 디렉티브</title></head>
	<body>

<%
    int number = 10;
%>

<%--하나의 파일처럼 동작, 변수 공유 가능, 결과 파일이 하나의 servlet 파일--%>
<%@ include file="includee.jspf" %>

공통변수 DATAFOLDER = "<%= dataFolder %>"

	</body>
</html>