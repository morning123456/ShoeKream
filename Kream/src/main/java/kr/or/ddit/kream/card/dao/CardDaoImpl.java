package kr.or.ddit.kream.card.dao;

import java.sql.SQLException;

import com.ibatis.sqlmap.client.SqlMapClient;
import kr.or.ddit.kream.util.SqlMapClientFactory;
import kr.or.ddit.kream.vo.CardVo;

public class CardDaoImpl implements ICardDao {
	private SqlMapClient smc;
	private static ICardDao dao;
	
	public CardDaoImpl() {
		smc = SqlMapClientFactory.getSqlMapClient();
	}
	
	public static ICardDao getInstance() {
		if(dao == null) dao = new CardDaoImpl();
		return dao;
	}
	
	
	
	@Override
	public int insertCard(CardVo cardvo) throws SQLException {
		int cnt=0;
		Object obj = smc.insert("card.insertCard",cardvo);
		if(obj==null) cnt = 1;
		return cnt;
	}

	@Override
	public String selectCard(String memId) throws SQLException {
		// TODO Auto-generated method stub
		return (String) smc.queryForObject("card.selectCard",memId);
	}

	@Override
	public int updateCard(CardVo cardvo) throws SQLException {
		// TODO Auto-generated method stub
		return smc.update("card.updateCard",cardvo);
	}

}
