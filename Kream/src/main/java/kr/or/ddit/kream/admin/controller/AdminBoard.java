package kr.or.ddit.kream.admin.controller;

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

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import kr.or.ddit.kream.admin.service.AdminBoardServiceImpl;
import kr.or.ddit.kream.admin.service.IAdminBoardService;
import kr.or.ddit.kream.vo.MemberVO;

/**
 * Servlet implementation class AdminBoard
 */
@WebServlet("/AdminBoard.do")
public class AdminBoard extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		// 1. 요청시 전송데이터 받기- page번호 , stype(option), sword(검색창에 입력한 text)
		int rqpage = Integer.parseInt(request.getParameter("page")); //currentPage :1
		String rqtype = request.getParameter("stype"); //typevalue = ""
		String rqword = request.getParameter("sword");//wordvalue = ""

		System.out.println("page ===" + rqpage);
		System.out.println("rqtype==" + rqtype);
		System.out.println("rqword==" + rqword);

		// 2. service객체 얻기
		IAdminBoardService service = AdminBoardServiceImpl.getInstance();

		// page관련 작업- 전체 글갯수 , 총페이지수
		// 한페이지당 출력할 글갯수 , 한 화면 에 출력할 페이지갯수

		Map<String, Object> pmap = service.getPageInfo(rqpage, rqtype, rqword);
		// pmap : start, end, wesdfsdwa, sdsdffsd,dfsdfdpage,

		// paramete Map생성 - selectList 수행 하기위해서
		Map<String, Object> map = new HashMap<String, Object>();

		int startval = (int) pmap.get("start");
		int endval = (int) pmap.get("end");

		map.put("start", startval);
		map.put("end", endval);
		map.put("stype", rqtype);
		map.put("sword", rqword);

		// 3. service메소드 호출 하기 - 결과값 받기
		List<MemberVO> list = service.selectList(map);

		// 4. 결과값으로 응답데이타 생성 - html, text, xml ,json 데이타

		JsonObject obj = new JsonObject();

		obj.addProperty("totalp", (Integer) pmap.get("totalpage"));
		obj.addProperty("startp", (Integer) pmap.get("startpage"));
		obj.addProperty("endp", (Integer) pmap.get("endpage"));

		Gson gson = new Gson();

		JsonElement ele = gson.toJsonTree(list);

		obj.add("datas", ele);

		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();

		out.print(obj);
		out.flush();
	}

}
