package kr.or.ddit.kream.member.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.or.ddit.kream.member.service.IMemberService;
import kr.or.ddit.kream.member.service.MemberServiceImpl;
import kr.or.ddit.kream.vo.MemberVO;

/**
 * Servlet implementation class EmailCheck
 */
@WebServlet("/emailCheck.do")
public class EmailCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		String mem_email = request.getParameter("email");
		
		MemberVO vo = new MemberVO();
		
		IMemberService service = MemberServiceImpl.getInstance();
		
		MemberVO memberVo = service.getMember(vo);
		
		String result = "";
		if(memberVo != null) {
			result = "중복";
		}else {
			result = "가능";
		}
		
		Gson gson = new Gson();
		
		String res = gson.toJson(result);
		
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		out.print(res);
		out.flush();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
