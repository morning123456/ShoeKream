package kr.or.ddit.kream.board.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.kream.vo.BoardQnAVo;
import kr.or.ddit.kream.vo.NoticeVo;

public interface IBoardQnAService {
	//전체 글갯수 가져오기 
	public int totalCount();
				 
	//page정보 구하기 
	public Map<String , Object> getPageInfo(int page, String type, String word);

	public List<BoardQnAVo> boardSelectList(Map<String, Object> map);
	
	public List<NoticeVo> noticeSelectList();
	
	public BoardQnAVo qnaDetail(String board_id);

	public int qnaUpdate(BoardQnAVo vo);
	
	public int qnaInsert(BoardQnAVo vo);
	
	public int qnaDelete(String vo);
	
	public int qnaReplyDelete(String vo);
}
