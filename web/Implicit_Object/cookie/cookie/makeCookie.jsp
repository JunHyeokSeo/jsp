<%@ page contentType="text/html; charset=utf-8" %>

<html>
	<head>
		<title>쿠키를 생성하는 예제</title>
	</head>

<%
    String cookieName = "id";
    //쿠키 생성 (name: id, value: totoro)
    Cookie cookie = new Cookie(cookieName, "totoro");
    //만료기간 설정
    cookie.setMaxAge(60 * 60);
    //쿠키의 값을 'guardian'으로 수정
    cookie.setValue("guardian");
    //response 객체를 사용하여 쿠키를 클라이언트에 저장(=쿠키발행)
    response.addCookie(cookie);
%>

	<body>
	<h2>쿠키를 생성하는 예제</h2>
	<P>

"<%=cookieName%>" 쿠키가생성 되었습니다.<br>

		<input type="button" value="쿠키의 내용확인" onclick="javascript:location.href='useCookie.jsp'">
	</P>
	</body>
</html>