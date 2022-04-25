package kr.or.ddit.kream.board.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import kr.or.ddit.kream.admin.service.AdminNoticeServiceImpl;
import kr.or.ddit.kream.admin.service.IAdminNoticeService;
import kr.or.ddit.kream.board.service.BoardQnAServiceImpl;
import kr.or.ddit.kream.board.service.IBoardQnAService;
import kr.or.ddit.kream.vo.BoardQnAVo;
import kr.or.ddit.kream.vo.NoticeVo;


@WebServlet("/BoardQnAInsert.do")
public class BoardQnAInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		BoardQnAVo  vo = new BoardQnAVo();
		
		try {
			BeanUtils.populate(vo, request.getParameterMap());
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		IBoardQnAService  service = BoardQnAServiceImpl.getInstance();
		
		int res = service.qnaInsert(vo);
		request.setAttribute("res", res);
		
		request.getRequestDispatcher("view/result.jsp").forward(request, response);
	}

}
