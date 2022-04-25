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


@WebServlet("/AdminNoticeUpdate.do")
public class AdminNoticeUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String notice = request.getParameter("notice");
		String notice_title = request.getParameter("notice_title");
		String notice_content = request.getParameter("notice_content");
		String notice_cat = request.getParameter("notice_cat");
		String notice_sta = request.getParameter("notice_sta");
		
		NoticeVo vo = new NoticeVo();
		vo.setNotice(notice);
		vo.setNotice_title(notice_title);
		vo.setNotice_content(notice_content);
		vo.setNotice_cat(notice_cat);
		vo.setNotice_sta(notice_sta);
		
		System.out.println(vo.getNotice()+"-------------------");
		
		IAdminNoticeService service = AdminNoticeServiceImpl.getInstance();
		
		int res = service.noticeUpdate(vo);
		
		request.setAttribute("res", res);
		request.getRequestDispatcher("view/result.jsp").forward(request, response);
		
	}

}
