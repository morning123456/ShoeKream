package kr.or.ddit.kream.board.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.kream.vo.NoticeVo;

public interface IBoardNoticeService {
	//전체 글갯수 가져오기 
	public int totalCount();
				 
	//page정보 구하기 
	public Map<String , Object> getPageInfo(int page, String word);

	public List<NoticeVo> selectList(Map<String, Object> map);
}
