package multi.project.library;

public class FreeReplyVO {
private int fr_Num;
private int fr_free_Num;
private String fr_m_Id;
private String fr_Content;
private String m_Pic;
private String fr_Pw;


public FreeReplyVO() {
	super();
}
public FreeReplyVO(int fr_Num, int fr_free_Num, String fr_m_Id, String fr_Content, String m_Pic, String fr_Pw) {
	super();
	this.fr_Num = fr_Num;
	this.fr_free_Num = fr_free_Num;
	this.fr_m_Id = fr_m_Id;
	this.fr_Content = fr_Content;
	this.m_Pic = m_Pic;
	this.fr_Pw = fr_Pw;
}
public int getFr_Num() {
	return fr_Num;
}
public void setFr_Num(int fr_Num) {
	this.fr_Num = fr_Num;
}
public int getFr_free_Num() {
	return fr_free_Num;
}
public void setFr_free_Num(int fr_free_Num) {
	this.fr_free_Num = fr_free_Num;
}
public String getFr_m_Id() {
	return fr_m_Id;
}
public void setFr_m_Id(String fr_m_Id) {
	this.fr_m_Id = fr_m_Id;
}
public String getFr_Content() {
	return fr_Content;
}
public void setFr_Content(String fr_Content) {
	this.fr_Content = fr_Content;
}
public String getM_Pic() {
	return m_Pic;
}
public void setM_Pic(String m_Pic) {
	this.m_Pic = m_Pic;
}
public String getFr_Pw() {
	return fr_Pw;
}
public void setFr_Pw(String fr_Pw) {
	this.fr_Pw = fr_Pw;
}





}
