package kr.or.ddit.kream.vo;

public class MainPageProdVo {

	private String prod_id;
	private String prod_name;
	private String brand_name;
	private String photo_path;
	private int prod_resell;
	
	public int getProd_resell() {
		return prod_resell;
	}
	public void setProd_resell(int prod_resell) {
		this.prod_resell = prod_resell;
	}
	public String getProd_id() {
		return prod_id;
	}
	public void setProd_id(String prod_id) {
		this.prod_id = prod_id;
	}
	public String getProd_name() {
		return prod_name;
	}
	public void setProd_name(String prod_name) {
		this.prod_name = prod_name;
	}
	public String getBrand_name() {
		return brand_name;
	}
	public void setBrand_name(String brand_name) {
		this.brand_name = brand_name;
	}
	public String getPhoto_path() {
		return photo_path;
	}
	public void setPhoto_path(String photo_path) {
		this.photo_path = photo_path;
	}
	
	
	
}
