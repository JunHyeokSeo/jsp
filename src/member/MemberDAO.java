//DAO(Data Access Object)

package member;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MemberDAO {
	int result;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	// 싱글톤
	private static final MemberDAO instance = new MemberDAO();

	public static MemberDAO getInstance() {
		return instance;
	}

	// 커넥션 풀에서 커넥션을 구해오는 메소드
	private static Connection getConnection() throws Exception {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/orcl");
		return ds.getConnection();
	}

	public int insert(MemberDTO member) {
		result = 0;

		try {
			con = getConnection();
			String sql = "insert into TOTORO.MEMBER values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPasswd());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getJumin1());
			pstmt.setString(5, member.getJumin2());
			pstmt.setString(6, member.getMailid());
			pstmt.setString(7, member.getDomain());
			pstmt.setString(8, member.getTel1());
			pstmt.setString(9, member.getTel2());
			pstmt.setString(10, member.getTel3());
			pstmt.setString(11, member.getPhone1());
			pstmt.setString(12, member.getPhone2());
			pstmt.setString(13, member.getPhone3());
			pstmt.setString(14, member.getPost());
			pstmt.setString(15, member.getAddress());
			pstmt.setString(16, member.getGender());
			pstmt.setString(17, member.getHobby());
			pstmt.setString(18, member.getIntro());

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

	//ID 중복검사
	public int memberAuth(String id) {
		result = 0;

		try {
			con = getConnection();
			String sql = "select * from TOTORO.MEMBER where ID=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = 1;
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
		return result;
	}

	// 로그인(회원인증 처리)
	public int memberCheck(MemberDTO member) {
		result = 0;

		try {
			con = getConnection();
			String sql = "select * from TOTORO.MEMBER where ID=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			rs = pstmt.executeQuery();
			if (rs.next()) {    // ID 일치
				if (member.getPasswd().equals(rs.getString("passwd"))) //비번 일치
					result = 1;
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
		return result;
	}

	//한 사람의 상세정보 구하기
	public MemberDTO getMember(String id) {
		MemberDTO member = new MemberDTO();

		try {
			con = getConnection();
			String sql = "select * from TOTORO.MEMBER where ID=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				member.setId(rs.getString("id"));
				member.setPasswd(rs.getString("passwd"));
				member.setName(rs.getString("name"));
				member.setJumin1(rs.getString("jumin1"));
				member.setJumin2(rs.getString("jumin2"));
				member.setMailid(rs.getString("mailid"));
				member.setDomain(rs.getString("domain"));
				member.setTel1(rs.getString("tel1"));
				member.setTel2(rs.getString("tel2"));
				member.setTel3(rs.getString("tel3"));
				member.setPhone1(rs.getString("phone1"));
				member.setPhone2(rs.getString("phone2"));
				member.setPhone3(rs.getString("phone3"));
				member.setPost(rs.getString("post"));
				member.setAddress(rs.getString("address"));
				member.setGender(rs.getString("gender"));
				member.setHobby(rs.getString("hobby"));
				member.setIntro(rs.getString("intro"));
				member.setRegister(rs.getTimestamp("register"));
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

	//회원 정보 수정
	public int update(MemberDTO member) {
		result = 0;
		try {
			con = getConnection();
			String sql = "update TOTORO.MEMBER set PASSWD=?, NAME=?, JUMIN1=?, JUMIN2=?, MAILID=?, DOMAIN=?, TEL1=?, TEL2=?, TEL3=?, PHONE1=?, PHONE2=?, PHONE3=?, POST=?, ADDRESS=?, GENDER=?, HOBBY=?, INTRO=?, REGISTER=sysdate  where ID=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getPasswd());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getJumin1());
			pstmt.setString(4, member.getJumin2());
			pstmt.setString(5, member.getMailid());
			pstmt.setString(6, member.getDomain());
			pstmt.setString(7, member.getTel1());
			pstmt.setString(8, member.getTel2());
			pstmt.setString(9, member.getTel3());
			pstmt.setString(10, member.getPhone1());
			pstmt.setString(11, member.getPhone2());
			pstmt.setString(12, member.getPhone3());
			pstmt.setString(13, member.getPost());
			pstmt.setString(14, member.getAddress());
			pstmt.setString(15, member.getGender());
			pstmt.setString(16, member.getHobby());
			pstmt.setString(17, member.getIntro());
			pstmt.setString(18, member.getId());
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

	public int delete(String id) {
		result = 0;
		try {
			con = getConnection();
			String sql = "delete from TOTORO.MEMBER where ID=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
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
}
