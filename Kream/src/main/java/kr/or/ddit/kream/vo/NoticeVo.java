package kr.or.ddit.kream.vo;

public class NoticeVo {
	private String notice;
	private String notice_title;
	private String notice_content;
	private String notice_date;
	private String notice_cat;
	private String notice_sta;
	
	public String getNotice_sta() {
		return notice_sta;
	}
	public void setNotice_sta(String notice_sta) {
		this.notice_sta = notice_sta;
	}
	public String getNotice() {
		return notice;
	}
	public void setNotice(String notice) {
		this.notice = notice;
	}
	
	public String getNotice_title() {
		return notice_title;
	}
	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}
	public String getNotice_content() {
		return notice_content;
	}
	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}
	public String getNotice_date() {
		return notice_date;
	}
	public void setNotice_date(String notice_date) {
		this.notice_date = notice_date;
	}
	public String getNotice_cat() {
		return notice_cat;
	}
	public void setNotice_cat(String notice_cat) {
		this.notice_cat = notice_cat;
	}
	@Override
	public String toString() {
		return "NoticeVo [notice=" + notice + ", notice_title=" + notice_title
				+ ", notice_content=" + notice_content + ", notice_date=" + notice_date + ", notice_cat=" + notice_cat
				+ ", notice_sta=" + notice_sta + "]";
	}
	
	
}
