package kr.or.ddit.kream.bid.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.or.ddit.kream.card.service.IOrderService;
import kr.or.ddit.kream.card.service.OrderServiceImpl;
import kr.or.ddit.kream.prod.service.IProdService;
import kr.or.ddit.kream.prod.service.ProdServiceImpl;
import kr.or.ddit.kream.vo.ProdDetailVo;

/**
 * Servlet implementation class SellPhoto
 */
@WebServlet("/SellPhoto.do")
public class SellPhoto extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static IOrderService service; 

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		
		String prodid = request.getParameter("prodid");
		
		System.out.println(prodid);
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		IProdService service = ProdServiceImpl.getInstance();
		
		ProdDetailVo vo = service.prodDetail(prodid); 
		
		Gson gson = new Gson();
		
		String json = gson.toJson(vo);
		
		out.write(json);
		out.flush();
	
	
	}

	

}
