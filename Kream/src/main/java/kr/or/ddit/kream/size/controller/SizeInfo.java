package kr.or.ddit.kream.size.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.kream.bid.service.BidServiceImpl;
import kr.or.ddit.kream.bid.service.IBidService;
import kr.or.ddit.kream.size.service.ISizeService;
import kr.or.ddit.kream.size.service.SizeServiceImpl;
import kr.or.ddit.kream.vo.BidVo;

/**
 * Servlet implementation class SizeInfo
 */
@WebServlet("/SizeInfo.do")
public class SizeInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	//sell.jsp에서 전송데이타 받기
	 String input= request.getParameter("idvalue");
	 
	//service객체 생성 
	 ISizeService service = SizeServiceImpl.getInstance();
		
	//service메소드 호출 
	 List<String> list = service.sizeInfo(input);	
	    
		
	 //request에 저장 
		request.setAttribute("list", list);
			
	 //jsp로 forward
			request.getRequestDispatcher("bid/sell.jsp")
			       .forward(request, response);  
	 
			 
	
		
//		request.setCharacterEncoding("utf-8");
//	    ISizeService service = SizeServiceImpl.getInstance();
//	    
//	    //상품 상세페이지에서 prod_id 가져오기
//	    String prod_id = request.getParameter("prod_id");
//	    
//	    List<String> list = null;
//	    
//		list = service.sizeInfo(prod_id);
//	    
//	    request.setAttribute("list", list);
//	    
//	    //상품 사이즈 페이지로 이동하기
//	    request.getRequestDispatcher("bid/sell.jsp").forward(request, response);
//	
	
	
	}


}
