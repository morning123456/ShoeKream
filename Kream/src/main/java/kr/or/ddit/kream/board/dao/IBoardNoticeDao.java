package kr.or.ddit.kream.board.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.kream.vo.NoticeVo;

public interface IBoardNoticeDao {
	public int totalCount() throws SQLException;
	
	public List<NoticeVo> selectList(Map<String, Object> map) throws SQLException;
}
