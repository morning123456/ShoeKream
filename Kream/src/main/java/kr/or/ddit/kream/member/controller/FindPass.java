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

@WebServlet("/findPass.do")
public class FindPass extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		IMemberService service = MemberServiceImpl.getInstance();
		
		MemberVO vo = new MemberVO();
		vo.setMem_email(request.getParameter("mem_email"));
		vo.setMem_name(request.getParameter("mem_name"));
		
		String mem_pass = service.findPass(vo);
		
		Gson gson = new Gson();
		
		String result = gson.toJson(mem_pass);
		
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		out.print(result);
		out.flush();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
