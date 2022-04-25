package kr.or.ddit.kream.admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.kream.admin.service.AdminBoardServiceImpl;
import kr.or.ddit.kream.admin.service.IAdminBoardService;
import kr.or.ddit.kream.vo.MemberVO;
import oracle.net.aso.s;

@WebServlet("/AdminUpdate.do")
public class AdminUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String mem_email = request.getParameter("mem_email");
		String mem_pass = request.getParameter("mem_pass");
		String mem_name = request.getParameter("mem_name");
		
		MemberVO vo = new MemberVO();
		vo.setMem_email(mem_email);
		vo.setMem_pass(mem_pass);
		vo.setMem_name(mem_name);
		
		IAdminBoardService service = AdminBoardServiceImpl.getInstance();
		
		int res = service.updateAdmin(vo);
		
		request.setAttribute("res", res);
		request.getRequestDispatcher("view/result.jsp").forward(request, response);
		
	}

}
