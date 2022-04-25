package kr.or.ddit.kream.card.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.kream.card.service.IOrderService;
import kr.or.ddit.kream.card.service.OrderServiceImpl;
import kr.or.ddit.kream.vo.BidVo;

/**
 * Servlet implementation class InsertBidController
 */
@WebServlet("/DirectPayController.do")
public class DirectPayController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static IOrderService service;      
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DirectPayController() {
       service =OrderServiceImpl.getInstance();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		String mybidid = null;
		String prod_id = request.getParameter("prod_id"); //제품코드
		String point = request.getParameter("point"); //사용포인트
		String mem_email = request.getParameter("mem_email");
		String bid_position= request.getParameter("bid_position");
		String size_id= request.getParameter("size_id");
		int bid_price= Integer.parseInt(request.getParameter("bid_price"));
		
		System.out.println(point);
		if(point.equals("")) {
			point = "0";
		}
		
		BidVo bidvo = new BidVo();
		bidvo.setMem_email(mem_email);
		bidvo.setSize_id(size_id);
		bidvo.setBid_position(bid_position);
		
		String bidId = service.selectBid(bidvo); //회원이 같은 상품(사이즈)를 입찰했는지 찾기 
		System.out.println(bidId);
		
		
		if(bidId==null || bidId.equals("")) { //입찰건이 없으면 insert
			bidvo = new BidVo();
			bidvo.setMem_email(mem_email);
			bidvo.setBid_position(bid_position);
			bidvo.setSize_id(size_id);
			bidvo.setPoint(Integer.parseInt(point));
			bidvo.setBid_price(bid_price);
			
			mybidid = service.insertBid(bidvo);
			
			
		}else { //있으면 해당 입찰건을 수정한다. 
			bidvo = new BidVo();
			bidvo.setBid_id(bidId);
			bidvo.setPoint(Integer.parseInt(point));
			bidvo.setBid_price(bid_price);
		
			int cnt = service.updateBid(bidvo);
			System.out.println("controller cnt =" + cnt);
			mybidid = bidId;
		}
		
		
		BidVo sellvo = new BidVo();
		BidVo ordervo = new BidVo();
		
	    if(bid_position.equals("buyer")) {  // 구매입찰 했을 때 
	    	bidvo = new BidVo();
			bidvo.setSize_id(size_id);
			bidvo.setBid_price(bid_price);
	    
			
			sellvo = service.selectSellBid(bidvo); //판매입찰건에서 bid_id, mem_email 가져오기 
			
			
	    	
			if(sellvo!=null) {
				
				Map<String,Object> map = new HashMap<String, Object>();
				
				map.put("bid_id1", mybidid);
				map.put("bid_id2", sellvo.getBid_id());
				
				int statecnt = service.updateBidState(map); //입찰 상태 변경 
				
				bidvo = new BidVo();
				bidvo.setBid_id(mybidid);
				bidvo.setMem_email(sellvo.getMem_email()); //응찰자
				bidvo.setBid_price(bid_price);  //응찰가격 
				
				int temporder = service.insertBidTemp(bidvo); //응찰 테이블에 구매입찰건 넣기 
				
				bidvo = new BidVo();
				bidvo.setBid_id(sellvo.getBid_id()); // 판매입찰코드 
				bidvo.setMem_email(mem_email); //응찰자
				bidvo.setBid_price(bid_price);  //응찰가격 
				
				int tempsell = service.insertBidTemp(bidvo); //응찰 테이블에 판매입찰건 넣기 
				
				
				
				int order_price = bid_price + 3000 - Integer.parseInt(point);
				
				bidvo = new BidVo();
				bidvo.setBid_id(mybidid); //구매입찰코드 
				bidvo.setMem_email(sellvo.getMem_email()); //판매자아이디
				bidvo.setOrder_price(order_price); // 총결제금액 
				
				int ordercnt = service.insertOrder(bidvo); //구매주문테이블 추가 (결제 완료 ) 
				
				bidvo = new BidVo();
				bidvo.setBid_id(sellvo.getBid_id()); //판매입찰코드
				bidvo.setMem_email(mem_email); //구매자아이디
				bidvo.setOrder_price(bid_price); // 총결제금액 
				
				int sellcnt = service.insertOrder(bidvo); //판매주문테이블 추가 (판매 완료 ) 
				
				//구매자 포인트 차감 
				bidvo = new BidVo();
				bidvo.setMem_email(mem_email);
				bidvo.setPoint(Integer.parseInt(point));
				
				int updateP = service.updatePoint(bidvo);
				//판매자 정산 
				bidvo = new BidVo();
				bidvo.setMem_email(sellvo.getMem_email()); //판매자 
				bidvo.setBid_price(bid_price);  //응찰가격 
				
				int amount = service.updateAmount(bidvo);
				
			}else {
				
				System.out.println("결제실패");
			}
			
			
	    	
			
			
	    	
	    }else if(bid_position.equals("seller")){
	    	
	    	bidvo = new BidVo();
			bidvo.setSize_id(size_id);
			bidvo.setBid_price(bid_price);
	    
			
			ordervo = service.selectOrderBid(bidvo); //구매입찰건에서 bid_id, mem_email, point 가져오기 
	    	
			if(sellvo!=null) {
				Map<String,Object> map = new HashMap<String, Object>();
				
				map.put("bid_id1", mybidid); //판매입찰 코드 
				map.put("bid_id2", ordervo.getBid_id()); //구매입찰코드 
				
				int statecnt = service.updateBidState(map); //입찰 상태 변경 
				
				bidvo = new BidVo();
				bidvo.setBid_id(mybidid);//판매입찰코드 
				bidvo.setMem_email(ordervo.getMem_email()); //구매자이메일
				bidvo.setBid_price(bid_price);  //응찰가격 
				
				int temporder = service.insertBidTemp(bidvo); //응찰 테이블에 구매입찰건 넣기 
				
				bidvo = new BidVo();
				bidvo.setBid_id(ordervo.getBid_id()); // 구매입찰코드 
				bidvo.setMem_email(mem_email); //판매자
				bidvo.setBid_price(bid_price);  //응찰가격 
				
				int tempsell = service.insertBidTemp(bidvo); //응찰 테이블에 판매입찰건 넣기 
				
				int order_price = bid_price + 3000 - ordervo.getPoint();
				
				bidvo = new BidVo();
				bidvo.setBid_id(mybidid); //판매입찰코드 
				bidvo.setMem_email(ordervo.getMem_email()); //구매자
				bidvo.setOrder_price(bid_price); // 판매금액 
				
				int ordercnt = service.insertOrder(bidvo); //구매주문테이블 추가 (결제 완료 ) 
				
				bidvo = new BidVo();
				bidvo.setBid_id(ordervo.getBid_id()); //구매입찰코드
				bidvo.setMem_email(mem_email); //판매자아이디
				bidvo.setOrder_price(order_price); // 총결제금액 
				
				int sellcnt = service.insertOrder(bidvo); //판매주문테이블 추가 (판매 완료 ) 
				
				//구매자 포인트 차감 
				bidvo = new BidVo();
				bidvo.setMem_email(ordervo.getMem_email());
				bidvo.setPoint(ordervo.getPoint());
				
				int updateP = service.updatePoint(bidvo);
				//판매자 정산 
				bidvo = new BidVo();
				bidvo.setMem_email(mem_email); //판매자 
				bidvo.setBid_price(bid_price);  //응찰가격 
				
				int amount = service.updateAmount(bidvo);
				
			}else {
				System.out.println("결제실패");
			}
	    	
	    }
	    bidvo = new BidVo();
		bidvo.setProd_id(prod_id);
		bidvo.setBid_price(bid_price);
		
		int resellcnt = service.updateResell(bidvo);
		
		
		request.setAttribute("prod_id", prod_id);
		request.setAttribute("mem_email", mem_email);
		request.setAttribute("bid_position", bid_position);
		request.setAttribute("size_id", size_id);
		request.setAttribute("bid_price", bid_price);
		request.setAttribute("point", Integer.parseInt(point));
	
		
		request.getRequestDispatcher("/order/payComplete.jsp").forward(request, response);
		
		
	}
	
	
	

}
