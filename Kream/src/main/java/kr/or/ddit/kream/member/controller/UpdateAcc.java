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

@WebServlet("/updateAcc.do")
public class UpdateAcc extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String mem_email = request.getParameter("mem_email");
		
		MemberVO memberVo = new MemberVO();
		memberVo.setMem_email(mem_email);
		memberVo.setMem_acc(request.getParameter("mem_acc"));
		memberVo.setMem_bank(request.getParameter("mem_bank"));
		
		IMemberService service = MemberServiceImpl.getInstance();
		
		int res = service.updateAcc(memberVo);
		
		Gson gson = new Gson();
		
		String result = gson.toJson(res);
		
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
