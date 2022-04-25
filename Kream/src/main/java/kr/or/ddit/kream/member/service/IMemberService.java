package kr.or.ddit.kream.member.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.kream.vo.AddressVo;
import kr.or.ddit.kream.vo.MemberVO;
import kr.or.ddit.kream.vo.MyBuyingListVO;

public interface IMemberService {
	public int insertMember(MemberVO memberVo);
	public MemberVO getMember(MemberVO memberVo);
	public List<MyBuyingListVO> getBidList(Map<String, String> paramap);
	public List<MyBuyingListVO> searchbuyList(Map<String, String> paramap);
	public Map<String, Integer> getBuySellCount(String mem_email);
	public List<Map<String, Object>> wishList(String mem_email);
	public String addrcount(String mem_email);
	public int updateaddr(AddressVo addressVo);
	public String snsCount(String mem_sns);
	public MemberVO getSnsMember(String mem_sns);
	public int updateProfile(MemberVO memberVo);
	public int updateMember(Map<String, String> paramap);
	public int updateAcc(MemberVO memberVO);
	public String findEmail(String mem_name);
	public String findPass(MemberVO memberVO);
}
