package kr.or.ddit.kream.admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.kream.admin.service.AdminQnAServiceImpl;
import kr.or.ddit.kream.admin.service.IAdminQnAService;

@WebServlet("/AdminReplyDelete.do")
public class AdminReplyDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String board_reply_id = request.getParameter("board_reply_id");
		
		IAdminQnAService service =  AdminQnAServiceImpl.getInstance();
		
		int res = service.replyDelete(board_reply_id);
		System.out.println(res);
		request.setAttribute("res", res);
		
		request.getRequestDispatcher("view/result.jsp").forward(request, response);
	
	}

}
