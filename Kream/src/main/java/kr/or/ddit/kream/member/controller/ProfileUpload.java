package kr.or.ddit.kream.member.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import kr.or.ddit.kream.member.service.IMemberService;
import kr.or.ddit.kream.member.service.MemberServiceImpl;
import kr.or.ddit.kream.vo.FileInfoVO;
import kr.or.ddit.kream.vo.MemberVO;



@WebServlet("/ProfileUpload.do")
@MultipartConfig(
		fileSizeThreshold = 1024 * 1024 * 10,
		maxFileSize = 1024 * 1024 * 30,
		maxRequestSize = 1024 * 1024 * 50
)
public class ProfileUpload extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static String filePath = "";
	static String filename = "";

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		// 사용자가 업로드한 파일이 저장될 서버쪽의 폴더 경로 설정
		String uploadPath = "D:/A_TeachingMaterial/04_MiddelProject/workspace/Kream/src/main/webapp/img/profile";
		
		IMemberService service = MemberServiceImpl.getInstance();
		
		HttpSession session = request.getSession();
		
		MemberVO memberVo = (MemberVO)session.getAttribute("memberVo");
		
		String mem_email = memberVo.getMem_email();
	
		// 저장될 폴더가 없으면 생성한다.
		File fdir = new File(uploadPath);
		if(!fdir.exists()) {
			fdir.mkdirs();
		}
		
		// 파일이 아닌 일반 파라미터 데이터는 getParameter()메서드를
		// 이용해서 구한다.
		String userName = request.getParameter("username");
		System.out.println("일반 파라미터 데이터 : " + userName);
		
		String fileName = ""; // 파일명이 저장될 변수명
		
		// Upload한 파일 목록이 저장될 List 선언
		List<FileInfoVO> fileList = new ArrayList<FileInfoVO>();
		
		// 전체 Part객체 개수만큼 반복
		for(Part part : request.getParts()) {
			// 1개의 업로드 파일 정보를 구한다.
			fileName = extractFileName(part);
			
			// 파일명이 공백("")이면 이것은 일반 파라미터 데이터란 의미한다.
			if(!"".equals(fileName)) {
				FileInfoVO finfo = new FileInfoVO();
				finfo.setFileName(fileName);
				finfo.setFileSize((int)Math.ceil(part.getSize() / 1204.0));
				filename = finfo.getFileName();
				
				try {
					filePath = uploadPath + File.separator + fileName;
					
					System.out.println(filePath);
					part.write(filePath); // 파일성공
					finfo.setStatus("Success");
					
				} catch (IOException e) {
					finfo.setStatus("Fail : " + e.getMessage());
				}
				
				fileList.add(finfo); // 파일 정보를 List출력
			}
				
		}
		
		MemberVO vo = new MemberVO();
		vo.setMem_email(mem_email);
		vo.setMem_photo(fileName);
		
		int res = service.updateProfile(vo);
		
		response.sendRedirect("/Kream/member/my/myinfo/profile.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	private String extractFileName(Part part) {
		String fileName = "";
		
		String contentDisposition = part.getHeader("Content-Disposition");
		String[] items = contentDisposition.split(";");
		for(String item : items) {
			if(item.trim().startsWith("filename")) {
				fileName = item.substring(item.indexOf('=')+2, item.length()-1);
			}
		}
		
		return fileName;
	}

}
