package kr.or.ddit.kream.board.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.kream.util.SqlMapClientFactory;
import kr.or.ddit.kream.vo.NoticeVo;

public class BoardNoticeDaoImpl implements IBoardNoticeDao{
	private SqlMapClient  client ;
	private static IBoardNoticeDao dao;
	
	//생성자 - client객체 얻어오기 
	private BoardNoticeDaoImpl() {
		client = SqlMapClientFactory.getSqlMapClient();
	}
	
	//getInstance()메소드 - dao객체생성하고 리턴 
	public  static IBoardNoticeDao getInstance() {
		if(dao == null) dao = new BoardNoticeDaoImpl();
		
		return  dao;
	}
	
	@Override
	public int totalCount() throws SQLException {
		// TODO Auto-generated method stub
		return (int)client.queryForObject("boardNotice.totalCount");
	}
	
	@Override
	public List<NoticeVo> selectList(Map<String, Object> map) throws SQLException {
		// TODO Auto-generated method stub
		return  client.queryForList("boardNotice.selectList", map);
	}
}
