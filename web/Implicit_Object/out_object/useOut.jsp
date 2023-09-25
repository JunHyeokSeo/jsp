<%@ page contentType = "text/html; charset=utf-8" %>

<html>
<head><title>out 기본 객체 사용</title></head>
<body>

<%
    // 줄바꿈 기능이 없음.
    // ex) 안녕하세요? 안녕하세요?
    out.println("안녕하세요?");
    out.println("안녕하세요?");

	// scriptlet Tag 안에 html 태그 직접 입력 불가능.
    // out.print 메소드 내부에 선언하여 줄바꿈 가능
    out.print("<br>");
    out.println("안녕하세요?");

%>
<br>

out 기본 객체를 사용하여 
<%
    out.println("출력한 결과입니다.");
%>

</body>
</html>