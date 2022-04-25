package kr.or.ddit.kream.bid.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class buyAgreeServlet
 */
@WebServlet("/buyAgreeServlet.do")
public class buyAgreeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		String prodid = request.getParameter("prodid");  // 사이즈, 가격, 사진, 상품이름 등 정보 불러와야 함
		String size_name = request.getParameter("size_name");  // 사이즈
		String bid_price = request.getParameter("bid_price");  // 가격
		
		String size_id = request.getParameter("size_id");  // 사이즈 id   //추가
		
		request.setAttribute("prodid", prodid);
		request.setAttribute("size_name", size_name);
		request.setAttribute("bid_price", bid_price);
		
		request.setAttribute("size_id", size_id);  //추가

		request.getRequestDispatcher("/bid/buyAgree.jsp").forward(request, response);
		
	
	
	
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
