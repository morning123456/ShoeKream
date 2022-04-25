package kr.or.ddit.kream.admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.kream.admin.service.AdminBoardServiceImpl;
import kr.or.ddit.kream.admin.service.IAdminBoardService;

/**
 * Servlet implementation class AdminDelete
 */
@WebServlet("/AdminDelete.do")
public class AdminDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mem_email = request.getParameter("mem_email");
		System.out.println(mem_email);
		IAdminBoardService service =  AdminBoardServiceImpl.getInstance();
		
		int res = service.deleteAdmin(mem_email);
		request.setAttribute("res", res);
		
		request.getRequestDispatcher("view/result.jsp").forward(request, response);
	}
}
