package multi.project.library;

public class MemberVO {

	private int l_id;
	private String m_id;
	private String m_pw;
	private String m_phone;
	private String m_name;
	private String m_pic;
	
	public MemberVO() {
		super();
	}
	public MemberVO(int l_id, String m_id, String m_pw, String m_phone, String m_name, String m_pic) {
		super();
		this.l_id = l_id;
		this.m_id = m_id;
		this.m_pw = m_pw;
		this.m_phone = m_phone;
		this.m_name = m_name;
		this.m_pic = m_pic;
	}
	

	public MemberVO(int l_id, String m_id, String m_pw, String m_phone, String m_name) {
		super();
		this.l_id = l_id;
		this.m_id = m_id;
		this.m_pw = m_pw;
		this.m_phone = m_phone;
		this.m_name = m_name;
	}
	public int getL_id() {
		return l_id;
	}
	public void setL_id(int l_id) {
		this.l_id = l_id;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public String getM_pw() {
		return m_pw;
	}
	public void setM_pw(String m_pw) {
		this.m_pw = m_pw;
	}
	public String getM_phone() {
		return m_phone;
	}
	public void setM_phone(String m_phone) {
		this.m_phone = m_phone;
	}
	public String getM_name() {
		return m_name;
	}
	public void setM_name(String m_name) {
		this.m_name = m_name;
	}
	public String getM_pic() {
		return m_pic;
	}
	public void setM_pic(String m_pic) {
		this.m_pic = m_pic;
	}
	
	
}