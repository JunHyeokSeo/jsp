<%@ page contentType="text/html; charset=utf-8" %>

<html>
	<head><title>세션 사용 예제</title>
	</head>
	<body>

<%
	String id = "guardian23";
	String passwd = "1234";

	//서버측에 세션 정보 저장.
	session.setAttribute("id", id);
	session.setAttribute("passwd", passwd);
%>

	세션에 id 와 passwd 속성을 설정하였습니다.<br><br>

    <%--페이지를 이동할 때 아무런 값을 가져가지 않아도 공유가 된다.--%>
	<input type="button" value="세션의 설정된 속성확인" onclick="javascript:window.location='viewSession.jsp'">
	</body>
</html>