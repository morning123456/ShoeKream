package kr.or.ddit.kream.card.dao;

import java.sql.SQLException;

import kr.or.ddit.kream.vo.CardVo;

public interface ICardDao {
	public int insertCard(CardVo cardvo) throws SQLException; //ī�� ���
	public String selectCard(String memId)throws SQLException; //ī�� ���� �ҷ�����
	public int updateCard(CardVo cardvo) throws SQLException;
}
