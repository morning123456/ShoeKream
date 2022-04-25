package kr.or.ddit.kream.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.ddit.kream.member.service.IMemberService;
import kr.or.ddit.kream.member.service.MemberServiceImpl;
import kr.or.ddit.kream.vo.MemberVO;

@WebServlet("/Login.do")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		String mem_email = request.getParameter("mem_email");
		String mem_pass = request.getParameter("mem_pass");
		System.out.println(mem_email);
		System.out.println(mem_pass);
		System.out.println("성공쓰");
		
		MemberVO vo = new MemberVO();
		vo.setMem_email(mem_email);
		vo.setMem_pass(mem_pass);
		System.out.println(vo.getMem_email());
		
		IMemberService service = MemberServiceImpl.getInstance();
		
		MemberVO memberVo = service.getMember(vo);
		
		if(memberVo != null) {
			HttpSession session = request.getSession();
			session.setAttribute("memberVo", memberVo);

			response.sendRedirect("/Kream/member/main.jsp");
		}else {
			System.out.println("맴버가 널값이야!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
			response.sendRedirect("/Kream/member/loginForm.jsp");
		}
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
