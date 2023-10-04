package javaBeanExam.register;

public class LogonDBBean {
	//싱글톤
	private static LogonDBBean instance = new LogonDBBean();

	//정적 메소드
	public static LogonDBBean getInstance() {
		return instance;
	}

	//회원가입 : 주소값 전달에 의한 메소드 호출 방식
	public int insertMember(LogonDataBean regBean) {
		int result = 0;

		return result;
	}
}
