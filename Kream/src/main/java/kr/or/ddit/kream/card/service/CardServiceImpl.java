package kr.or.ddit.kream.card.service;

import java.sql.SQLException;

import kr.or.ddit.kream.card.dao.CardDaoImpl;
import kr.or.ddit.kream.card.dao.ICardDao;
import kr.or.ddit.kream.vo.CardVo;

public class CardServiceImpl implements ICardService {

	private static ICardDao dao;
	private static ICardService service;
	
	public CardServiceImpl() {
		dao = CardDaoImpl.getInstance();
	}
	
	public static ICardService getInstance() {
		if(service == null) service = new CardServiceImpl();
		return service;
	}
	
	
	@Override
	public int insertCard(CardVo cardvo) {
		int cnt = 0;
		try {
			cnt = dao.insertCard(cardvo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return cnt;
	}

	@Override
	public String selectCard(String memId) {
		String card = null;
		try {
			card = dao.selectCard(memId);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return card;
	}

	@Override
	public int updateCard(CardVo cardvo) {
		int cnt=0;
		try {
			cnt = dao.updateCard(cardvo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return cnt;
	}

}
