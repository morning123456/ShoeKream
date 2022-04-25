package kr.or.ddit.kream.card.controller;

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
import kr.or.ddit.kream.vo.ProdDetailVo;

/**
 * Servlet implementation class OrderController
 */
@WebServlet("/OrderController.do")
public class OrderController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static IOrderService service; 
	
	public OrderController() {
		service = OrderServiceImpl.getInstance();
	}
    
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String sizeId = request.getParameter("sizeId");
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		ProdDetailVo vo = service.selectProd(sizeId);
		Gson gson = new Gson();
		
		String json = gson.toJson(vo);
		
		out.write(json);
		out.flush();
		
	}

}
