package kr.or.ddit.kream.vo;

public class BoardReplyVo {
	private String board_id;
	private String rep_content;
	private String rep_date;
	private String board_reply_id;
	
	public String getBoard_reply_id() {
		return board_reply_id;
	}
	public void setBoard_reply_id(String board_reply_id) {
		this.board_reply_id = board_reply_id;
	}
	@Override
	public String toString() {
		return "BoardReplyVo [board_id=" + board_id + ", rep_content=" + rep_content + ", rep_date=" + rep_date + "]";
	}
	public String getBoard_id() {
		return board_id;
	}
	public void setBoard_id(String board_id) {
		this.board_id = board_id;
	}
	public String getRep_content() {
		return rep_content;
	}
	public void setRep_content(String rep_content) {
		this.rep_content = rep_content;
	}
	public String getRep_date() {
		return rep_date;
	}
	public void setRep_date(String rep_date) {
		this.rep_date = rep_date;
	}

}
