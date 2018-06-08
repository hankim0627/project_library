package multi.project.library;

public class MemberStoreVO {
	private String ms_m_id;
	private String ms_st_num;
	private int flag;
	private String send_id;
	
	public String getSend_id() {
		return send_id;
	}
	public void setSend_id(String send_id) {
		this.send_id = send_id;
	}
	public String getMs_m_id() {
		return ms_m_id;
	}
	public void setMs_m_id(String ms_m_id) {
		this.ms_m_id = ms_m_id;
	}
	public String getMs_st_num() {
		return ms_st_num;
	}
	public void setMs_st_num(String ms_st_num) {
		this.ms_st_num = ms_st_num;
	}
	public int getFlag() {
		return flag;
	}
	public void setFlag(int flag) {
		this.flag = flag;
	}

	public String toString() {
		return "MemberStoreVO [ms_m_id=" + ms_m_id + ", ms_st_num=" + ms_st_num + ", flag=" + flag + ", send_id="
				+ send_id + "]";
	}	
}
