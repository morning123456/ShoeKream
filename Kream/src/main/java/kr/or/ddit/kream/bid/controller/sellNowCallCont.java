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
import kr.or.ddit.kream.vo.BidVo;

/**
 * Servlet implementation class sellNowCallCont
 */
@WebServlet("/sellNowCallCont.do")
public class sellNowCallCont extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		
		 String size_name = request.getParameter("size_name");
		 String prodid = request.getParameter("prodid");
		 System.out.println("사이즈"+size_name);
		 System.out.println("이름"+prodid);
		IBidService service = BidServiceImpl.getInstance();
			
		Map<String, String> paramap = new HashMap<String, String>();
	    
	    paramap.put("size_name", size_name);
	    paramap.put("prodid", prodid);
	    
		
		 String sellNCPRice = service.sellNowCall(paramap);	
		 System.out.println("sellNCPRice :" + sellNCPRice);
		 Gson gson = new Gson();
		 
		 String result = gson.toJson(sellNCPRice);
		 
		 response.setCharacterEncoding("utf-8");
		 response.setContentType("application/json; charset=utf-8");
		 PrintWriter out = response.getWriter();
			
		out.write(result);
		out.flush();
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
		
	}

}
