<%@ page import="member.MemberDAO" %>
<%@ page import="member.MemberDTO" %><%--
  Created by IntelliJ IDEA.
  User: jun
  Date: 2023/10/06
  Time: 4:36 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="member" class="member.MemberDTO"/>
<jsp:setProperty name="member" property="*"/>

<%
    MemberDAO dao = MemberDAO.getInstance();
    MemberDTO old = dao.getMember(member.getId());

    if (old.getPasswd().equals(member.getPasswd())) {
        int result = dao.delete(member.getId());
        if (result == 1) {
            session.invalidate();
%>
<script>
    alert('회원 탈퇴 성공');
    location.href = 'main.jsp';
</script>
<%      }
    } else { %>
<script>
    alert('회원 탈퇴 실패');
    history.go(-1);
</script>
<%  }   %>