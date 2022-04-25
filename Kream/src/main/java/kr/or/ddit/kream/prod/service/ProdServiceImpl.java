package kr.or.ddit.kream.prod.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import kr.or.ddit.kream.prod.dao.IProdDao;
import kr.or.ddit.kream.prod.dao.ProdDaoImpl;
import kr.or.ddit.kream.vo.BidVo;
import kr.or.ddit.kream.vo.BrandVo;
import kr.or.ddit.kream.vo.GraphVo;
import kr.or.ddit.kream.vo.LikeProdVo;
import kr.or.ddit.kream.vo.LprodVo;
import kr.or.ddit.kream.vo.MainPageProdVo;
import kr.or.ddit.kream.vo.ProdDetailVo;
import kr.or.ddit.kream.vo.ReviewVo;


public class ProdServiceImpl implements IProdService{
	
	private static IProdDao dao;
	private static IProdService service;
	
	private ProdServiceImpl() {
		dao = ProdDaoImpl.getInstance();
	}

	public static IProdService getInstance() {
		if(service == null) service = new ProdServiceImpl();
		return service;
	}

	//상품의 모든 정보를 가져오는 메서드
	@Override
	public List<MainPageProdVo> prodList(){

		List<MainPageProdVo> list = null;
		
		try {
			list = dao.prodList();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public List<LprodVo> lprodlist() {

		List<LprodVo> list = null;
		
		try {
			list = dao.lprodlist();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public ProdDetailVo prodDetail(String prodid) {

		ProdDetailVo vo = null;
		
		try {
			vo = dao.prodDetail(prodid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return vo;
	}

	@Override
	public int prodLikeInsert(LikeProdVo vo) {

		int res = 0;
		
		try {
			res = dao.prodLikeInsert(vo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public List<GraphVo> getGraphInfo(GraphVo vo) {

		List<GraphVo> list = null;
		
		try {
			list = dao.getGraphInfo(vo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public String getRecentPrice(GraphVo vo) {

		String res = "";
		
		try {
			res = dao.getRecentPrice(vo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int checkLikeProd(LikeProdVo vo) {

		int res = 0;
		
		try {
			res = dao.checkLikeProd(vo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int deleteLikeProd(LikeProdVo vo) {

		int res = 0;
		
		try {
			res = dao.deleteLikeProd(vo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public List<BrandVo> brandlist() {

		List<BrandVo> list = null;
		
		try {
			list = dao.brandlist();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public List<BidVo> bidTrans(String prodid) {

		List<BidVo> list = null;
		
		try {
			list = dao.bidTrans(prodid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public List<ProdDetailVo> categoryProdList(HashMap<String, String> map) {

		List<ProdDetailVo> list = null;
		
		try {
			list = dao.categoryProdList(map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public List<GraphVo> getAllGraphInfo(String prodid) {

		List<GraphVo> list = null;
		
		try {
			list = dao.getAllGraphInfo(prodid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public List<BidVo> bidTrans2(BidVo vo) {

		List<BidVo> list = null;
		
		try {
			list = dao.bidTrans2(vo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public List<ReviewVo> reviewList(String prodid) {

		List<ReviewVo> list = null;
		
		try {
			list = dao.reviewList(prodid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public List<ReviewVo> reviewPage() {

		List<ReviewVo> list = null;
		
		try {
			list = dao.reviewPage();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int getbuyPrice(String prodid) {

		int price = 0;
		
		try {
			price = dao.getbuyPrice(prodid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return price;
	}

	@Override
	public int getsellPrice(String prodid) {

		int price = 0;

		try {
			price = dao.getsellPrice(prodid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return price;
	}

	@Override
	public List<MainPageProdVo> prodSearch(String input) {

		List<MainPageProdVo> list = null;
		
		try {
			list = dao.prodSearch(input);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	
}













