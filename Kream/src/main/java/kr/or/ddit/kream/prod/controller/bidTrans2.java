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
import kr.or.ddit.kream.vo.BidVo;

@WebServlet("/bidTrans2.do")
public class bidTrans2 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		request.setCharacterEncoding("utf-8");
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		String prodid = request.getParameter("prodid");
		String position = request.getParameter("position");
		
		BidVo vo = new BidVo();
		vo.setProd_id(prodid);
		vo.setBid_position(position);
		
		IProdService service = ProdServiceImpl.getInstance();
		
		List<BidVo> list = service.bidTrans2(vo);
		
		Gson gson = new Gson();
		
		String data = gson.toJson(list);
		
		out.write(data);
		out.flush();
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
