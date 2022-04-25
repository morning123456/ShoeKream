package kr.or.ddit.kream.card.dao;

import java.sql.SQLException;
import java.util.Map;

import kr.or.ddit.kream.vo.AddressVo;
import kr.or.ddit.kream.vo.BidVo;
import kr.or.ddit.kream.vo.ProdDetailVo;

public interface IOrderDao {
		public BidVo selectOrderBid(BidVo bidVo) throws SQLException; 
		public int pointchk(String bidId) throws SQLException; 
		public int insertBidTemp(BidVo bidVo) throws SQLException; 
		public int updateBidState(Map<String,Object> map) throws SQLException; 
		public int insertOrder(BidVo bidVo) throws SQLException; 
		public BidVo selectSellBid(BidVo bidVo) throws SQLException;
		public int updateAmount(BidVo bidvo) throws SQLException; 
		public ProdDetailVo selectProd(String sizeId) throws SQLException; 
		public AddressVo selectAdressOne(String memId) throws SQLException; 
		public String getPoint(String memId) throws SQLException; 
		public String insertBid(BidVo bidvo) throws SQLException;
		public String selectBid(BidVo bidvo) throws SQLException;
		public int updateBid(BidVo bidvo) throws SQLException;
		public int updatePoint(BidVo bidvo) throws SQLException;
		public int updateResell(BidVo bidvo) throws SQLException;
}
