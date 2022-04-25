package kr.or.ddit.kream.admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.kream.admin.service.AdminNoticeServiceImpl;
import kr.or.ddit.kream.admin.service.IAdminNoticeService;

@WebServlet("/AdminNoticeDelete.do")
public class AdminNoticeDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String notice = request.getParameter("notice");
		
		System.out.println(notice+"/AdminNoticeDelete.do");
		IAdminNoticeService service =  AdminNoticeServiceImpl.getInstance();
		
		int res = service.noticeDelete(notice);
		
		
	}

}
