<%@ page import="member.MemberDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="member" class="member.MemberDTO"/>
<jsp:setProperty name="member" property="*"/>
<%
    MemberDAO dao = MemberDAO.getInstance();
    int result = dao.memberCheck(member);   //회원인증 처리

    if (result == 1) {
		// 세션 공유 설정
		session.setAttribute("id", member.getId());
%>
        <script>
            alert('로그인 성공');
            location.href = 'main.jsp';
        </script>
<%  } else {%>
        <script>
            alert('로그인 실패');
            history.go(-1);
        </script>
<%  } %>