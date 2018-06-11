package multi.project.library.studyRoom;

public class StudyRoomCommentVO {
	int sr_num;
	int sr_comment_num = -1;
	int sr_recomment_num = -1;	// 그냥 댓글일 경우 sr_recomment_num -1, recomment일 경우에는 sequence로  계속 값 증가 !
	String sr_comment_id;
	String sr_comment_date;
	String sr_comment_content;
	
	int sr_recomment_flag = -1;
	
	public StudyRoomCommentVO(){}
	
	public StudyRoomCommentVO(int sr_num, int sr_comment_num, String sr_comment_id, String sr_comment_content) {
		super();
		this.sr_num = sr_num;
		this.sr_comment_num = sr_comment_num;
		this.sr_comment_id = sr_comment_id;
		this.sr_comment_content = sr_comment_content;
	}

	public StudyRoomCommentVO(int sr_num, String sr_comment_id, int sr_comment_recomment, String sr_comment_content) {
		super();
		this.sr_num = sr_num;
		this.sr_comment_id = sr_comment_id;
		this.sr_comment_content = sr_comment_content;
	}

	public StudyRoomCommentVO(int sr_num, int sr_comment_num, String sr_comment_id, String sr_comment_date,
			int sr_comment_recomment, String sr_comment_content) {
		super();
		this.sr_num = sr_num;
		this.sr_comment_num = sr_comment_num;
		this.sr_comment_id = sr_comment_id;
		this.sr_comment_date = sr_comment_date;
		this.sr_comment_content = sr_comment_content;
	}

	public int getSr_num() {
		return sr_num;
	}
	public void setSr_num(int sr_num) {
		this.sr_num = sr_num;
	}
	public int getSr_comment_num() {
		return sr_comment_num;
	}
	public void setSr_comment_num(int sr_comment_num) {
		this.sr_comment_num = sr_comment_num;
	}
	public String getSr_comment_id() {
		return sr_comment_id;
	}
	public void setSr_comment_id(String sr_comment_id) {
		this.sr_comment_id = sr_comment_id;
	}
	public String getSr_comment_date() {
		return sr_comment_date;
	}
	public void setSr_comment_date(String sr_comment_date) {
		this.sr_comment_date = sr_comment_date;
	}

	public String getSr_comment_content() {
		return sr_comment_content;
	}
	public void setSr_comment_content(String sr_comment_content) {
		this.sr_comment_content = sr_comment_content;
	}

	public int getSr_recomment_num() {
		return sr_recomment_num;
	}

	public void setSr_recomment_num(int sr_recomment_num) {
		this.sr_recomment_num = sr_recomment_num;
	}
	
	public int getSr_recomment_flag() {
		return sr_recomment_flag;
	}

	public void setSr_recomment_flag(int sr_recomment_flag) {
		this.sr_recomment_flag = sr_recomment_flag;
	}

	@Override
	public String toString() {
		return "StudyRoomCommentVO [sr_num=" + sr_num + ", sr_comment_num=" + sr_comment_num + ", sr_comment_id="
				+ sr_comment_id + ", sr_comment_date=" + sr_comment_date + ", sr_comment_content=" + sr_comment_content
				+ ", sr_recomment_num=" + sr_recomment_num + "]";
	}
	
	
}
