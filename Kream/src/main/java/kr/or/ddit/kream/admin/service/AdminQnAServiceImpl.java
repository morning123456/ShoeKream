package kr.or.ddit.kream.admin.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.kream.admin.dao.AdminQnADaoImpl;
import kr.or.ddit.kream.admin.dao.IAdminQnADao;
import kr.or.ddit.kream.vo.BoardQnAVo;
import kr.or.ddit.kream.vo.BoardReplyVo;

public class AdminQnAServiceImpl implements IAdminQnAService{
	private IAdminQnADao  dao;
	private static IAdminQnAService service;
	
	//생성자  - dao객체 얻기 
	private AdminQnAServiceImpl() {
		dao = AdminQnADaoImpl.getInstance();
	}
	//getInstance()메소드 - dao객체생성하고 리턴 
	public  static IAdminQnAService getInstance() {
		if(service == null) service = new AdminQnAServiceImpl();
			
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
	public Map<String, Object> getPageInfo(int page,String type, String word) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		//한페이지당 출력할 글
		int perlist = 5;
		
		//한 화면에 츨력할 페이지 
		int perpage = 5;
		
		
		Map<String, String>  paramap = new HashMap<String, String>();
		paramap.put("stype" , type);
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
	public List<BoardQnAVo> selectList(Map<String, Object> map) {
		List<BoardQnAVo>  list = null;
	
		 try {
			list = dao.selectList(map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 
		return list;
	}
	@Override
	public List<BoardReplyVo> replyList(String board_id) {
		List<BoardReplyVo> list = null;
		
		 try {
			list = dao.replyList(board_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 
		return list;
	}
	@Override
	public int replyInsert(BoardReplyVo vo) {
		int res = 0;
		
		try {
			res = dao.replyInsert(vo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return res;
	}
	
	@Override
	public int replyUpdate(BoardReplyVo vo) {
		int  res = 0;
		
		try {
			res = dao.replyUpdate(vo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return res;
	}
	
	@Override
	public int replyDelete(String reply) {
		int res = 0;
		try {
			res = dao.replyDelete(reply);
		} catch (SQLException  e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return res;
	}
}
