package kr.or.ddit.kream.admin.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.kream.vo.BoardQnAVo;
import kr.or.ddit.kream.vo.BoardReplyVo;

public interface IAdminQnADao {
	//리스트 출력 
	public List<BoardQnAVo> selectList(Map<String, Object> map) throws SQLException;
			  
	//전체 글갯수 가져오기 
	public int totalCount() throws SQLException;
	
	public List<BoardReplyVo> replyList(String board_id) throws SQLException;
	
	public int replyInsert(BoardReplyVo vo) throws SQLException;
	
	public int replyUpdate(BoardReplyVo vo) throws SQLException;
	
	public int replyDelete(String reply) throws SQLException;
}
