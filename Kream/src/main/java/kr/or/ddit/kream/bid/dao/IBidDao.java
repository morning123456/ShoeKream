package kr.or.ddit.kream.bid.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;


import kr.or.ddit.kream.vo.BidVo;

public interface IBidDao {
	
	public List<BidVo> sellInfo(String prodid) throws SQLException;	 //판매 사이즈, 가격
	
	public List<BidVo> buyInfo(String prodid) throws SQLException;   //구매 사이즈, 가격
	
	public int insertBid(BidVo bidvo) throws SQLException;
	
	public String selectBid(BidVo bidvo) throws SQLException;

	public int updateBid(BidVo bidvo) throws SQLException;
	
	public String sellNowCall(Map<String, String> map) throws SQLException;     // '판매하기'- 즉시구매가
	
	public String buyNowCall(Map<String, String> map) throws SQLException;     // '구매하기'- 즉시판매가


}
