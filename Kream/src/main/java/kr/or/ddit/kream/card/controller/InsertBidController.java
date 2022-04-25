package kr.or.ddit.kream.card.controller;

import java.io.IOException;

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
@WebServlet("/InsertBidController.do")
public class InsertBidController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static IOrderService service;      
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertBidController() {
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
		String point = request.getParameter("point");
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
			
		}
		request.setAttribute("prod_id", prod_id);
		request.setAttribute("mem_email", mem_email);
		request.setAttribute("bid_position", bid_position);
		request.setAttribute("size_id", size_id);
		request.setAttribute("bid_price", bid_price);
		request.setAttribute("point", Integer.parseInt(point));
	
		
		request.getRequestDispatcher("/order/orderComplete.jsp").forward(request, response);
		
		
	}
	
	
	

}
