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
import kr.or.ddit.kream.vo.BoardQnAVo;
import kr.or.ddit.kream.vo.NoticeVo;

@WebServlet("/BoardQnAUpdate.do")
public class BoardQnAUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String board_id = request.getParameter("board_id");
		String board_title = request.getParameter("board_title");
		String board_content = request.getParameter("board_content");
		
		BoardQnAVo vo = new BoardQnAVo();
		vo.setBoard_id(board_id);
		vo.setBoard_title(board_title);
		vo.setBoard_content(board_content);
		
		IBoardQnAService service = BoardQnAServiceImpl.getInstance();
		
		int res = service.qnaUpdate(vo);
		
		request.setAttribute("res", res);
		request.getRequestDispatcher("view/result.jsp").forward(request, response);
	}

}
