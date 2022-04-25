package kr.or.ddit.kream.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import kr.or.ddit.kream.member.service.IMemberService;
import kr.or.ddit.kream.member.service.MemberServiceImpl;
import kr.or.ddit.kream.vo.MemberVO;
import kr.or.ddit.kream.vo.MyBuyingListVO;

@WebServlet("/buyingListSearch.do")
public class BuyingListSearch extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		HttpSession sessoin = request.getSession();
		
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		String sort = request.getParameter("sort");
		
		System.out.println(start);
		System.out.println(end);
		System.out.println(sort);
		
		MemberVO memberVo = (MemberVO)sessoin.getAttribute("memberVo");
		
		Map<String, String> paramap1 = new HashMap<String, String>();
		paramap1.put("mem_email", memberVo.getMem_email());
		paramap1.put("start", start);
		paramap1.put("end", end);
		paramap1.put("sort", sort);
		paramap1.put("bid_position", "buyer");
		
		
		IMemberService service = MemberServiceImpl.getInstance();
		
		List<MyBuyingListVO> buylist = service.searchbuyList(paramap1);
		
		Gson gson = new Gson();
		
		String result = gson.toJson(buylist);
		
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
