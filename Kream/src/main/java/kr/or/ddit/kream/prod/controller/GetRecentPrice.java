package kr.or.ddit.kream.prod.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.or.ddit.kream.prod.service.IProdService;
import kr.or.ddit.kream.prod.service.ProdServiceImpl;
import kr.or.ddit.kream.vo.GraphVo;

@WebServlet("/GetRecentPrice.do")
public class GetRecentPrice extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		
		String prodid = request.getParameter("prodid");
		String sizenm = request.getParameter("sizenm");
		
		GraphVo vo = new GraphVo();
		vo.setProd_id(prodid);
		vo.setSize_name(sizenm);
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		IProdService service = ProdServiceImpl.getInstance();
		
		String recentPrice = service.getRecentPrice(vo);
		System.out.println(recentPrice);
		
		Gson gson = new Gson();
		
		String res = gson.toJson(recentPrice);
		
		if(res == null) {
			out.print("alert('낙찰내역이 없습니다');");
			out.flush();
		}else {
			out.write(res);
			out.flush();
		}
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
