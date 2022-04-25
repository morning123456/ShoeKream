package kr.or.ddit.kream.admin.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.kream.vo.NoticeVo;

public interface IAdminNoticeDao {
	//리스트 출력 
	public List<NoticeVo> selectList(Map<String, Object> map) throws SQLException;
		  
	//전체 글갯수 가져오기 
	public int totalCount() throws SQLException;
	
	public NoticeVo noticeDetail(String notice) throws SQLException; 
	
	public int noticeUpdate(NoticeVo vo) throws SQLException;
	
	public int noticeDelete(String notice) throws SQLException;
	
	public int noticeInsert(NoticeVo vo) throws SQLException;
	
}
