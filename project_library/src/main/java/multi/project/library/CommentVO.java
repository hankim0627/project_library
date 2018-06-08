package multi.project.library;

public class CommentVO {
	private String c_st_num;
	private String c_m_id;
	private String c_content;
	
	public String getC_st_num() {
		return c_st_num;
	}
	public void setC_st_num(String c_st_num) {
		this.c_st_num = c_st_num;
	}
	public String getC_m_id() {
		return c_m_id;
	}
	public void setC_m_id(String c_m_id) {
		this.c_m_id = c_m_id;
	}
	public String getC_content() {
		return c_content;
	}
	public void setC_content(String c_content) {
		this.c_content = c_content;
	}
	
	public String toString() {
		return "CommentVO [c_st_num=" + c_st_num + ", c_m_id=" + c_m_id + ", c_content=" + c_content + "]";
	}
}
