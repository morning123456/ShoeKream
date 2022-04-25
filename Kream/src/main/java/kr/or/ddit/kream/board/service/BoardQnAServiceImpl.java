package kr.or.ddit.kream.board.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.kream.board.dao.BoardQnADaoImpl;
import kr.or.ddit.kream.board.dao.IBoardQnADao;
import kr.or.ddit.kream.vo.BoardQnAVo;
import kr.or.ddit.kream.vo.NoticeVo;

public class BoardQnAServiceImpl implements IBoardQnAService {
	private IBoardQnADao dao;
	private static IBoardQnAService service;
	
	private BoardQnAServiceImpl() {
		dao = BoardQnADaoImpl.getInstance();
	}

	public static IBoardQnAService getInstance() {
		if(service == null) service = new BoardQnAServiceImpl();
		return service;
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
	public Map<String, Object> getPageInfo(int page, String type, String word) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		//한페이지당 출력할 글
		int perlist = 4;
		
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
	public List<BoardQnAVo> boardSelectList(Map<String, Object> map) {
		List<BoardQnAVo>  list = null;
	
		 try {
			list = dao.boardSelectList(map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 
		return list;
	}

	@Override
	public List<NoticeVo> noticeSelectList() {
		List<NoticeVo>  list = null;
		
		 try {
			list = dao.noticeSelectList();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 
		return list;
	}

	@Override
	public BoardQnAVo qnaDetail(String board_id) {
		BoardQnAVo vo = null;
		
		try {
			vo = dao.qnaDetail(board_id);
		} catch (SQLException e) {
			// TODO: handle exception
		}
		
		return vo;
	}
	
	@Override
	public int qnaUpdate(BoardQnAVo vo) {
		int res = 0;
		try {
			res = dao.qnaUpdate(vo);
		} catch (SQLException  e) {
			// TODO: handle exception
		}
		return res;
	}

	@Override
	public int qnaInsert(BoardQnAVo vo) {
		int res = 0;
		try {
			res = dao.qnaInsert(vo);
		} catch (SQLException  e) {
			// TODO: handle exception
		}
		return res;
	}

	@Override
	public int qnaDelete(String board_id) {
		int res = 0;
		try {
			res = dao.qnaDelete(board_id);
		} catch (SQLException  e) {
			// TODO: handle exception
		}
		return res;
	}

	@Override
	public int qnaReplyDelete(String board_id) {
		int res = 0;
		try {
			res = dao.qnaReplyDelete(board_id);
		} catch (SQLException  e) {
			// TODO: handle exception
		}
		return res;
	}
	
}
