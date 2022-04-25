package kr.or.ddit.kream.admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.kream.admin.service.AdminQnAServiceImpl;
import kr.or.ddit.kream.admin.service.IAdminQnAService;
import kr.or.ddit.kream.vo.BoardReplyVo;

@WebServlet("/AdminReplyUpdate.do")
public class AdminReplyUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String board_id = request.getParameter("board_id");
		String rep_content = request.getParameter("rep_content");
		String board_reply_id = request.getParameter("board_reply_id");
		
		BoardReplyVo vo = new BoardReplyVo();
		vo.setBoard_id(board_id);
		vo.setRep_content(rep_content);
		vo.setBoard_reply_id(board_reply_id);
		
		IAdminQnAService service = AdminQnAServiceImpl.getInstance();
		
		int res = service.replyUpdate(vo);
		
		request.setAttribute("res", res);
		request.getRequestDispatcher("view/result.jsp").forward(request, response);
	}

}
