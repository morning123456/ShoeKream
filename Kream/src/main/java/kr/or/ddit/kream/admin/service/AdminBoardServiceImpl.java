package kr.or.ddit.kream.admin.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.kream.admin.dao.AdminBoardDaoImpl;
import kr.or.ddit.kream.admin.dao.IAdminBoardDao;
import kr.or.ddit.kream.vo.MemberVO;

public class AdminBoardServiceImpl implements IAdminBoardService{
	private IAdminBoardDao  dao;
	private static IAdminBoardService service;
	
	//생성자  - dao객체 얻기 
	private AdminBoardServiceImpl() {
		dao = AdminBoardDaoImpl.getInstance();
	}
	//getInstance()메소드 - dao객체생성하고 리턴 
	public  static IAdminBoardService getInstance() {
		if(service == null) service = new AdminBoardServiceImpl();
			
		return  service;
	}
	@Override
	public int totalCount() {
		int  count = 0;
		
		try {
			count = dao.totalCount();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return count;
	}


	@Override
	public Map<String, Object> getPageInfo(int page, String type, String word) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		//한페이지당 출력할 글
		int perlist = 10;
		
		//한 화면에 츨력할 페이지 
		int perpage = 5;
		
		
		Map<String, String>  paramap = new HashMap<String, String>();
		paramap.put("stype", type);
		paramap.put("sword", word);
		
				
		//전체 글
		int count = this.totalCount();
		
		//전체페이지
		int  totalPage =(int)Math.ceil((double)count /  perlist);
		
		//start  //end 
		int start = (page -1) * perlist + 1;
		int end = start + perlist - 1;
		if(end > count) end = count;
		
			
		//startPage, endPage구하기 
		int startPage = ((page -1) / perpage * perpage ) + 1;
		int endPage = startPage + perpage -1;
		
		if(endPage > totalPage ) endPage = totalPage ;
		
		map.put("start", start);
		map.put("end", end);
		map.put("startpage", startPage);
		map.put("endpage", endPage);
		map.put("totalpage", totalPage);
				
		return map;
	}
	@Override
	public List<MemberVO> selectList(Map<String, Object> map) {
		List<MemberVO>  list = null;
	
		 try {
			list = dao.selectList(map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 
		return list;
	}
	@Override
	public int insertAdmin(MemberVO vo) {
		int res=0;
		try {
			res = dao.insertAdmin(vo);
		} catch (SQLException e) {
			// TODO: handle exception
		}
		return res;
	}
	@Override
	public int updateAdmin(MemberVO vo) {
		int  res = 0;
		
		try {
			res = dao.updateAdmin(vo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(res);
		return res;
	}
	@Override
	public int deleteAdmin(String id) {
		int  res = 0;
		
		try {
			res = dao.deleteAdmin(id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return res;
	}

	
	

	
}
