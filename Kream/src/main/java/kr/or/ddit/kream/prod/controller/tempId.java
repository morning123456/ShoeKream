package kr.or.ddit.kream.prod.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/tempId.do")
public class tempId extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		String prodid = request.getParameter("prodid");
		String gubun = request.getParameter("gubun");
		
		if(gubun.equals("1")) {
			request.setAttribute("prodid", prodid);
			request.getRequestDispatcher("/prodview/prodDetail.jsp").forward(request, response);
		}else if (gubun.equals("2")) {
			request.setAttribute("prodid", prodid);
			request.getRequestDispatcher("/bid/buy.jsp").forward(request, response);
		}else if (gubun.equals("3")) {
			request.setAttribute("prodid", prodid);
			request.getRequestDispatcher("/bid/sell.jsp").forward(request, response);
		}else if (gubun.equals("4")) {
			request.setAttribute("prodid", prodid);
			request.getRequestDispatcher("/member/loginForm.jsp").forward(request, response);
		}
		
		
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
