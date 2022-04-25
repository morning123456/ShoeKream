package kr.or.ddit.kream.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import kr.or.ddit.kream.member.service.IMemberService;
import kr.or.ddit.kream.member.service.MemberServiceImpl;
import kr.or.ddit.kream.vo.MemberVO;


@WebServlet("/memberUpdate.do")
public class MemberUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		IMemberService service = MemberServiceImpl.getInstance();
		
		HttpSession session = request.getSession();
		
		MemberVO memberVo = (MemberVO) session.getAttribute("memberVo");
		
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("para", request.getParameter("para"));
		paramap.put("value", request.getParameter("value"));
		paramap.put("mem_email", memberVo.getMem_email());
		
		int res = service.updateMember(paramap);
		
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
