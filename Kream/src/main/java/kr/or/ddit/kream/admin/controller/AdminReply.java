package kr.or.ddit.kream.admin.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.or.ddit.kream.admin.service.AdminQnAServiceImpl;
import kr.or.ddit.kream.admin.service.IAdminQnAService;
import kr.or.ddit.kream.vo.BoardReplyVo;


@WebServlet("/AdminReply.do")
public class AdminReply extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String board_id = request.getParameter("board_id");
		
		IAdminQnAService service = AdminQnAServiceImpl.getInstance();
		
		List<BoardReplyVo> list = service.replyList(board_id);
		
		Gson gson = new Gson();
		String result = gson.toJson(list);
		
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out =  response.getWriter();
		 
		out.print(result);
		out.flush();
	}

}
