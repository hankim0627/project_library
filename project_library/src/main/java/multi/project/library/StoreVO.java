package multi.project.library;

public class StoreVO {
	private String l_id;
	private String st_num;
	private String st_title;
	private String st_context;
	private String st_m_id;
	private String st_pw;
	private String st_date;
	
	public String getL_id() {
		return l_id;
	}
	public void setL_id(String l_id) {
		this.l_id = l_id;
	}
	public String getSt_num() {
		return st_num;
	}
	public void setSt_num(String st_num) {
		this.st_num = st_num;
	}
	public String getSt_title() {
		return st_title;
	}
	public void setSt_title(String st_title) {
		this.st_title = st_title;
	}
	public String getSt_context() {
		return st_context;
	}
	public void setSt_context(String st_context) {
		this.st_context = st_context;
	}
	public String getSt_m_id() {
		return st_m_id;
	}
	public void setSt_m_id(String st_m_id) {
		this.st_m_id = st_m_id;
	}
	public String getSt_pw() {
		return st_pw;
	}
	public void setSt_pw(String st_pw) {
		this.st_pw = st_pw;
	}
	public String getSt_date() {
		return st_date;
	}
	public void setSt_date(String st_date) {
		this.st_date = st_date;
	}
	
	@Override
	public String toString() {
		return "StoreVO [l_id=" + l_id + ", st_num=" + st_num + ", st_title=" + st_title + ", st_context=" + st_context
				+ ", st_m_id=" + st_m_id + ", st_pw=" + st_pw + ", st_date=" + st_date + "]";
	}
}

