package kr.or.ddit.kream.card.service;



import kr.or.ddit.kream.vo.CardVo;

public interface ICardService {
	public int insertCard(CardVo cardvo); //ī�� ���
	public String selectCard(String memId); //ī�� ���� �ҷ�����
	public int updateCard(CardVo cardvo);
}
