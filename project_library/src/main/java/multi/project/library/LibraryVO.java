package multi.project.library;

public class LibraryVO {
	
	
	private int l_id;
	private String l_name;
	private String l_location;
	private String l_holiday;
	private String l_time;
	private String l_phone;
	private String l_website;
	private double l_latitude;
	private double l_longtitude;
	
	
	public LibraryVO() {
		super();
	}
	public LibraryVO(int l_id, String l_name, String l_location, String l_holiday, String l_time, String l_phone,
			String l_website, double l_latitude, double l_longtitude) {
		super();
		this.l_id = l_id;
		this.l_name = l_name;
		this.l_location = l_location;
		this.l_holiday = l_holiday;
		this.l_time = l_time;
		this.l_phone = l_phone;
		this.l_website = l_website;
		this.l_latitude = l_latitude;
		this.l_longtitude = l_longtitude;
	}
	
	public int getL_id() {
		return l_id;
	}
	public void setL_id(int l_id) {
		this.l_id = l_id;
	}
	public String getL_name() {
		return l_name;
	}
	public void setL_name(String l_name) {
		this.l_name = l_name;
	}
	public String getL_location() {
		return l_location;
	}
	public void setL_location(String l_location) {
		this.l_location = l_location;
	}
	public String getL_holiday() {
		return l_holiday;
	}
	public void setL_holiday(String l_holiday) {
		this.l_holiday = l_holiday;
	}
	public String getL_time() {
		return l_time;
	}
	public void setL_time(String l_time) {
		this.l_time = l_time;
	}
	public String getL_phone() {
		return l_phone;
	}
	public void setL_phone(String l_phone) {
		this.l_phone = l_phone;
	}
	public String getL_website() {
		return l_website;
	}
	public void setL_website(String l_website) {
		this.l_website = l_website;
	}
	public double getL_latitude() {
		return l_latitude;
	}
	public void setL_latitude(double l_latitude) {
		this.l_latitude = l_latitude;
	}
	public double getL_longtitude() {
		return l_longtitude;
	}
	public void setL_longtitude(double l_longtitude) {
		this.l_longtitude = l_longtitude;
	}
	
		
}