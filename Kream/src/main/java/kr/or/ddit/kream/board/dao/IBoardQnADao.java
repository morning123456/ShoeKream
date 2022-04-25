package kr.or.ddit.kream.board.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.kream.vo.BoardQnAVo;
import kr.or.ddit.kream.vo.NoticeVo;

public interface IBoardQnADao {
	//리스트 출력 
	public List<BoardQnAVo> boardSelectList(Map<String, Object> map) throws SQLException;
			  
	public List<NoticeVo> noticeSelectList() throws SQLException;
	
	//전체 글갯수 가져오기 
	public int totalCount() throws SQLException;
	
	
	public BoardQnAVo qnaDetail(String board_id) throws SQLException;

	public int qnaUpdate(BoardQnAVo vo) throws SQLException; 
	
	public int qnaInsert(BoardQnAVo vo) throws SQLException; 
	
	public int qnaDelete(String board_id) throws SQLException; 
	
	public int qnaReplyDelete(String board_id) throws SQLException; 
}
