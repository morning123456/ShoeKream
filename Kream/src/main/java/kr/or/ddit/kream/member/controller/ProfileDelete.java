package kr.or.ddit.kream.member.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

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

@WebServlet("/ProfileDelete.do")
public class ProfileDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		// 사용자가 업로드한 파일이 저장될 서버쪽의 폴더 경로 설정
		String uploadPath = "D:/A_TeachingMaterial/04_MiddelProject/workspace/Kream/src/main/webapp/img/profile";
		
		IMemberService service = MemberServiceImpl.getInstance();
		
		HttpSession session = request.getSession();
		
		MemberVO memberVo = (MemberVO)session.getAttribute("memberVo");
		
		String mem_email = memberVo.getMem_email();
		
		File file = new File(uploadPath + File.separator + memberVo.getMem_photo()); 
		if( file.exists() ){ 
			if(file.delete()){ 
				System.out.println("파일삭제 성공"); 
			}else{ 
				System.out.println("파일삭제 실패");
			} 
			
		}else{ 
			System.out.println("파일이 존재하지 않습니다."); 
		}
		
		MemberVO vo = new MemberVO();
		vo.setMem_email(mem_email);
		vo.setMem_photo("mem_profile_icon.png");
		
		int res = service.updateProfile(vo);
		
		Gson gson = new Gson();
		
		String result = gson.toJson(res);
		
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
