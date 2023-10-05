package javaBeanExam.register;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class LogonDBBean {
	//싱글톤
	private static final LogonDBBean instance = new LogonDBBean();
	int result;
	Connection con = null;
	PreparedStatement pstmt = null;
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";

	//정적 메소드
	public static LogonDBBean getInstance() {
		return instance;
	}

	//회원가입 : 주소값 전달에 의한 메소드 호출 방식
	public int insertMember(LogonDataBean member) {
		result = 0;

		try {
			//JDBC 방식
			Class.forName(driver);
			con = DriverManager.getConnection(url, "scott", "tiger");

			String sql = "insert into member2 values(?, ?, ?, ?, ?, ?, ?, sysdate)";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPasswd());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getJumin1());
			pstmt.setString(5, member.getJumin2());
			pstmt.setString(6, member.getEmail());
			pstmt.setString(7, member.getBlog());

			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) pstmt.close();
				if (con != null) con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}

	//전체 회원목록 구하기
	public List<LogonDataBean> selectMember() {
		List<LogonDataBean> list = new ArrayList<LogonDataBean>();
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, "scott", "tiger");

			String sql = "select * from member2 order by REG_DATE asc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				LogonDataBean member = updateForm(rs.getString("id"));
				list.add(member);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (con != null) con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	public LogonDataBean updateForm(String id) {
		LogonDataBean member = new LogonDataBean();
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, "scott", "tiger");

			String sql = "select * from member2 where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				member.setId(rs.getString("id"));
				member.setPasswd(rs.getString("passwd"));
				member.setName(rs.getString("name"));
				member.setJumin1(rs.getString("jumin1"));
				member.setJumin2(rs.getString("jumin2"));
				member.setEmail(rs.getString("email"));
				member.setBlog(rs.getString("blog"));
				member.setReg_date(rs.getDate("reg_date"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (con != null) con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return member;
	}

	public void update(LogonDataBean regBean) {
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, "scott", "tiger");

			String sql = "update member2 set NAME=?, JUMIN1=?, JUMIN2=?, EMAIL=?, BLOG=?, REG_DATE=sysdate where ID=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, regBean.getName());
			pstmt.setString(2, regBean.getJumin1());
			pstmt.setString(3, regBean.getJumin2());
			pstmt.setString(4, regBean.getEmail());
			pstmt.setString(5, regBean.getBlog());
			pstmt.setString(6, regBean.getId());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) pstmt.close();
				if (con != null) con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public void delete(LogonDataBean regBean) {
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, "scott", "tiger");

			String sql = "delete from member2 where ID=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, regBean.getId());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) pstmt.close();
				if (con != null) con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
