package kr.or.ddit.kream.admin.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.kream.admin.dao.AdminNoticeDaoImpl;
import kr.or.ddit.kream.admin.dao.IAdminNoticeDao;
import kr.or.ddit.kream.vo.NoticeVo;

public class AdminNoticeServiceImpl implements IAdminNoticeService{
	private IAdminNoticeDao  dao;
	private static IAdminNoticeService service;
	
	//생성자  - dao객체 얻기 
	private AdminNoticeServiceImpl() {
		dao = AdminNoticeDaoImpl.getInstance();
	}
	//getInstance()메소드 - dao객체생성하고 리턴 
	public  static IAdminNoticeService getInstance() {
		if(service == null) service = new AdminNoticeServiceImpl();
			
		return  service;
	}
	
	@Override
	public int totalCount() {
		int  count = 0;
		System.out.println(count);
		try {
			count = dao.totalCount();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return count;
	}


	@Override
	public Map<String, Object> getPageInfo(int page, String word) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		//한페이지당 출력할 글
		int perlist = 5;
		
		//한 화면에 츨력할 페이지 
		int perpage = 5;
		
		
		Map<String, String>  paramap = new HashMap<String, String>();
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
	public List<NoticeVo> selectList(Map<String, Object> map) {
		List<NoticeVo>  list = null;
	
		 try {
			list = dao.selectList(map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 
		return list;
	}
	@Override
	public NoticeVo noticeDetail(String notice) {
		NoticeVo vo = null;
		try {
			vo = dao.noticeDetail(notice);
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return vo;
	}
	@Override
	public int noticeUpdate(NoticeVo vo) {
		int res = 0;
		try {
			res = dao.noticeUpdate(vo);
		} catch (SQLException  e) {
			// TODO: handle exception
		}
		return res;
	}
	@Override
	public int noticeDelete(String notice) {
		int res = 0;
		try {
			res = dao.noticeDelete(notice);
		} catch (SQLException  e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return res;
	}
	@Override
	public int noticeInsert(NoticeVo vo) {
		int res = 0;
		try {
			res = dao.noticeInsert(vo);
		} catch (SQLException  e) {
			e.printStackTrace();
		}
		return res;
	}
}
