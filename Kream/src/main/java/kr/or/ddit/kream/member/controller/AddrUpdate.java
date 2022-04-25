package kr.or.ddit.kream.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;

import com.google.gson.Gson;

import kr.or.ddit.kream.member.service.IMemberService;
import kr.or.ddit.kream.member.service.MemberServiceImpl;
import kr.or.ddit.kream.vo.AddressVo;
import kr.or.ddit.kream.vo.MemberVO;

@WebServlet("/addrUpdate.do")
public class AddrUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		
		MemberVO memberVo = (MemberVO)session.getAttribute("memberVo");
		
		AddressVo addressVo = new AddressVo();
		
		try {
			BeanUtils.populate(addressVo, request.getParameterMap());
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		addressVo.setMem_email(memberVo.getMem_email());
		
		System.out.println(addressVo.getAddr2());
		System.out.println(addressVo.getAddr1());
		System.out.println(addressVo.getMem_email());
		System.out.println(addressVo.getName());
		System.out.println(addressVo.getPhone_num());
		System.out.println(addressVo.getZip_code());
		
		IMemberService service = MemberServiceImpl.getInstance();
		
		int res = service.updateaddr(addressVo);
		
		Gson gson = new Gson();
		
		String result = gson.toJson(addressVo);
		
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		out.print(result);
		out.flush();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
