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

	public int getCount() {
		int count = 0;
		ResultSet rs = null;

		try {
			conn = getConnection();
			String sql = "select count(*) from TOTORO.BOARD";
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

	public List<BoardDataBean> getList(int startRow, int endRow) {
		List<BoardDataBean> list = new ArrayList<BoardDataBean>();
		ResultSet rs = null;

		try {
			conn = getConnection();
//			String sql = "select * from (select * from TOTORO.BOARD ORDER BY NUM asc) where ROWNUM between ? and ?";
			String sql = "select * from (select ROWNUM rnum, board.* from (select * from TOTORO.BOARD order by NUM desc) board ) where rnum between ? and ?";
//			String sql = "select * from (select rownum rnum, board.* from (select * from board order by num desc) board) where rnum >= ? and rnum <= ?";
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
}
