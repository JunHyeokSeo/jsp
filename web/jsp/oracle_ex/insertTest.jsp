<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*"%>

<%
  request.setCharacterEncoding("utf-8");

  String id= request.getParameter("id");
  String passwd= request.getParameter("passwd");
  String name= request.getParameter("name");
  Timestamp register=new Timestamp(System.currentTimeMillis());

  Connection con=null;
  PreparedStatement pstmt=null;
  int result = 0;
  
  try{
    String url="jdbc:oracle:thin:@localhost:1521:xe";
	String user="scott";
	String password="tiger";
	 
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con=DriverManager.getConnection(url,user,password);
	
	String sql= "insert into member1 values (?,?,?,sysdate)";
	pstmt=con.prepareStatement(sql);
	pstmt.setString(1, id);
	pstmt.setString(2, passwd);
	pstmt.setString(3, name);
	//	pstmt.setTimestamp(4,register);
	result = pstmt.executeUpdate();

} catch (Exception e) {
	e.printStackTrace();
} finally {
	if (pstmt != null) try { pstmt.close();} catch (SQLException sqle) {}
	if (con != null) try { con.close();} catch (SQLException sqle) {}
}
%>

<html>
<head><title>회원가입</title></head>
<body>
  
<%
	if(result == 1){
%>    
  		<script>
  			alert("회원가입 성공");
  			location.href="selectTest.jsp";
  		</script>
<% 	}else{%>
   		<script>
			alert("회원가입 실패");
			history.go(-1);
   		</script>
<% 	} %>   
</body>
</html>