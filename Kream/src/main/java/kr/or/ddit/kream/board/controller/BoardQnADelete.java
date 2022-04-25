package kr.or.ddit.kream.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.kream.admin.service.AdminNoticeServiceImpl;
import kr.or.ddit.kream.admin.service.IAdminNoticeService;
import kr.or.ddit.kream.board.service.BoardQnAServiceImpl;
import kr.or.ddit.kream.board.service.IBoardQnAService;

@WebServlet("/BoardQnADelete.do")
public class BoardQnADelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String board_id = request.getParameter("board_id");
		
		IBoardQnAService service =  BoardQnAServiceImpl.getInstance();
		
		int res = service.qnaReplyDelete(board_id);
		service.qnaDelete(board_id);
		
		request.setAttribute("res", res);
		request.getRequestDispatcher("view/result.jsp").forward(request, response);
		
	}

}
