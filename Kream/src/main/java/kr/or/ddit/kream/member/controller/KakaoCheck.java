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

@WebServlet("/KakaoCheck.do")
public class KakaoCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		IMemberService service = MemberServiceImpl.getInstance();
		String email = request.getParameter("email");
		String nickname = request.getParameter("nickname");
		
		String count = service.snsCount(email);
		
		if(count.equals("0")) {
			//회원가입 진행
		}else {
			//로그인 진행
		}
		
		
		
		
		
		
		
		
		System.out.println(email);
		System.out.println(nickname);
		
		Gson gson = new Gson();
		
		String res = gson.toJson(count);
		
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
