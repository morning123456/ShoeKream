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

import kr.or.ddit.kream.prod.service.IProdService;
import kr.or.ddit.kream.prod.service.ProdServiceImpl;
import kr.or.ddit.kream.vo.LprodVo;

@WebServlet("/prodCategory.do")
public class prodCategory extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//상품의 카테고리를 불러오는 서블릿이다.
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		
		IProdService service = ProdServiceImpl.getInstance();
		
		String data = ""; //json데이터를 넣을 변수
		
			List<LprodVo> list = service.lprodlist();

			Gson gson = new Gson();
			data = gson.toJson(list);

			response.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		out.write(data);
		out.flush();
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}








