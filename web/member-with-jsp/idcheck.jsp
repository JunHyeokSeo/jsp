<%@ page import="member.MemberDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
    $(function () {
        //중복 ID
        $('#close1').click(function () {
            //opener == 부모 창
            opener.$('#id').val("").focus();
            window.close();
        });

        //사용가능 ID
        $('#close2').click(function () {
            opener.$('#passwd').focus();
            window.close();
        });
    });
</script>

<%
    String id = request.getParameter("id");
    MemberDAO dao = MemberDAO.getInstance();

    int result = dao.memberAuth(id);
    if (result == 1) {  //중복
%>
    <%=id%>는 중복 ID 입니다.<br><br><br>
    <input type="button" value="닫기" id="close1">
<%  } else { %>
    <%=id%>는 사용 가능한 ID입니다.<br><br><br>
    <input type="button" value="닫기" id="close2">
<%  } %>