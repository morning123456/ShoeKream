package kr.or.ddit.kream.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.ddit.kream.member.service.IMemberService;
import kr.or.ddit.kream.member.service.MemberServiceImpl;
import kr.or.ddit.kream.vo.MemberVO;
import kr.or.ddit.kream.vo.MyBuyingListVO;

@WebServlet("/MyPage.do")
public class MyPage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		HttpSession sessoin = request.getSession();
		
		MemberVO memberVo = (MemberVO)sessoin.getAttribute("memberVo");
		
		System.out.println(memberVo.getMem_email());
		Map<String, String> paramap1 = new HashMap<String, String>();
		paramap1.put("mem_email", memberVo.getMem_email());
		paramap1.put("bid_position", "buyer");
		
		Map<String, String> paramap2 = new HashMap<String, String>();
		paramap2.put("mem_email", memberVo.getMem_email());
		paramap2.put("bid_position", "seller");
		
		
		IMemberService service = MemberServiceImpl.getInstance();
		
		List<MyBuyingListVO> buylist = service.getBidList(paramap1);
		List<MyBuyingListVO> selllist = service.getBidList(paramap2);
		Map<String, Integer> countMap = service.getBuySellCount(memberVo.getMem_email());
		
		System.out.println(countMap.get("BUYERALL"));
		
		
		if(buylist == null || buylist.size() == 0) {
			System.out.println("nulllllllllllllllllllllllllllllllllllllllllllllllllllllll");
			request.setAttribute("noList1", "기록없음");
		}else {
			for(MyBuyingListVO vo : buylist) {
				System.out.println(vo.getPhoto_path());
			}
			
			request.setAttribute("BuyingList", buylist);
		}
		
		if(selllist == null || selllist.size() == 0) {
			System.out.println("nulllllllllllllllllllllllllllllllllllllllllllllllllllllll");
			request.setAttribute("noList2", "기록없음");
		}else {
			for(MyBuyingListVO vo : selllist) {
				System.out.println(vo.getPhoto_path());
			}
			
			request.setAttribute("SellingList", selllist);
		}
		
		request.setAttribute("countMap", countMap);
		request.getRequestDispatcher("/member/my/myPage.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
