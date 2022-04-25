package kr.or.ddit.kream.prod.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.kream.util.SqlMapClientFactory;
import kr.or.ddit.kream.vo.BidVo;
import kr.or.ddit.kream.vo.BrandVo;
import kr.or.ddit.kream.vo.GraphVo;
import kr.or.ddit.kream.vo.LikeProdVo;
import kr.or.ddit.kream.vo.LprodVo;
import kr.or.ddit.kream.vo.MainPageProdVo;
import kr.or.ddit.kream.vo.ProdDetailVo;
import kr.or.ddit.kream.vo.ReviewVo;

public class ProdDaoImpl implements IProdDao{

	private SqlMapClient smc;
	private static IProdDao dao;
	
	private ProdDaoImpl() {
		smc = SqlMapClientFactory.getSqlMapClient();
	}
	
	public static IProdDao getInstance() {
		if(dao==null) dao = new ProdDaoImpl();
		return dao;
	}

	@Override
	public List<MainPageProdVo> prodList() throws SQLException {
		
		return smc.queryForList("prod.prodlist");
	}

	@Override
	public List<LprodVo> lprodlist() throws SQLException {
		// TODO Auto-generated method stub
		return smc.queryForList("prod.lprodlist");
	}

	@Override
	public ProdDetailVo prodDetail(String prodid) throws SQLException {
		// TODO Auto-generated method stub
		return (ProdDetailVo) smc.queryForObject("prod.prodDetail", prodid);
	}

	@Override
	public int prodLikeInsert(LikeProdVo vo) throws SQLException {
		// TODO Auto-generated method stub
		return smc.update("prod.prodLikeInsert", vo);
	}

	@Override
	public List<GraphVo> getGraphInfo(GraphVo vo) throws SQLException {
		// TODO Auto-generated method stub
		return smc.queryForList("prod.getGraphInfo", vo);
	}

	@Override
	public String getRecentPrice(GraphVo vo) throws SQLException {
		// TODO Auto-generated method stub
		return (String) smc.queryForObject("prod.getRecentPrice", vo);
	}

	@Override
	public int checkLikeProd(LikeProdVo vo) throws SQLException {
		// TODO Auto-generated method stub
		return (int) smc.queryForObject("prod.checkLikeProd", vo);
	}

	@Override
	public int deleteLikeProd(LikeProdVo vo) throws SQLException {
		// TODO Auto-generated method stub
		return smc.delete("prod.deleteLikeProd", vo);
	}

	@Override
	public List<BrandVo> brandlist() throws SQLException {
		// TODO Auto-generated method stub
		return smc.queryForList("prod.brandlist");
	}

	@Override
	public List<BidVo> bidTrans(String prodid) throws SQLException {
		// TODO Auto-generated method stub
		return smc.queryForList("prod.bidTrans", prodid);
	}

	@Override
	public List<ProdDetailVo> categoryProdList(HashMap<String, String> map) throws SQLException {
		// TODO Auto-generated method stub
		return smc.queryForList("prod.categoryProdlist", map);
	}

	@Override
	public List<GraphVo> getAllGraphInfo(String prodid) throws SQLException {
		// TODO Auto-generated method stub
		return smc.queryForList("prod.getAllGraphInfo", prodid);
	}

	@Override
	public List<BidVo> bidTrans2(BidVo vo) throws SQLException {
		// TODO Auto-generated method stub
		return smc.queryForList("prod.bidTrans2", vo);
	}

	@Override
	public List<ReviewVo> reviewList(String prodid) throws SQLException {
		// TODO Auto-generated method stub
		return smc.queryForList("prod.reviewList", prodid);
	}

	@Override
	public List<ReviewVo> reviewPage() throws SQLException {
		// TODO Auto-generated method stub
		return smc.queryForList("prod.reviewPage");
	}

	@Override
	public int getbuyPrice(String prodid) throws SQLException {
		// TODO Auto-generated method stub
		return (int) smc.queryForObject("prod.getbuyPrice", prodid);
	}

	@Override
	public int getsellPrice(String prodid) throws SQLException {
		// TODO Auto-generated method stub
		return (int) smc.queryForObject("prod.getsellPrice", prodid);
	}

	@Override
	public List<MainPageProdVo> prodSearch(String input) throws SQLException {
		// TODO Auto-generated method stub
		return smc.queryForList("prod.prodSearch", input);
	}
}
