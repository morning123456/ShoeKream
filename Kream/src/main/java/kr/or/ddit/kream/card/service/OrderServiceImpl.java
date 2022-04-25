package kr.or.ddit.kream.card.service;

import java.sql.SQLException;
import java.util.Map;

import kr.or.ddit.kream.card.dao.IOrderDao;
import kr.or.ddit.kream.card.dao.OrderDaoImpl;
import kr.or.ddit.kream.vo.AddressVo;
import kr.or.ddit.kream.vo.BidVo;
import kr.or.ddit.kream.vo.ProdDetailVo;

public class OrderServiceImpl implements IOrderService {
	private static IOrderDao dao;
	private static IOrderService service;
	
	public OrderServiceImpl() {
		dao = OrderDaoImpl.getInstance();
	}
	
	public static IOrderService getInstance() {
		if(service == null) service = new OrderServiceImpl();
		return service;
	}
	

	@Override
	public BidVo selectOrderBid(BidVo bidVo) {
		BidVo vo = new BidVo();
		try {
			vo = dao.selectOrderBid(bidVo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return vo;
	}

	@Override
	public int pointchk(String bidId) {
		int point=0;
		try {
			point = dao.pointchk(bidId);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return point;
	}

	@Override
	public int insertBidTemp(BidVo bidVo) {
		int cnt = 0;
		try {
			cnt = dao.insertBidTemp(bidVo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return cnt;
	}

	@Override
	public int updateBidState(Map<String, Object> map) {
		int cnt = 0;
		try {
			cnt = dao.updateBidState(map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return cnt;
	}

	@Override
	public int insertOrder(BidVo bidVo) {
		int cnt = 0;
		try {
			cnt = dao.insertOrder(bidVo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return cnt;
	}

	@Override
	public BidVo selectSellBid(BidVo bidVo) {
		BidVo vo = new BidVo();
		try {
			vo = dao.selectSellBid(bidVo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return vo;
	}

	@Override
	public int updateAmount(BidVo bidVo) {
		int cnt = 0;
		try {
			cnt = dao.updateAmount(bidVo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return cnt;
	}

	@Override
	public ProdDetailVo selectProd(String sizeId) {
		ProdDetailVo vo = new ProdDetailVo();
		try {
			vo = dao.selectProd(sizeId);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return vo;
	}

	@Override
	public AddressVo selectAdressOne(String memId) {
		AddressVo vo = new AddressVo();
		try {
			vo = dao.selectAdressOne(memId);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return vo;
	}

	@Override
	public String getPoint(String memId) {
		String str = null;
		try {
			str = dao.getPoint(memId);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return str;
	}

	@Override
	public String insertBid(BidVo bidvo) {
		// TODO Auto-generated method stub
		String bidId = null;
		try {
			bidId = dao.insertBid(bidvo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return bidId;
	}

	@Override
	public String selectBid(BidVo bidvo) {
		String bidId = null;
		try {
			bidId = dao.selectBid(bidvo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return bidId;
	}

	@Override
	public int updateBid(BidVo bidvo) {
		int cnt = 0;
		try {
			cnt = dao.updateBid(bidvo);
			System.out.println("service cnt = " + cnt);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return cnt;
	}

	@Override
	public int updatePoint(BidVo bidvo) {
		int cnt = 0;
		try {
			cnt = dao.updatePoint(bidvo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return cnt;
	}

	@Override
	public int updateResell(BidVo bidvo) {
		int cnt = 0;
		try {
			cnt = dao.updateResell(bidvo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return cnt;
	}
	
	
}
