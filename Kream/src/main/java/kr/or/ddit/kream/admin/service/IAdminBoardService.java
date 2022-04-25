package kr.or.ddit.kream.admin.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.kream.vo.MemberVO;

public interface IAdminBoardService {
	//전체 글갯수 가져오기 
	public int totalCount();
		 
	//page정보 구하기 
	public Map<String , Object> getPageInfo(int page, String type, String word);

	public List<MemberVO> selectList(Map<String, Object> map);
	
	public int insertAdmin(MemberVO vo);
	
	public int updateAdmin(MemberVO vo);
	
	public int deleteAdmin(String id);
	
}
