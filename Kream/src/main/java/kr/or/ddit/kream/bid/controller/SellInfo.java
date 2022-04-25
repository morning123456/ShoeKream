package kr.or.ddit.kream.bid.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.or.ddit.kream.bid.service.BidServiceImpl;
import kr.or.ddit.kream.bid.service.IBidService;
import kr.or.ddit.kream.size.service.ISizeService;
import kr.or.ddit.kream.size.service.SizeServiceImpl;
import kr.or.ddit.kream.vo.BidVo;

/**
 * Servlet implementation class SellInfo
 */
@WebServlet("/SellInfo.do")
public class SellInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	
		request.setCharacterEncoding("utf-8");
		
		 String prodid= request.getParameter("prodid");
		 
		IBidService service = BidServiceImpl.getInstance();
			
		 List<BidVo> list = service.sellInfo(prodid);	
		 
		 Gson gson = new Gson();
			
		 String result = gson.toJson(list);
		 
		 response.setCharacterEncoding("utf-8");
		 response.setContentType("application/json; charset=utf-8");
		 PrintWriter out = response.getWriter();
			
		out.write(result);
		out.flush();
		

	
	}


}
