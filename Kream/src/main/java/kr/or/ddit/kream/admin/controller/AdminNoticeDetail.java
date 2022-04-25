package kr.or.ddit.kream.admin.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.or.ddit.kream.admin.service.AdminNoticeServiceImpl;
import kr.or.ddit.kream.admin.service.IAdminNoticeService;
import kr.or.ddit.kream.vo.NoticeVo;


@WebServlet("/AdminNoticeDetail.do")
public class AdminNoticeDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String notice = request.getParameter("notice");
		
		IAdminNoticeService service = AdminNoticeServiceImpl.getInstance();
		
		NoticeVo vo =  service.noticeDetail(notice);
		
		Gson gson = new Gson();
		String result = gson.toJson(vo);
		
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out =  response.getWriter();
		 
		out.print(result);
		out.flush();
	}
}
