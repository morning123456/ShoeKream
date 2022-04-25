package kr.or.ddit.kream.member.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.kream.util.SqlMapClientFactory;
import kr.or.ddit.kream.vo.AddressVo;
import kr.or.ddit.kream.vo.MemberVO;
import kr.or.ddit.kream.vo.MyBuyingListVO;

public class MemberDaoImpl implements IMemberDao{
	private static IMemberDao dao;
	private MemberDaoImpl() {
		
	}
	public static IMemberDao getInstance() {
		if(dao==null)dao = new MemberDaoImpl();
		return dao;
	}
	

	@Override
	public int insertMember(SqlMapClient smc,  MemberVO memberVo) throws SQLException {
		Object obj = smc.insert("member.insertMember", memberVo);
		if(obj == null) return 1;
		else return 0;
	}
	@Override
	public MemberVO getMember(SqlMapClient smc, MemberVO memberVo) throws SQLException {
		
		return (MemberVO)smc.queryForObject("member.getMember", memberVo);
	}
	@Override
	public List<MyBuyingListVO> getBidList(SqlMapClient smc,  Map<String, String> paramap) throws SQLException {
		// TODO Auto-generated method stub
		return smc.queryForList("member.getBidList", paramap);
	}
	@Override
	public Map<String, Integer> getBuySellCount(SqlMapClient smc, String mem_email) throws SQLException {
		// TODO Auto-generated method stub
		return (Map<String, Integer>)smc.queryForObject("member.getBuySellCount", mem_email);
	}
	@Override
	public List<MyBuyingListVO> searchbuyList(SqlMapClient smc, Map<String, String> paramap) throws SQLException {
		// TODO Auto-generated method stub
		return smc.queryForList("member.searchbuyList", paramap);
	}
	@Override
	public List<Map<String, Object>> wishList(SqlMapClient smc, String mem_email) throws SQLException {
		// TODO Auto-generated method stub
		return smc.queryForList("member.wishList", mem_email);
	}
	@Override
	public String addrcount(SqlMapClient smc, String mem_email) throws SQLException {
		// TODO Auto-generated method stub
		return (String)smc.queryForObject(mem_email);
	}
	@Override
	public int updateaddr(SqlMapClient smc, AddressVo addressVo) throws SQLException {
		// TODO Auto-generated method stub
		return smc.update("member.updateaddr", addressVo);
	}
	@Override
	public int insertaddr(SqlMapClient smc, String mem_email) throws SQLException {
		// TODO Auto-generated method stub
		Object obj = smc.insert("member.insertaddr", mem_email);
		if(obj == null) return 1;
		else return 0;
	}
	@Override
	public String snsCount(SqlMapClient smc, String mem_sns) throws SQLException {
		// TODO Auto-generated method stub
		return (String)smc.queryForObject("member.snsCount", mem_sns);
	}
	@Override
	public MemberVO getSnsMember(SqlMapClient smc, String mem_sns) throws SQLException {
		// TODO Auto-generated method stub
		return (MemberVO) smc.queryForObject("member.getSnsMember", mem_sns);
	}
	@Override
	public int updateProfile(SqlMapClient smc, MemberVO memberVo) throws SQLException {
		// TODO Auto-generated method stub
		return smc.update("member.updateProfile", memberVo);
	}
	@Override
	public int updateMember(SqlMapClient smc, Map<String, String> paramap) throws SQLException {
		// TODO Auto-generated method stub
		return smc.update("member.updateMember", paramap);
	}
	@Override
	public int updateAcc(SqlMapClient smc, MemberVO memberVO) throws SQLException {
		// TODO Auto-generated method stub
		return smc.update("member.updateAcc", memberVO);
	}
	@Override
	public String findEmail(SqlMapClient smc, String mem_name) throws SQLException {
		// TODO Auto-generated method stub
		return (String) smc.queryForObject("member.findEmail", mem_name);
	}
	@Override
	public String findPass(SqlMapClient smc, MemberVO memberVO) throws SQLException {
		// TODO Auto-generated method stub
		return (String) smc.queryForObject("member.findPass", memberVO);
	}

}
