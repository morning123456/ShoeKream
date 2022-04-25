package kr.or.ddit.kream.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import com.google.gson.Gson;

import kr.or.ddit.kream.member.service.IMemberService;
import kr.or.ddit.kream.member.service.MemberServiceImpl;
import kr.or.ddit.kream.vo.MemberVO;


@WebServlet("/insertSnsMember.do")
public class InsertSnsMember extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		IMemberService service = MemberServiceImpl.getInstance();
		String email = request.getParameter("email");
		System.out.println(email);
		MemberVO vo = new MemberVO();
		MemberVO vochk = new MemberVO();
		
		try {
			BeanUtils.populate(vo, request.getParameterMap());
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		vo.setMem_sns(email);
		
		System.out.println(vo.getMem_sns());
		System.out.println(vo.getMem_pass());
		System.out.println(vo.getMem_email());
		
		vochk.setMem_email(vo.getMem_email());
		
		MemberVO memberVo = service.getMember(vochk);
		
		int result = 0;
		
		if(memberVo == null) { // 중복된 정보가 없으면 insert진행
			result = service.insertMember(vo); 
		}else {  // 중복된 정보가 있으면 0값 반환
			result = 0;
		}
		
		Gson gson = new Gson();
		
		String res = gson.toJson(result);
		
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		out.print(res);
		out.flush();

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
