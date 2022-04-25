package kr.or.ddit.kream.card.service;

import java.util.Map;

import kr.or.ddit.kream.vo.AddressVo;
import kr.or.ddit.kream.vo.BidVo;
import kr.or.ddit.kream.vo.ProdDetailVo;

public interface IOrderService {
	public BidVo selectOrderBid(BidVo bidVo); 
	public int pointchk(String bidId); 
	public int insertBidTemp(BidVo bidVo); 
	public int updateBidState(Map<String,Object> map); 
	public int insertOrder(BidVo bidVo); 
	public BidVo selectSellBid(BidVo bidVo);
	public int updateAmount(BidVo bidvo);
	public ProdDetailVo selectProd(String sizeId);
	public AddressVo selectAdressOne(String memId);
	public String getPoint(String memId);
	public String insertBid(BidVo bidvo);
	public String selectBid(BidVo bidvo);
	public int updateBid(BidVo bidvo);
	public int updatePoint(BidVo bidvo);
	public int updateResell(BidVo bidvo);
}
