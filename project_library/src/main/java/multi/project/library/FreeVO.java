package multi.project.library;

public class FreeVO {

	private String l_Id; 
	private String f_Title;
	private String f_Content;
	private String f_m_Id;
	private String f_Pw;
	private String f_Date;
	private int f_Num;
	
	
	
	public FreeVO() {
		super();
	}



	public FreeVO(String l_Id, String f_Title, String f_Content, String f_m_Id, String f_Pw, String f_Date, int f_Num) {
		super();
		this.l_Id = l_Id;
		this.f_Title = f_Title;
		this.f_Content = f_Content;
		this.f_m_Id = f_m_Id;
		this.f_Pw = f_Pw;
		this.f_Date = f_Date;
		this.f_Num = f_Num;
	}



	public String getL_Id() {
		return l_Id;
	}



	public void setL_Id(String l_Id) {
		this.l_Id = l_Id;
	}



	public String getF_Title() {
		return f_Title;
	}



	public void setF_Title(String f_Title) {
		this.f_Title = f_Title;
	}



	public String getF_Content() {
		return f_Content;
	}



	public void setF_Content(String f_Content) {
		this.f_Content = f_Content;
	}



	public String getF_m_Id() {
		return f_m_Id;
	}



	public void setF_m_Id(String f_m_Id) {
		this.f_m_Id = f_m_Id;
	}



	public String getF_Pw() {
		return f_Pw;
	}



	public void setF_Pw(String f_Pw) {
		this.f_Pw = f_Pw;
	}



	public String getF_Date() {
		return f_Date;
	}



	public void setF_Date(String f_Date) {
		this.f_Date = f_Date;
	}



	public int getF_Num() {
		return f_Num;
	}



	public void setF_Num(int f_Num) {
		this.f_Num = f_Num;
	}
	
	
	
}
