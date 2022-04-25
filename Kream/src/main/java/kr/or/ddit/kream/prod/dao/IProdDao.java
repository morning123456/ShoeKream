package kr.or.ddit.kream.prod.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import kr.or.ddit.kream.vo.BidVo;
import kr.or.ddit.kream.vo.BrandVo;
import kr.or.ddit.kream.vo.GraphVo;
import kr.or.ddit.kream.vo.LikeProdVo;
import kr.or.ddit.kream.vo.LprodVo;
import kr.or.ddit.kream.vo.MainPageProdVo;
import kr.or.ddit.kream.vo.ProdDetailVo;
import kr.or.ddit.kream.vo.ReviewVo;

public interface IProdDao {
	
	/**
	 * 메인페이지에 필요한 상품의 정보를 불러오는 메서드
	 * @return MainPageProdVo를 담은 리스트 반환
	 * @throws SQLException
	 */
	public List<MainPageProdVo> prodList() throws SQLException;

	/**
	 * 카테고리에 필요한 lprod정보를 불러오는 메서드
	 * 
	 * @return lprodvo을 담은 리스트 반환
	 * @throws SQLException
	 */
	public List<LprodVo> lprodlist() throws SQLException;
	
	/**
	 * 카테고리에 필요한 brand정보를 불러오는 메서드
	 * 
	 * @return
	 * @throws SQLException
	 */
	public List<BrandVo> brandlist() throws SQLException;
	
	/**
	 * 상품 상세페이지에 필요한 정보를 불러오는 메서드
	 * 
	 * @return ProdDetailVo를 담은 리스트 반환
	 * @throws SQLException
	 */
	public ProdDetailVo prodDetail(String prodid) throws SQLException;
	
	/**
	 * 관심상품 인서트하는 메서드
	 * @param 
	 * @return
	 * @throws SQLException
	 */
	public int prodLikeInsert(LikeProdVo vo) throws SQLException;
	
	/**
	 * 그래프에 필요한 정보를 반환하는 메서드
	 *  
	 * @param vo
	 * @return
	 * @throws SQLException
	 */
	public List<GraphVo> getGraphInfo(GraphVo vo) throws SQLException;

	/**
	 * 그래프에 필요한 정보를 반환하는 메서드
	 * 한상품의 모든 사이즈에 대한 결제 정보
	 *  
	 * @param vo
	 * @return
	 * @throws SQLException
	 */
	public List<GraphVo> getAllGraphInfo(String prodid) throws SQLException;
	
	/**
	 * 최근거래가 정보 반환
	 * 
	 * @param vo
	 * @return
	 * @throws SQLException
	 */
	public String getRecentPrice(GraphVo vo) throws SQLException;
	
	/**
	 * 관심상품 중복 체크
	 * 
	 * @param vo
	 * @return
	 * @throws SQLException
	 */
	public int checkLikeProd(LikeProdVo vo) throws SQLException;

	/**
	 * 관심상품 삭제 메서드
	 * 
	 * @param vo
	 * @return
	 * @throws SQLException
	 */
	public int deleteLikeProd(LikeProdVo vo) throws SQLException;

	/**
	 * 거래체결 내역 반환하는 메서드
	 * 
	 * @param vo
	 * @return
	 * @throws SQLException
	 */
	public List<BidVo> bidTrans(String prodid) throws SQLException;
	
	/**
	 * 카테고리 클릭시 상품 리스트를 반환 하는 메서드(메인화면에서 사용) 
	 * 
	 * @param map
	 * @return
	 * @throws SQLException
	 */
	public List<ProdDetailVo> categoryProdList(HashMap<String, String> map) throws SQLException;
	
	/**
	 * 구매자와 판매자의 입찰 내역
	 * 
	 * @param vo
	 * @return
	 * @throws SQLException
	 */
	public List<BidVo> bidTrans2(BidVo vo) throws SQLException;
	
	/**
	 * 한 상품에 대한 리뷰 출력에 필요한 정보 반환
	 * 
	 * @param prodid
	 * @return
	 * @throws SQLException
	 */
	public List<ReviewVo> reviewList(String prodid) throws SQLException;
	
	/**
	 * 리뷰페이지에 필요한 정보들
	 * 
	 * @return
	 * @throws SQLException
	 */
	public List<ReviewVo> reviewPage() throws SQLException;
	
	/**
	 * 즉시 구매가에서 제일 작은 값
	 * 
	 * @param prodid
	 * @return
	 * @throws SQLException
	 */
	public int getbuyPrice(String prodid) throws SQLException;

	/**
	 * 즉시 판매가에서 제일 큰 값
	 * 
	 * @param prodid
	 * @return
	 * @throws SQLException
	 */
	public int getsellPrice(String prodid) throws SQLException;
	
	/**
	 * 사용자가 검색했을때의 상품 리스트
	 * 
	 * @param input
	 * @return
	 * @throws SQLException
	 */
	public List<MainPageProdVo> prodSearch(String input) throws SQLException;
}















