package kr.or.ddit.kream.vo;

public class ProdDetailVo {
	
	private String prod_id;
	private String prod_name;
	private long prod_resell;
	private long org_price;
	private String photo_path;
	private String brand_name;
	private String prod_launch;
	private String size_name;
	
	public String getProd_launch() {
		return prod_launch;
	}
	public void setProd_launch(String prod_launch) {
		this.prod_launch = prod_launch;
	}
	
	public String getSize_name() {
		return size_name;
	}
	public void setSize_name(String size_name) {
		this.size_name = size_name;
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
	public long getProd_resell() {
		return prod_resell;
	}
	public void setProd_resell(long prod_resell) {
		this.prod_resell = prod_resell;
	}
	public long getOrg_price() {
		return org_price;
	}
	public void setOrg_price(long org_price) {
		this.org_price = org_price;
	}
	public String getPhoto_path() {
		return photo_path;
	}
	public void setPhoto_path(String photo_path) {
		this.photo_path = photo_path;
	}
	public String getBrand_name() {
		return brand_name;
	}
	public void setBrand_name(String brand_name) {
		this.brand_name = brand_name;
	}
	
	
                              
}
