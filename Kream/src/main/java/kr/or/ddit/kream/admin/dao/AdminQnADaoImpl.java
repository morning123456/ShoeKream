package kr.or.ddit.kream.admin.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.kream.util.SqlMapClientFactory;
import kr.or.ddit.kream.vo.BoardQnAVo;
import kr.or.ddit.kream.vo.BoardReplyVo;

public class AdminQnADaoImpl implements IAdminQnADao{
	private SqlMapClient client;
	private static IAdminQnADao dao;
	
	//생성자 - client객체 얻어오기 
	private AdminQnADaoImpl() {
		client = SqlMapClientFactory.getSqlMapClient();
	}
	
	//getInstance()메소드 - dao객체생성하고 리턴 
	public  static IAdminQnADao getInstance() {
		if(dao == null) dao = new AdminQnADaoImpl();
		
		return  dao;
	}
	
	@Override
	public int totalCount() throws SQLException {
		// TODO Auto-generated method stub
		return (int)client.queryForObject("adminQnA.totalCount");
	}
	
	@Override
	public List<BoardQnAVo> selectList(Map<String, Object> map) throws SQLException {
		// TODO Auto-generated method stub
		return  client.queryForList("adminQnA.selectList", map);
	}

	@Override
	public List<BoardReplyVo> replyList(String board_id) throws SQLException {
		// TODO Auto-generated method stub
		return client.queryForList("adminQnA.replyList", board_id);
	}

	@Override
	public int replyInsert(BoardReplyVo vo) throws SQLException {
		Object obj = client.insert("adminQnA.replyInsert", vo);
		if(obj == null) return 1;
		else return 0;
	}
	
	
	@Override
	public int replyUpdate(BoardReplyVo vo) throws SQLException {
		// TODO Auto-generated method stub
		return client.update("adminQnA.replyUpdate", vo);
	}
	
	@Override
	public int replyDelete(String reply) throws SQLException {
		// TODO Auto-generated method stub
		return client.delete("adminQnA.replyDelete", reply);
	}

	
	
}
