<%@ page contentType="text/html; charset=utf-8" %>

<%
    // 브라우저를 종료하지 않더라도 세션을 삭제하기 위한 코드
    session.invalidate();
%>

<html>
<head><title>세션 종료</title></head>
<body>

세션을 종료하였습니다.

</body>
</html>