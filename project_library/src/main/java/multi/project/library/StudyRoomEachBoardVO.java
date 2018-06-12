package multi.project.library;

public class StudyRoomEachBoardVO {
	int sr_num;
	String sr_title;
	int l_id;
	String sr_content;
	String m_id;
	String m_name;
	String sr_pw;
	String sr_date;
	String sr_cate;
	int sr_view_num;
	String sr_file_name1;
	String sr_file_name2;
	String sr_file_name3;
	int sr_eb_num;
	
	public StudyRoomEachBoardVO(){}
	
	public StudyRoomEachBoardVO(int sr_num, String sr_title, int l_id, String sr_content, String m_id, String sr_pw,
			String sr_cate) {
		super();
		this.sr_num = sr_num;
		this.sr_title = sr_title;
		this.l_id = l_id;
		this.sr_content = sr_content;
		this.m_id = m_id;
		this.sr_pw = sr_pw;
		this.sr_cate = sr_cate;

	}
	
	public String getSr_file_name2() {
		return sr_file_name2;
	}

	public void setSr_file_name2(String sr_file_name2) {
		this.sr_file_name2 = sr_file_name2;
	}

	public String getSr_file_name3() {
		return sr_file_name3;
	}

	public void setSr_file_name3(String sr_file_name3) {
		this.sr_file_name3 = sr_file_name3;
	}

	public int getSr_eb_num() {
		return sr_eb_num;
	}
	public void setSr_eb_num(int sr_eb_num) {
		this.sr_eb_num = sr_eb_num;
	}
	public int getSr_num() {
		return sr_num;
	}
	public void setSr_num(int sr_num) {
		this.sr_num = sr_num;
	}
	public String getSr_title() {
		return sr_title;
	}
	public void setSr_title(String sr_title) {
		this.sr_title = sr_title;
	}
	public int getL_id() {
		return l_id;
	}
	public void setL_id(int l_id) {
		this.l_id = l_id;
	}
	public String getSr_content() {
		return sr_content;
	}
	public void setSr_content(String sr_content) {
		this.sr_content = sr_content;
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
	public String getSr_pw() {
		return sr_pw;
	}
	public void setSr_pw(String sr_pw) {
		this.sr_pw = sr_pw;
	}
	public String getSr_date() {
		return sr_date;
	}
	public void setSr_date(String sr_date) {
		this.sr_date = sr_date;
	}
	public String getSr_cate() {
		return sr_cate;
	}
	public void setSr_cate(String sr_cate) {
		this.sr_cate = sr_cate;
	}
	public int getSr_view_num() {
		return sr_view_num;
	}
	public void setSr_view_num(int sr_view_num) {
		this.sr_view_num = sr_view_num;
	}
	public String getSr_file_name1() {
		return sr_file_name1;
	}
	public void setSr_file_name1(String sr_file_name1) {
		this.sr_file_name1 = sr_file_name1;
	}

	@Override
	public String toString() {
		return "StudyRoomEachBoardVO [sr_num=" + sr_num + ", sr_title=" + sr_title + ", l_id=" + l_id + ", sr_content="
				+ sr_content + ", m_id=" + m_id + ", m_name=" + m_name + ", sr_pw=" + sr_pw + ", sr_date=" + sr_date
				+ ", sr_cate=" + sr_cate + ", sr_view_num=" + sr_view_num + ", sr_file_name1=" + sr_file_name1
				+ ", sr_file_name2=" + sr_file_name2 + ", sr_file_name3=" + sr_file_name3 + ", sr_eb_num=" + sr_eb_num
				+ "]";
	}
	
	
	
}
