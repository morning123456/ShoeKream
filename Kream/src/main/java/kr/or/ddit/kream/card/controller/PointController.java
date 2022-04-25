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

@WebServlet("/PointController.do")
public class PointController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static IOrderService service; 
	
	public PointController() {
		service = OrderServiceImpl.getInstance();
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
request.setCharacterEncoding("utf-8");
		
		String memId = request.getParameter("memId");
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		System.out.println(memId);
		String point = service.getPoint(memId);
		System.out.println(point);
		Gson gson = new Gson();
		
		String json = gson.toJson(point);
		
		out.write(json);
		out.flush();
	}
}
