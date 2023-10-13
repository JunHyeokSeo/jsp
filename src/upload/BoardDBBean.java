package upload;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;

public class BoardDBBean {
	private static BoardDataBean instance = new BoardDataBean();

	public static BoardDataBean getInstance() {
		return instance;
	}

	private Connection getConnection() throws Exception{
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/orcl");
		return ds.getConnection();
	}

	public int insert(BoardDataBean board) {
		int result = 0;

		return result
	}
}
