package kr.or.ddit.kream.bid.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.or.ddit.kream.bid.service.BidServiceImpl;
import kr.or.ddit.kream.bid.service.IBidService;
import kr.or.ddit.kream.vo.BidVo;

/**
 * Servlet implementation class buyInfo
 */
@WebServlet("/buyInfo.do")
public class buyInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		
		String prodid= request.getParameter("prodid");
		 
		IBidService service = BidServiceImpl.getInstance();
			
		 List<BidVo> list = service.buyInfo(prodid);	
		 
		 Gson gson = new Gson();
			
		 String result = gson.toJson(list);
		 
		 response.setCharacterEncoding("utf-8");
		 response.setContentType("application/json; charset=utf-8");
		 PrintWriter out = response.getWriter();
			
		out.write(result);
		out.flush();
	
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
