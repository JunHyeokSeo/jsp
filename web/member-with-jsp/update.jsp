<%@ page import="member.MemberDAO" %>
<%@ page import="member.MemberDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="member" class="member.MemberDTO"/>
<jsp:setProperty name="member" property="*"/>

<%
    String[] hobbies = request.getParameterValues("hobby");
    String hobby = "";
    for (String h : hobbies) {
        hobby += h + " ";
    }
    member.setHobby(hobby);

    //DAO 객체 생성
    MemberDAO dao = MemberDAO.getInstance();
    MemberDTO old = dao.getMember(member.getId());

	if (member.getPasswd().equals(old.getPasswd())){
        int result = dao.update(member);
		if(result == 1){
%>
            <script>
                alert("수정 성공!");
                location.href = 'main.jsp';
            </script>
<%
        }
	} else { %>
    <script>
        alert("비번 불일치!");
        history.go(-1);
    </script>
<%  }   %>