// DAO(Data Access Object)
package com.example.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MemberDAOImpl {

	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;

	public int checkMemberId(String id) {
		int re = -1; 	// 사용 가능한 ID

		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";

		try {
			Class.forName(driver); // JDBC Driver Loading
			con = DriverManager.getConnection(url, "scott", "tiger");

			sql = "select * from join_member where join_id=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				re = 1; 	// 중복 ID
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		System.out.println("re : " + re);
		return re;
	}
//	public static void main(String[] args) {
//		MemberDAOImpl md=new MemberDAOImpl();
//		String id = "aaaa";
//		System.out.println("result : " + md.checkMemberId(id));
//	}
}
