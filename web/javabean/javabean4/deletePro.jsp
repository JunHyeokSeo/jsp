<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="javaBeanExam.register.LogonDataBean" %>
<%@ page import="javaBeanExam.register.LogonDBBean" %>
<%@include file="color.jsp" %>

<%
    request.setCharacterEncoding("utf-8");

    LogonDataBean regBean1 = new LogonDataBean();
    // regBean1.id="test";
%>

<jsp:useBean id="regBean" class="javaBeanExam.register.LogonDataBean"/>
<jsp:setProperty name="regBean" property="*"/>

<%
    LogonDBBean manager = LogonDBBean.getInstance();

    LogonDataBean old = manager.updateForm(regBean.getId());

    if (old.getPasswd().equals(regBean.getPasswd())) { // 비번 일치시
        manager.delete(regBean);    // delete SQL문 실행

%>
<script>
    alert("회원삭제 성공");
    location.href = "list.jsp";
</script>

<% } else {    // 비번 불일치시	%>

<script>
    alert("비밀번호가 일치하지 않습니다.");
    history.go(-1);
</script>

<% } %>



