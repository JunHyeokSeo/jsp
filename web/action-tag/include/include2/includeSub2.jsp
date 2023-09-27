<%@ page contentType="text/html;charset=utf-8"%>

<html>
	<body>

	<%
		String siteName = request.getParameter("siteName");
	%>

	includeSub2.jsp 페이지 입니다.<p>

	<b><%=siteName%></b>
	<hr>

	</body>
</html>