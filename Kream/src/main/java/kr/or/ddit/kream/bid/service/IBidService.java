package kr.or.ddit.kream.bid.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.kream.vo.BidVo;

public interface IBidService {

	public List<BidVo> sellInfo(String prodid);	

	public List<BidVo> buyInfo(String prodid);
	
	public int insertBid(BidVo bidvo);
	
	public String selectBid(BidVo bidvo);
	
	public int updateBid(BidVo bidvo);
	
	public String sellNowCall(Map<String, String> map);     // '판매하기'- 즉시구매가
	
	public String buyNowCall(Map<String, String> map);     // '구매하기'- 즉시판매가

}
