package kr.or.ddit.kream.member.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.kream.vo.AddressVo;
import kr.or.ddit.kream.vo.MemberVO;
import kr.or.ddit.kream.vo.MyBuyingListVO;

public interface IMemberDao {
	public int insertMember(SqlMapClient smc, MemberVO memberVo) throws SQLException;
	public MemberVO getMember(SqlMapClient smc, MemberVO memberVo) throws SQLException;
	public List<MyBuyingListVO> getBidList(SqlMapClient smc, Map<String, String> paramap) throws SQLException;
	public List<MyBuyingListVO> searchbuyList(SqlMapClient smc, Map<String, String> paramap) throws SQLException;
	public Map<String, Integer> getBuySellCount(SqlMapClient smc, String mem_email) throws SQLException;
	public List<Map<String, Object>> wishList(SqlMapClient smc, String mem_email) throws SQLException;	
	public String addrcount(SqlMapClient smc, String mem_email) throws SQLException;
	public int updateaddr(SqlMapClient smc, AddressVo addressVo) throws SQLException;
	public int insertaddr(SqlMapClient smc, String mem_email) throws SQLException;
	public String snsCount(SqlMapClient smc, String mem_sns) throws SQLException;
	public MemberVO getSnsMember(SqlMapClient smc, String mem_sns) throws SQLException;
	public int updateProfile(SqlMapClient smc, MemberVO memberVo) throws SQLException;
	public int updateMember(SqlMapClient smc, Map<String, String> paramap) throws SQLException;
	public int updateAcc(SqlMapClient smc, MemberVO memberVO) throws SQLException;
	public String findEmail(SqlMapClient smc, String mem_name) throws SQLException;
	public String findPass(SqlMapClient smc, MemberVO memberVO) throws SQLException;
}
