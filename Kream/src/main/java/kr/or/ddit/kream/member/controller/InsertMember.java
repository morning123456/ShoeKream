package kr.or.ddit.kream.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.kream.member.service.IMemberService;
import kr.or.ddit.kream.member.service.MemberServiceImpl;
import kr.or.ddit.kream.vo.MemberVO;

@WebServlet("/insertMember.do")
public class InsertMember extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		MemberVO vo = new MemberVO();
		vo.setMem_email(request.getParameter("mem_email"));
		vo.setMem_pass(request.getParameter("mem_pass"));
		vo.setMem_name(request.getParameter("mem_name"));
		
		IMemberService service = MemberServiceImpl.getInstance();
		
		int result = service.insertMember(vo);
		MemberVO memberVo = service.getMember(vo);
		
		if(result == 1 ) {
			response.sendRedirect("/Kream/member/loginForm.jsp");
		}else {
			response.sendRedirect("/Kream/member/joinMain.jsp?gubun=1");
		}
		
		
	}

}
