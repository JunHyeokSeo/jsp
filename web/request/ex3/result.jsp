<%@ page contentType="text/html;charset=utf-8" %>

<html>
	<head>
	<title>설문조사 결과</title>
	<meta charset="utf-8">
	</head>
	<body>

	<%
		request.setCharacterEncoding("utf-8");
	
		String choiceseason = request.getParameter("season");
		String result = "";
	%>

		당신이 가장 좋아하는 계절은 <%=choiceseason%> 입니다.
		
	</body>
</html>