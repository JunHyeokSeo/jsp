package reboard;

import board.BoardDataBean;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ReBoardDBBean {
	private static final ReBoardDBBean instance = new ReBoardDBBean();
	Connection con = null;
	PreparedStatement pstmt = null;

	public static ReBoardDBBean getInstance() {
		return instance;
	}

	private Connection getConnection() throws Exception {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/orcl");
		return ds.getConnection();
	}

	public int insert(ReBoardDataBean board) {
		int result = 0;

		try {
			con = getConnection();
			String sql = "insert into REBOARD values (REBOARD_SEQ.nextval, ?, ?, ?, ?, sysdate, ?, REBOARD_SEQ.nextval, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board.getWriter());
			pstmt.setString(2, board.getEmail());
			pstmt.setString(3, board.getSubject());
			pstmt.setString(4, board.getPasswd());
			//게시글(=원문) 생성
			//원문은 re_step, re_level 값으로 '0'을 가진다
			pstmt.setInt(5, 0); //  readcount
			pstmt.setInt(6, 0); //  re_step
			pstmt.setInt(7, 0); //  re_level
			pstmt.setString(8, board.getContent());
			pstmt.setString(9, board.getIp());
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

	public int getCount() {
		int count = 0;
		ResultSet rs = null;

		try {
			con = getConnection();
			String sql = "select count(*) from REBOARD";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt("count(*)");
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
		return count;
	}

	public List<ReBoardDataBean> getList(int startRow, int endRow) {
		ResultSet rs = null;
		List<ReBoardDataBean> list = new ArrayList<>();

		try {
			con = getConnection();
			//정렬 기준 (ref, re_step)
			//게시글별로 정렬 후, 게시글 내부 댓글들을 정렬
			//ref desc : 최신 게시글 순서대로 정렬
			//re_step asc : 해당 게시글의 원문 및 댓글을 출력 순서대로 정렬 (step의 값이 낮을수록 우선순위 높음 == asc)
			String sql = "select * from (select ROWNUM rnum, reboard.* from (select * from REBOARD order by REF desc, RE_STEP asc) reboard) where rnum between ? and ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				list.add(getObject(rs.getInt("num")));
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

	public ReBoardDataBean getObject(int num) {
		ReBoardDataBean board = new ReBoardDataBean();
		ResultSet rs = null;

		try {
			con = getConnection();

			//select
			String sql = "select * from REBOARD where NUM=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				board.setNum(rs.getInt("num"));
				board.setWriter(rs.getString("writer"));
				board.setEmail(rs.getString("email"));
				board.setSubject(rs.getString("subject"));
				board.setPasswd(rs.getString("passwd"));
				board.setReg_date(rs.getTimestamp("reg_date"));
				board.setReadcount(rs.getInt("readcount"));
				board.setRef(rs.getInt("ref"));
				board.setRe_level(rs.getInt("re_level"));
				board.setRe_step(rs.getInt("re_step"));
				board.setContent(rs.getString("content"));
				board.setIp(rs.getString("ip"));
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

		return board;
	}

	public ReBoardDataBean updateContent(int num) {
		try {
			con = getConnection();

			String sql = "update REBOARD set READCOUNT=READCOUNT+1 where NUM=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
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

		return getObject(num);
	}

	public int reply(ReBoardDataBean board) {
		int result = 0;

		//부모글에 대한 정보
		int ref = board.getRef();
		int re_step = board.getRe_step();
		int re_level = board.getRe_level();

		try {
			con = getConnection();

			//현재 댓글을 입력하는 게시글을 기준으로 하위 글들의 step을 1씩 증가 ( 우선순위를 하나씩 미루는 것 )
			//최근에 작성한 댓글이 출력 우선권을 갖기 때문
			// 1. 원문에 댓글 작성
			// step == 0이기 때문에, 댓글의 step 모두 1씩 증가
			// 2. 댓글에 대댓글 작성
			// 본인보다 step 값이 높은 글의 step을 1씩 증가시키고 step+1을 step으로 갖는 대댓글 작성
			String sql = "update REBOARD set RE_STEP=RE_STEP+1 where REF=? and RE_STEP > ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ref);       //부모의 ref
			pstmt.setInt(2, re_step);   //부모의 re_step
			pstmt.executeUpdate();

			sql = "insert into REBOARD values (REBOARD_SEQ.nextval, ?, ?, ?, ?, sysdate, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board.getWriter());
			pstmt.setString(2, board.getEmail());
			pstmt.setString(3, board.getSubject());
			pstmt.setString(4, board.getPasswd());
			pstmt.setInt(5, 0);                 //readcount
			pstmt.setInt(6, ref);                  //ref
			pstmt.setInt(7, re_step + 1);         //re_step
			pstmt.setInt(8, re_level + 1);        //re_level
			pstmt.setString(9, board.getContent());
			pstmt.setString(10, board.getIp());

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

	public int update(ReBoardDataBean board) {
		int result = 0;

		try {
			con = getConnection();

			//update
			String sql = "update REBOARD set WRITER=?, EMAIL=?, SUBJECT=?, CONTENT=? where NUM=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board.getWriter());
			pstmt.setString(2, board.getEmail());
			pstmt.setString(3, board.getSubject());
			pstmt.setString(4, board.getContent());
			pstmt.setInt(5, board.getNum());
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

	//글삭제
	public int delete(ReBoardDataBean board) {
		int result = 0;

		try {
			con = getConnection();
			String sql = "";

			//원문
			if (board.getRe_level() == 0) {
				sql = "delete from REBOARD where REF=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, board.getRef());
			} else {
				//delete
				sql = "delete from REBOARD where NUM=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, board.getNum());
			}
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
