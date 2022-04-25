package kr.or.ddit.kream.prod.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.or.ddit.kream.prod.service.IProdService;
import kr.or.ddit.kream.prod.service.ProdServiceImpl;
import kr.or.ddit.kream.vo.LikeProdVo;

@WebServlet("/prodLikeUpdate.do")
public class prodLikeUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
/*
 * 관심상품을 클릭하면 관심상품 테이블에 update 되는 메서드 
 * 
 * 
*/	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		
		//prodDetail.jsp에서 get방식으로 보낸 prodid를 받는다
		String prodid = request.getParameter("prodid");
		String memid = request.getParameter("memid");
		System.out.println("파라미터로 받은 prodid : " + prodid);
		System.out.println("파라미터로 받은 memid : " + memid);
		
		int suc = 0;//insert
		int del = 0;//delete
		String res = null;

		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		if(memid != null) {
			LikeProdVo vo = new LikeProdVo();
			
			vo.setMem_email(memid);
			vo.setProd_id(prodid);
			
			
			IProdService service = ProdServiceImpl.getInstance();
			
			int chk = service.checkLikeProd(vo);//중복체크

			
			if(chk == 0) {
				System.out.println("중복없음");
				suc = service.prodLikeInsert(vo);
				if(suc > 0) {
					System.out.println("관심상품 등록 성공!!");//체크용
					res = "성공";
				}else {
					System.out.println("관심상품에 등록에 실패했습니다.");
				}
			}else if(chk > 0){
				//delete
				System.out.println("중복");
				del = service.deleteLikeProd(vo);
				if(del>0) {//delete성공
					System.out.println("삭제성공");
					res = "삭제";
				}else {
					System.out.println("삭제실패");
				}
			}

			Gson gson = new Gson();
			
			res = gson.toJson(res);
		}
				
		out.write(res);
		out.flush();
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
