package kr.or.ddit.kream.card.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import kr.or.ddit.kream.card.service.CardServiceImpl;
import kr.or.ddit.kream.card.service.ICardService;
import kr.or.ddit.kream.vo.CardVo;
import kr.or.ddit.kream.vo.MemberVO;

/**
 * Servlet implementation class insertCard
 */
@WebServlet("/InsertCardController.do")
public class InsertCardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static ICardService service; 
		
	public InsertCardController() {
		service = CardServiceImpl.getInstance();
	}
   
  

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		
		MemberVO memberVo = (MemberVO)session.getAttribute("memberVo");
		
		String cardyn = request.getParameter("cardyn");
		System.out.println(cardyn);
		String cardnum = request.getParameter("cardnum");
		String expiry = request.getParameter("expiry");
		String birth = request.getParameter("birth");
		String secret = request.getParameter("secret");
		
		CardVo cardvo = new CardVo();
		cardvo.setMem_email(memberVo.getMem_email());
		cardvo.setCard_number(cardnum);
		cardvo.setExpiry(expiry);
		cardvo.setBirth(birth);
		cardvo.setPwd_2digit(secret);
		
		if(cardyn.equals("카드없음")) {
			//insert
			int cnt = service.insertCard(cardvo);
		}else {
			//update
			int cnt = service.updateCard(cardvo);
		}
		
		Gson gson = new Gson();
		
		String result = gson.toJson(cardvo.getCard_number());
		
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		out.print(result);
		out.flush();
	}

}
