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

	//sell.jsp���� ���۵���Ÿ �ޱ�
	 String input= request.getParameter("idvalue");
	 
	//service��ü ���� 
	 ISizeService service = SizeServiceImpl.getInstance();
		
	//service�޼ҵ� ȣ�� 
	 List<String> list = service.sizeInfo(input);	
	    
		
	 //request�� ���� 
		request.setAttribute("list", list);
			
	 //jsp�� forward
			request.getRequestDispatcher("bid/sell.jsp")
			       .forward(request, response);  
	 
			 
	
		
//		request.setCharacterEncoding("utf-8");
//	    ISizeService service = SizeServiceImpl.getInstance();
//	    
//	    //��ǰ ������������ prod_id ��������
//	    String prod_id = request.getParameter("prod_id");
//	    
//	    List<String> list = null;
//	    
//		list = service.sizeInfo(prod_id);
//	    
//	    request.setAttribute("list", list);
//	    
//	    //��ǰ ������ �������� �̵��ϱ�
//	    request.getRequestDispatcher("bid/sell.jsp").forward(request, response);
//	
	
	
	}


}
