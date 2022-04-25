package kr.or.ddit.kream.board.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.kream.util.SqlMapClientFactory;
import kr.or.ddit.kream.vo.BoardQnAVo;
import kr.or.ddit.kream.vo.NoticeVo;

public class BoardQnADaoImpl implements IBoardQnADao{
	private SqlMapClient client;
	private static IBoardQnADao dao;
	
	//생성자 - client객체 얻어오기 
	private BoardQnADaoImpl() {
		client = SqlMapClientFactory.getSqlMapClient();
	}
	
	//getInstance()메소드 - dao객체생성하고 리턴 
	public  static IBoardQnADao getInstance() {
		if(dao == null) dao = new BoardQnADaoImpl();
		
		return  dao;
	}
	
	@Override
	public int totalCount() throws SQLException {
		// TODO Auto-generated method stub
		return (int)client.queryForObject("boardQnA.totalCount");
	}
	
	@Override
	public List<BoardQnAVo> boardSelectList(Map<String, Object> map) throws SQLException {
		// TODO Auto-generated method stub
		return  client.queryForList("boardQnA.boardSelectList", map);
	}

	@Override
	public List<NoticeVo> noticeSelectList() throws SQLException {
		// TODO Auto-generated method stub
		return client.queryForList("boardQnA.noticeSelectList");
	}

	@Override
	public BoardQnAVo qnaDetail(String board_id) throws SQLException {
		// TODO Auto-generated method stub
		return (BoardQnAVo)client.queryForObject("boardQnA.qnaDetail", board_id);
	}
	
	@Override
	public int qnaUpdate(BoardQnAVo vo) throws SQLException {
		// TODO Auto-generated method stub
		return client.update("boardQnA.qnaUpdate",vo);
	}
	
	
	@Override
	public int qnaInsert(BoardQnAVo vo) throws SQLException {
		Object obj = client.insert("boardQnA.qnaInsert", vo);
		if(obj == null) return 1;
		else return 0;	
	}

	@Override
	public int qnaDelete(String board_id) throws SQLException {
		// TODO Auto-generated method stub
		return client.delete("boardQnA.qnaDelete",board_id);
	}
	
	@Override
	public int qnaReplyDelete(String board_id) throws SQLException {
		// TODO Auto-generated method stub
		return client.delete("boardQnA.qnaReplyDelete",board_id);
	}
}
