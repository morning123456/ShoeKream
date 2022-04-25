package kr.or.ddit.kream.prod.controller;

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
 * Servlet implementation class prodAllSize
 */
@WebServlet("/prodAllSize.do")
public class prodAllSize extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		String prodid = request.getParameter("prodid");
		
		//서비스 객체 생성후 메서드 호출
		IBidService bidservice = BidServiceImpl.getInstance();
		
		List<BidVo> list = bidservice.buyInfo(prodid);

		Gson gson = new Gson();
		
		String data = gson.toJson(list);
		
		out.write(data);
		out.flush();		
		
//		request.setAttribute("prodid", prodid);
//		request.getRequestDispatcher("/prodview/prodDetail.jsp").forward(request, response);
	}

}








