package board;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BoardDBBean {
	private static final BoardDBBean instance = new BoardDBBean();
	Connection conn = null;
	PreparedStatement pstmt = null;
	//	ResultSet rs = null;

	public static BoardDBBean getInstance() {
		return instance;
	}

	private Connection getConnection() throws Exception {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/orcl");
		return ds.getConnection();
	}

	public int insert(BoardDataBean board) {
		int result = 0;

		try {
			conn = getConnection();
			String sql = "insert into TOTORO.BOARD values (BOARD_SEQ.nextval, ?, ?, ?, ?, sysdate, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getWriter());
			pstmt.setString(2, board.getEmail());
			pstmt.setString(3, board.getSubject());
			pstmt.setString(4, board.getPasswd());
			pstmt.setInt(5, board.getReadcount());
			pstmt.setString(6, board.getContent());
			pstmt.setString(7, board.getIp());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}

	public int getCount(String sel, String find) {
		int count = 0;
		ResultSet rs = null;

		try {
			conn = getConnection();
			String sql = "";
//			System.out.println("sel : " + sel);
//			System.out.println("find : " + find);
//			System.out.println("sel.equal(null) : " + sel.equals("null"));
//			System.out.println("find.equal(null) : " + find.equals("null"));
			if ((sel != null && find != null) && !(sel.equals("null") || find.equals("null"))) {
				sql = "select count(*) from TOTORO.BOARD where " + sel + " like '%" + find + "%'";
			} else {
				sql = "select count(*) from TOTORO.BOARD";
			}
			pstmt = conn.prepareStatement(sql);
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
				if (conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return count;
	}

	public List<BoardDataBean> getList(int startRow, int endRow, String sel, String find) {
		List<BoardDataBean> list = new ArrayList<BoardDataBean>();
		ResultSet rs = null;

		try {
			conn = getConnection();
			String sql = "";

			if ((sel != null && find != null) && !(sel.equals("null") || find.equals("null"))) {
				sql = "select * from (select ROWNUM rnum, board.* from (select * from TOTORO.BOARD where " + sel + " like '%" + find + "%' order by NUM desc) board ) where rnum between ? and ?";
			} else {
				sql = "select * from (select ROWNUM rnum, board.* from (select * from TOTORO.BOARD order by NUM desc) board ) where rnum between ? and ?";
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				BoardDataBean board = new BoardDataBean();

				board.setNum(rs.getInt("num"));
				board.setWriter(rs.getString("writer"));
				board.setEmail(rs.getString("email"));
				board.setSubject(rs.getString("subject"));
				board.setPasswd(rs.getString("passwd"));
				board.setReg_date(rs.getTimestamp("reg_date"));
				board.setReadcount(rs.getInt("readcount"));
				board.setContent(rs.getString("content"));
				board.setIp(rs.getString("ip"));

				list.add(board);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	//상세 페이지 : 조회수 1 증가 + 상세정보 구하기
	public BoardDataBean updateContent(int num) {
		try {
			conn = getConnection();

			//update
			String sql = "update TOTORO.BOARD set READCOUNT=READCOUNT+1 where NUM=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return getContent(num);
	}

	//수정폼 : 상세 정보 구하기
	public BoardDataBean getContent(int num) {
		BoardDataBean board = new BoardDataBean();
		ResultSet rs = null;

		try {
			conn = getConnection();

			//select
			String sql = "select * from TOTORO.BOARD where NUM=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				board.setNum(rs.getInt("num"));
				board.setWriter(rs.getString("writer"));
				board.setSubject(rs.getString("subject"));
				board.setPasswd(rs.getString("passwd"));
				board.setReadcount(rs.getInt("readcount"));
				board.setContent(rs.getString("content"));
				board.setEmail(rs.getString("email"));
				board.setReg_date(rs.getTimestamp("reg_date"));
				board.setIp(rs.getString("ip"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return board;
	}

	//글수정
	public int update(BoardDataBean board) {
		int result = 0;

		try {
			conn = getConnection();

			//update
			String sql = "update TOTORO.BOARD set WRITER=?, EMAIL=?, SUBJECT=?, REG_DATE=sysdate, CONTENT=? where NUM=?";
			pstmt = conn.prepareStatement(sql);
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
				if (conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}

	//글삭제
	public int delete(int num) {
		int result = 0;

		try {
			conn = getConnection();

			//update
			String sql = "delete from TOTORO.BOARD where NUM=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
}
