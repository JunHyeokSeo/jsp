// 자바빈 클래스
// DTO (Data Transfer Object)

package javaBeanExam.javaBean;

//public 접근제어자를 사용해야만 한다
//해당 클래스를 호출하는 파일이 다른 패키지에 있다면 호출하지 못하기 때문
public class SimpleBean {

	//프로퍼티(property)
	//하나의 프로퍼티가 생성되면 그에 대한 Getter, Setter가 같이 생성되어야 한다.
	private String msg;
	private String name;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
}
