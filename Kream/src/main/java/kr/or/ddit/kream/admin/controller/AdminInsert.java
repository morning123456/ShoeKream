package kr.or.ddit.kream.admin.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import kr.or.ddit.kream.admin.service.AdminBoardServiceImpl;
import kr.or.ddit.kream.admin.service.IAdminBoardService;
import kr.or.ddit.kream.vo.MemberVO;

@WebServlet("/AdminInsert.do")
public class AdminInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		MemberVO vo = new MemberVO();
		
		try {
			BeanUtils.populate(vo, request.getParameterMap());
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//System.out.println(vo.getMem_email());
		
		IAdminBoardService service = AdminBoardServiceImpl.getInstance();
		
		int res = service.insertAdmin(vo);
		
		System.out.println(res);
		request.setAttribute("res", res);
		
		
		request.getRequestDispatcher("view/result.jsp")
		          .forward(request, response);
		
	}

}
