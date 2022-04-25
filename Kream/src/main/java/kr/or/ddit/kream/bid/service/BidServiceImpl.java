package kr.or.ddit.kream.bid.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.kream.bid.dao.BidDaoImpl;
import kr.or.ddit.kream.bid.dao.IBidDao;
import kr.or.ddit.kream.vo.BidVo;

public class BidServiceImpl implements IBidService{

	private IBidDao dao;  // 
	private static IBidService Service;
	
	private BidServiceImpl() {
		dao = BidDaoImpl.getInstance();	//
	}

	public static IBidService getInstance(){
		if(Service==null) Service = new BidServiceImpl();
		return Service;
	}



	@Override
	public List<BidVo> sellInfo(String prodid) {
		List<BidVo> list = null;
		
		try {
			list = dao.sellInfo(prodid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list; 
	}

	@Override
	public List<BidVo> buyInfo(String prodid) {

		List<BidVo> list = null;
		
		try {
			list = dao.buyInfo(prodid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int insertBid(BidVo bidvo) {
		// TODO Auto-generated method stub
		int cnt = 0;
		try {
			cnt = dao.insertBid(bidvo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return cnt;
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
	public String sellNowCall(Map<String, String> map) {
		String sizeName = null;
		try {
			sizeName = dao.sellNowCall(map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return sizeName;
	}

	@Override
	public String buyNowCall(Map<String, String> map) {
		String sizeName = null;
		try {
			sizeName = dao.buyNowCall(map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return sizeName;
	}

	
	
	
}
