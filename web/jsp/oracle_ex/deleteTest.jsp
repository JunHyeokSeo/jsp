<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("utf-8");

    String id = request.getParameter("id");
    String passwd = request.getParameter("passwd");

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        String url = "jdbc:oracle:thin:@localhost:1521:xe";
        String user = "scott";
        String password = "tiger";

        Class.forName("oracle.jdbc.driver.OracleDriver");
        con = DriverManager.getConnection(url, user, password);

        String sql = "select * from member1 where id = ?";

        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String rId = rs.getString("id");
            String rPasswd = rs.getString("passwd");

            if (id.equals(rId) && passwd.equals(rPasswd)) {
                sql = "delete from member1 where id=?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, id);
                pstmt.executeUpdate();
%>
<script>
    alert("회원 삭제 성공");
    location.href = "selectTest.jsp";
</script>
<%
} else {
%>
<script>
    alert("비밀번호가 틀렸습니다.");
    history.go(-1);
</script>
<% }%>


<% } else { %>

<script>
    alert("ID가 틀렸습니다.");
    history.go(-1);
</script>

<%
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try {
            rs.close();
        } catch (SQLException sqle) {
        }
        if (pstmt != null) try {
            pstmt.close();
        } catch (SQLException sqle) {
        }
        if (con != null) try {
            con.close();
        } catch (SQLException sqle) {
        }
    }
%>