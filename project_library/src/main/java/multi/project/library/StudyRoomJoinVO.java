package multi.project.library;

public class StudyRoomJoinVO {
	int l_id;
	int sr_num;
	String m_id;
	String m_name;
	int sr_join_flag;
	String sr_join_content;
	
	public int getL_id() {
		return l_id;
	}
	public void setL_id(int l_id) {
		this.l_id = l_id;
	}
	public int getSr_num() {
		return sr_num;
	}
	public void setSr_num(int sr_num) {
		this.sr_num = sr_num;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	
	public String getM_name() {
		return m_name;
	}
	public void setM_name(String m_name) {
		this.m_name = m_name;
	}
	public int getSr_join_flag() {
		return sr_join_flag;
	}
	public void setSr_join_flag(int sr_join_flag) {
		this.sr_join_flag = sr_join_flag;
	}
	public String getSr_join_content() {
		return sr_join_content;
	}
	public void setSr_join_content(String sr_join_content) {
		this.sr_join_content = sr_join_content;
	}
	
	
}
