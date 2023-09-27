<%@ page contentType="text/html; charset=utf-8" %>
<%
    String name = "java";
    String value = "1234";
    
    if (name != null && value != null) {
		//폴더가 달라도 공유가 된다.
        application.setAttribute(name, value); // 공유설정
    }
%>

<html>
<head><title>application 속성 지정</title></head>
<body>
<%
    if (name != null && value != null) {
%>
		application 기본 객체의 속성 설정: <br>
 		<%= name %>  = <%= value %>
<%
    } else {
%>
		application 기본 객체의 속성 설정 안함
<%
    }
%>
</body>
</html>