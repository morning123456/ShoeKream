package kr.or.ddit.kream.admin.controller;

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
import kr.or.ddit.kream.vo.NoticeVo;


@WebServlet("/AdminNoticeInsert.do")
public class AdminNoticeInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		NoticeVo  vo = new NoticeVo();
		
//		try {
//			BeanUtils.populate(vo, request.getParameterMap());
//		} catch (IllegalAccessException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} catch (InvocationTargetException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		
		
		vo.setNotice_title(request.getParameter("notice_title"));
		vo.setNotice_content(request.getParameter("notice_content"));
		vo.setNotice_sta(request.getParameter("notice_sta"));
		vo.setNotice_cat(request.getParameter("notice_cat"));
		
		IAdminNoticeService  service = AdminNoticeServiceImpl.getInstance();
		
		System.out.println(vo.getNotice_cat());
		
		int res = service.noticeInsert(vo);
		System.out.println(res);
		request.setAttribute("res", res);
		
		request.getRequestDispatcher("view/result.jsp").forward(request, response);
	}

}
