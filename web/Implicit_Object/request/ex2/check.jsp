<%@ page contentType="text/html;charset=utf-8"%>

<html>
<head>
    <title>좋은 사이트 선택</title>	
	<meta charset="utf-8">		
</head>
<body>
	<%
        // 한글 인코딩 처리
		request.setCharacterEncoding("utf-8");

		// 여러개의 파라미터 값을 구함
		String[] choice = request.getParameterValues("site");
		String result = "";

		for (int i = 0; i < choice.length; i++) {
			result = result + choice[i] + " ";
		}
	%>

	<center>
		당신은 <font color=blue><%=result%></font> 를 좋아하시는군요.
	</center>

</body>
</html>