package kr.or.ddit.kream.admin.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import kr.or.ddit.kream.admin.service.AdminQnAServiceImpl;
import kr.or.ddit.kream.admin.service.IAdminQnAService;
import kr.or.ddit.kream.vo.BoardReplyVo;

@WebServlet("/AdminReplyInsert.do")
public class AdminReplyInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		BoardReplyVo  vo = new BoardReplyVo();
		
		vo.setBoard_id(request.getParameter("board_id"));
		vo.setRep_content(request.getParameter("rep_content"));
		
		vo.toString();
		
		IAdminQnAService  service = AdminQnAServiceImpl.getInstance();
		
		int res = service.replyInsert(vo);
		
		request.setAttribute("res", res);
		
		request.getRequestDispatcher("view/result.jsp").forward(request, response);
		
	}

}
