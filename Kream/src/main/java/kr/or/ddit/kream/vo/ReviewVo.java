package kr.or.ddit.kream.vo;

public class ReviewVo {

	
	private String review_id;
	private String review_photopath;
	private String review_title;
	private String review_content;
	private String review_date;
	
	private String mem_email;
	private String mem_alias;
	private String mem_name;
	private String mem_photo;
	
	private String prod_id;
	private String prod_name;
	private String prod_resell;
	private String photo_path;
	
	public String getProd_name() {
		return prod_name;
	}
	public void setProd_name(String prod_name) {
		this.prod_name = prod_name;
	}
	public String getProd_resell() {
		return prod_resell;
	}
	public void setProd_resell(String prod_resell) {
		this.prod_resell = prod_resell;
	}
	public String getPhoto_path() {
		return photo_path;
	}
	public void setPhoto_path(String photo_path) {
		this.photo_path = photo_path;
	}
	
	
	public String getMem_alias() {
		return mem_alias;
	}
	public void setMem_alias(String mem_alias) {
		this.mem_alias = mem_alias;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getMem_photo() {
		return mem_photo;
	}
	public void setMem_photo(String mem_photo) {
		this.mem_photo = mem_photo;
	}
	public String getReview_id() {
		return review_id;
	}
	public void setReview_id(String review_id) {
		this.review_id = review_id;
	}
	public String getMem_email() {
		return mem_email;
	}
	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}
	public String getReview_photopath() {
		return review_photopath;
	}
	public void setReview_photopath(String review_photopath) {
		this.review_photopath = review_photopath;
	}
	public String getReview_title() {
		return review_title;
	}
	public void setReview_title(String review_title) {
		this.review_title = review_title;
	}
	public String getReview_content() {
		return review_content;
	}
	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}
	public String getReview_date() {
		return review_date;
	}
	public void setReview_date(String review_date) {
		this.review_date = review_date;
	}
	public String getProd_id() {
		return prod_id;
	}
	public void setProd_id(String prod_id) {
		this.prod_id = prod_id;
	}
}
