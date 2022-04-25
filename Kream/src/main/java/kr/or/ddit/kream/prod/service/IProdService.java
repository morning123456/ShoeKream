package kr.or.ddit.kream.prod.service;

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


public interface IProdService {

	/**
	 * 메인페이지에 필요한 상품의 정보를 불러오는 메서드
	 * @return MainPageProdVo를 담은 리스트 반환
	 */
	public List<MainPageProdVo> prodList();

	/**
	 * 카테고리에 필요한 lprod정보를 불러오는 메서드
	 * 
	 * @return lprodvo을 담은 리스트 반환
	 */
	public List<LprodVo> lprodlist();
	
	/**
	 * 카테고리에 필요한 brand정보를 불러오는 메서드
	 * 
	 * @return
	 */
	public List<BrandVo> brandlist();
	
	/**
	 * 상품 상세페이지에 필요한 정보를 불러오는 메서드
	 * 
	 * @return ProdDetailVo를 담은 리스트 반환
	 */
	public ProdDetailVo prodDetail(String prodid);
	
	/**
	 * 관심상품 인서트하는 메서드
	 * 
	 * @param vo
	 * @return
	 */
	public int prodLikeInsert(LikeProdVo vo);
	
	/**
	 * 그래프에 필요한 정보를 반환하는 메서드
	 *  
	 * @param vo
	 * @return
	 */
	public List<GraphVo> getGraphInfo(GraphVo vo);
	
	/**
	 * 그래프에 필요한 정보를 반환하는 메서드
	 * 한상품의 모든 사이즈에 대한 결제 정보
	 *  
	 * @param vo
	 * @return
	 */
	public List<GraphVo> getAllGraphInfo(String prodid);
	
	/**
	 * 최근거래가 정보 반환
	 * 
	 * @param vo
	 * @return
	 */
	public String getRecentPrice(GraphVo vo);
	
	/**
	 * 관심상품 중복 체크
	 * 
	 * @param vo
	 * @return
	 */
	public int checkLikeProd(LikeProdVo vo);
	
	/**
	 * 관심상품 삭제 메서드
	 * 
	 * @param vo
	 * @return
	 */
	public int deleteLikeProd(LikeProdVo vo);
	
	/**
	 * 거래체결 내역 반환하는 메서드
	 * 
	 * @param vo
	 * @return
	 */
	public List<BidVo> bidTrans(String prodid);
	
	/**
	 * 카테고리 클릭시 상품 리스트를 반환 하는 메서드(메인화면에서 사용) 
	 * 
	 * @param map
	 * @return
	 */
	public List<ProdDetailVo> categoryProdList(HashMap<String, String> map);
	
	/**
	 * 구매자와 판매자의 입찰 내역
	 * 
	 * @param vo
	 * @return
	 */
	public List<BidVo> bidTrans2(BidVo vo);
	
	/**
	 * 한 상품에 대한 리뷰 출력에 필요한 정보 반환
	 * 
	 * @param prodid
	 * @return
	 */
	public List<ReviewVo> reviewList(String prodid);
	
	/**
	 * 리뷰페이지에 필요한 정보들
	 * 
	 * @return
	 * @throws SQLException
	 */
	public List<ReviewVo> reviewPage();
	
	/**
	 * 즉시 구매가에서 제일 작은 값
	 * 
	 * @param prodid
	 * @return
	 * @throws SQLException
	 */
	public int getbuyPrice(String prodid);

	/**
	 * 즉시 판매가에서 제일 큰 값
	 * 
	 * @param prodid
	 * @return
	 */
	public int getsellPrice(String prodid);
	
	/**
	 * 사용자가 검색했을때의 상품 리스트
	 * 
	 * @param input
	 * @return
	 */
	public List<MainPageProdVo> prodSearch(String input);
	
}
