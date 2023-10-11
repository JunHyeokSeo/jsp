package reboard;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;

public class ReBoardDBBean {
	private static final ReBoardDBBean instance = new ReBoardDBBean();

	public static ReBoardDBBean getInstance() {
		return instance;
	}

	private Connection getConnection() throws Exception{
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/orcl");
		return ds.getConnection();
	}

	public int insert(ReBoardDataBean boardDataBean) {
		int result = 0;

		return result;
	}
}
