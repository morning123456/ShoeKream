package kr.or.ddit.kream.card.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.or.ddit.kream.card.service.CardServiceImpl;
import kr.or.ddit.kream.card.service.ICardService;

/**
 * Servlet implementation class CardController
 */
@WebServlet("/CardController.do")
public class CardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static ICardService service; 
	
	public CardController() {
		service = CardServiceImpl.getInstance();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String memId = request.getParameter("memId");
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		String card = service.selectCard(memId);
		System.out.println("card="+card);
		Gson gson = new Gson();
		
		String json = gson.toJson(card);
		
		out.write(json);
		out.flush();
	}

}
