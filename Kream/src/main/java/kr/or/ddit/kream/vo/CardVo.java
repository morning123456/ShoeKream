package kr.or.ddit.kream.vo;

public class CardVo {
	private String mem_email;
	private String card_number;
	private String expiry;
	private String birth;
	private String pwd_2digit;
	private String customer_uid;
	
	public CardVo() {
		// TODO Auto-generated constructor stub
	}
	public CardVo(String mem_email, String card_number, String expiry, String birth, String pwd_2digit,
			String customer_uid) {
		super();
		this.mem_email = mem_email;
		this.card_number = card_number;
		this.expiry = expiry;
		this.birth = birth;
		this.pwd_2digit = pwd_2digit;
		this.customer_uid = customer_uid;
	}
	
	public String getMem_email() {
		return mem_email;
	}
	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}
	public String getCard_number() {
		return card_number;
	}
	public void setCard_number(String card_number) {
		this.card_number = card_number;
	}
	public String getExpiry() {
		return expiry;
	}
	public void setExpiry(String expiry) {
		this.expiry = expiry;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getPwd_2digit() {
		return pwd_2digit;
	}
	public void setPwd_2digit(String pwd_2digit) {
		this.pwd_2digit = pwd_2digit;
	}
	public String getCustomer_uid() {
		return customer_uid;
	}
	public void setCustomer_uid(String customer_uid) {
		this.customer_uid = customer_uid;
	}
	
	@Override
	public String toString() {
		return "CardVo [mem_email=" + mem_email + ", card_number=" + card_number + ", expiry=" + expiry + ", birth="
				+ birth + ", pwd_2digit=" + pwd_2digit + ", customer_uid=" + customer_uid + "]";
	}
}
