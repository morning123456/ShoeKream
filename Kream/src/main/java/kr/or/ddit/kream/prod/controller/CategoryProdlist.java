package kr.or.ddit.kream.prod.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Array;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.or.ddit.kream.prod.service.IProdService;
import kr.or.ddit.kream.prod.service.ProdServiceImpl;
import kr.or.ddit.kream.vo.ProdDetailVo;

@WebServlet("/CategoryProdlist.do")
public class CategoryProdlist extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/*
	 * 메인 화면에서 카테고리 클릭시 넘어오는 서블릿 
	 */
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json; charset = utf-8");
		PrintWriter out = response.getWriter();
		
		String[] arr1 = request.getParameterValues("categoryChk1");
		String[] arr2 = request.getParameterValues("categoryChk2");
		
		HashMap<String, String> map = new HashMap<String, String>();
		
		if(arr1 != null) {
			for(int i = 0; i < arr1.length; i++) {
				String name = "litem" + String.valueOf(i+1);		
				map.put(name, arr1[i]);
			}
		}
		if(arr2 !=null) {
			for(int i = 0; i < arr2.length; i++) {
				String name = "bitem" + String.valueOf(i+1);
				map.put(name, arr2[i]);
			}
		}
		
		IProdService service = ProdServiceImpl.getInstance();
		
		List<ProdDetailVo> list = service.categoryProdList(map);
		
		System.out.println(list);

		Gson gson = new Gson();
		
		String data = gson.toJson(list);
		
		out.write(data);
		out.flush();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
