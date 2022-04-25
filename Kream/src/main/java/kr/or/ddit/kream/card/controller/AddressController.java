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
import kr.or.ddit.kream.vo.AddressVo;

/**
 * Servlet implementation class AddressController
 */
@WebServlet("/AddressController.do")
public class AddressController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static IOrderService service; 
	
	public AddressController() {
		service = OrderServiceImpl.getInstance();
	}
    

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String memId = request.getParameter("memId");
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		AddressVo vo = service.selectAdressOne(memId);
		
		Gson gson = new Gson();
		
		String json = gson.toJson(vo);
		
		out.write(json);
		out.flush();
	}

}
