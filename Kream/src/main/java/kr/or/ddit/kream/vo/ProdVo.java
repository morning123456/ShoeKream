package kr.or.ddit.kream.vo;

public class ProdVo {

	
	private String prod_id; //상품코드
	private String prod_name; //상품명
	private String lprod_id; //상품분류코드
	private String brand_id; //브랜드코드
	private int prod_resell; //최근거래가
	private String prod_launch; //상품출시일
	private String size_id; //사이즈코드
	private int org_price; //발매가
	
	
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
	public String getLprod_id() {
		return lprod_id;
	}
	public void setLprod_id(String lprod_id) {
		this.lprod_id = lprod_id;
	}
	public String getBrand_id() {
		return brand_id;
	}
	public void setBrand_id(String brand_id) {
		this.brand_id = brand_id;
	}
	public int getProd_resell() {
		return prod_resell;
	}
	public void setProd_resell(int prod_resell) {
		this.prod_resell = prod_resell;
	}
	public String getProd_launch() {
		return prod_launch;
	}
	public void setProd_launch(String prod_launch) {
		this.prod_launch = prod_launch;
	}
	public String getSize_id() {
		return size_id;
	}
	public void setSize_id(String size_id) {
		this.size_id = size_id;
	}
	public int getOrg_price() {
		return org_price;
	}
	public void setOrg_price(int org_price) {
		this.org_price = org_price;
	}
	
	
	
}
