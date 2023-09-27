<%@ page contentType="text/html;charset=utf-8"%>

<html>
	<body>

	<h1>포워딩하는 페이지: forwardFrom2.jsp</h1>

	<%
		request.setCharacterEncoding("utf-8");

//		String name1 = "안화수";
		String bloodType = request.getParameter("bloodType") + ".jsp";
	
//		String bloodType = "a.jsp";
	%>

	<jsp:forward page="<%=bloodType%>"/>
	