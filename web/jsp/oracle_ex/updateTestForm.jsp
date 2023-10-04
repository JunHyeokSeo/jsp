<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*"%>

<%
  String uid=request.getParameter("id");

  Connection con=null;
  PreparedStatement pstmt=null;
  ResultSet rs=null; 
  
  try{
	String url="jdbc:oracle:thin:@localhost:1521:xe";
	String user="scott";
	String password="tiger";
		 
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con=DriverManager.getConnection(url,user,password);
	
	String sql= "select * from member1 where id=?";
	
	pstmt=con.prepareStatement(sql);
	pstmt.setString(1, uid);
	rs=pstmt.executeQuery();

	if(rs.next()){
	  String id= rs.getString("id");
      String passwd= rs.getString("passwd");
      String name= rs.getString("name");
      Timestamp register=rs.getTimestamp("reg_date");

%>
<html>
<head><title>회원정보 수정</title></head>

<body>
  <h2>회원정보 수정</h2>

  <FORM METHOD="post" ACTION="updateTest.jsp">
  <input type=hidden name="id" value="<%=id %>">
    아이디 : <%=id %><p>
    패스워드 : <INPUT TYPE="password" NAME="passwd"><p>
    변경할 이름:<INPUT TYPE="text" NAME="name" value="<%=name%>"><p>
    <INPUT TYPE="submit" VALUE="보내기">
  </FORM>

</body>
</html>

<%  } // if end
  }catch(Exception e){ 
		e.printStackTrace();
  }finally{
	    if(rs != null) try{rs.close();}catch(SQLException sqle){}
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
		if(con != null) try{con.close();}catch(SQLException sqle){}
  }
%>




