<%@ page contentType="text/html; charset=utf-8" %>

<html>
<head><title>회원가입</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	$(document).ready(function(){
		$("form").submit(function(){
			if($("#id").val()==""){
				alert("ID를 입력 하세요");
				$("#id").focus();
				return false;
			}
			if($("#passwd").val()==""){
				alert("비밀번호를 입력 하세요");
				$("#passwd").focus();
				return false;
			}
			if($("#name").val()==""){
				alert("이름을 입력 하세요");
				$("#name").focus();
				return false;
			}
		});
		
	});
</script>
</head>

<body>
  <h2>회원가입</h2>

  <FORM METHOD="post" ACTION="insertTest.jsp">
    아이디 : <INPUT TYPE="text" NAME="id" id="id"><p>
    패스워드 : <INPUT TYPE="password" NAME="passwd" id="passwd"><p>
    이름 : <INPUT TYPE="text" NAME="name" id="name"><p>
    <INPUT TYPE="submit" VALUE="보내기">
  </FORM>

</body>
</html>