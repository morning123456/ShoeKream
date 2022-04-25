package kr.or.ddit.kream.card.dao;

import java.sql.SQLException;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.kream.util.SqlMapClientFactory;
import kr.or.ddit.kream.vo.AddressVo;
import kr.or.ddit.kream.vo.BidVo;
import kr.or.ddit.kream.vo.ProdDetailVo;

public class OrderDaoImpl implements IOrderDao{
	private SqlMapClient smc;
	private static IOrderDao dao;
	
	public OrderDaoImpl() {
		smc = SqlMapClientFactory.getSqlMapClient();
	}
	
	public static IOrderDao getInstance() {
		if(dao == null) dao = new OrderDaoImpl();
		return dao;
	}
	
	
	@Override
	public BidVo selectOrderBid(BidVo bidVo) throws SQLException {
		
		return (BidVo) smc.queryForObject("order.selectOrderBid",bidVo);
	}

	@Override
	public int pointchk(String bidId) throws SQLException {
		// TODO Auto-generated method stub
		return (int) smc.queryForObject("order.pointchk",bidId);
	}

	@Override
	public int insertBidTemp(BidVo bidVo) throws SQLException {
		int cnt=0;
		Object obj = smc.insert("order.insertBidTemp",bidVo);
		if(obj==null) cnt = 1;
		return cnt;
	}

	
	@Override
	public int updateBidState(Map<String, Object> map) throws SQLException {
		// TODO Auto-generated method stub
		return smc.update("order.updateBidState",map);
	}

	@Override
	public int insertOrder(BidVo bidVo) throws SQLException {
		int cnt=0;
		Object obj = smc.insert("order.insertOrder",bidVo);
		if(obj==null) cnt = 1;
		return cnt;
	}

	@Override
	public BidVo selectSellBid(BidVo bidVo) throws SQLException {
		// TODO Auto-generated method stub
		return (BidVo) smc.queryForObject("order.selectSellBid",bidVo);
	}



	@Override
	public ProdDetailVo selectProd(String sizeId) throws SQLException {
		// TODO Auto-generated method stub
		return (ProdDetailVo) smc.queryForObject("order.selectProd",sizeId);
	}

	@Override
	public AddressVo selectAdressOne(String memId) throws SQLException {
		// TODO Auto-generated method stub
		return (AddressVo) smc.queryForObject("address.selectAdressOne",memId);
	}

	@Override
	public String getPoint(String memId) throws SQLException {
		// TODO Auto-generated method stub
		return (String) smc.queryForObject("order.getPoint",memId);
	}
	
	
	@Override
	public String insertBid(BidVo bidvo) throws SQLException {
		return (String) smc.insert("order.insertBid",bidvo);
	}

	@Override
	public String selectBid(BidVo bidvo) throws SQLException {
		// TODO Auto-generated method stub
		return (String) smc.queryForObject("order.selectBid",bidvo);
	}

	@Override
	public int updateBid(BidVo bidvo) throws SQLException {
		// TODO Auto-generated method stub
		return smc.update("order.updateBid",bidvo);
	}

	@Override
	public int updatePoint(BidVo bidvo) throws SQLException {
		// TODO Auto-generated method stub
		return smc.update("order.updatePoint",bidvo);
	}

	@Override
	public int updateAmount(BidVo bidvo) throws SQLException {
		// TODO Auto-generated method stub
		return smc.update("order.updateAmount",bidvo);
	}

	@Override
	public int updateResell(BidVo bidvo) throws SQLException {
		// TODO Auto-generated method stub
		return smc.update("order.updateResell",bidvo);
	}

}
