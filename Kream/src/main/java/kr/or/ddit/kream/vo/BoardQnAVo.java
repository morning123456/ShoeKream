package kr.or.ddit.kream.vo;

public class BoardQnAVo {
	private String board_id; //게시판 코드
	private String mem_email; //회원아이디
	private String board_title; //게시글 제목
	private String board_content; //게시글 내용
	private String board_date; //게시글 작성 날짜
	
	private String creply; //댓글 여부
	
	public String getCreply() {
		return creply;
	}
	public void setCreply(String creply) {
		this.creply = creply;
	}
	public String getBoard_id() {
		return board_id;
	}
	public void setBoard_id(String board_id) {
		this.board_id = board_id;
	}
	public String getMem_email() {
		return mem_email;
	}
	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getBoard_content() {
		return board_content;
	}
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}
	public String getBoard_date() {
		return board_date;
	}
	public void setBoard_date(String board_date) {
		this.board_date = board_date;
	}
	@Override
	public String toString() {
		return "BoardQnAVo [board_id=" + board_id + ", mem_email=" + mem_email + ", board_title=" + board_title
				+ ", board_content=" + board_content + ", board_date=" + board_date + "]";
	}
	
}
