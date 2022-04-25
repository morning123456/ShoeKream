package kr.or.ddit.kream.admin.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.kream.vo.BoardQnAVo;
import kr.or.ddit.kream.vo.BoardReplyVo;

public interface IAdminQnAService {
	//전체 글갯수 가져오기 
	public int totalCount();
				 
	//page정보 구하기 
	public Map<String , Object> getPageInfo(int page, String type, String word);
	
	public List<BoardQnAVo> selectList(Map<String, Object> map);
	
	public List<BoardReplyVo> replyList(String board_id);
	
	public int replyInsert(BoardReplyVo vo);
	
	public int replyUpdate(BoardReplyVo vo);
	
	public int replyDelete(String reply);
}
