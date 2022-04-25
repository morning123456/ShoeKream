package kr.or.ddit.kream.member.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.kream.member.dao.IMemberDao;
import kr.or.ddit.kream.member.dao.MemberDaoImpl;
import kr.or.ddit.kream.util.SqlMapClientFactory;
import kr.or.ddit.kream.vo.AddressVo;
import kr.or.ddit.kream.vo.MemberVO;
import kr.or.ddit.kream.vo.MyBuyingListVO;

public class MemberServiceImpl implements IMemberService {
	private static IMemberService service;
	private IMemberDao dao;
	private SqlMapClient smc;
	
	private MemberServiceImpl() {
		dao = MemberDaoImpl.getInstance();
		smc = SqlMapClientFactory.getSqlMapClient();
	}
	
	public static IMemberService getInstance() {
		if(service == null) service = new MemberServiceImpl();
		return service;
	}
	
	@Override
	public int insertMember(MemberVO memberVo){
		int res = 0;
		int res2 = 0;
		try {
			res = dao.insertMember(smc, memberVo);
			res2 = dao.insertaddr(smc, memberVo.getMem_email());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			res = 0;
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public MemberVO getMember(MemberVO memberVo) {
		MemberVO vo = null;
		try {
			vo = dao.getMember(smc, memberVo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return vo;
	}

	@Override
	public List<MyBuyingListVO> getBidList(Map<String, String> paramap) {
		List<MyBuyingListVO> list = null;
		try {
			list = dao.getBidList(smc, paramap);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			list = null;
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Map<String, Integer> getBuySellCount(String mem_email) {
		Map<String, Integer> map = null;
		
		try {
			map = dao.getBuySellCount(smc, mem_email);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			map = null;
			e.printStackTrace();
		}
		
		return map;
	}

	@Override
	public List<MyBuyingListVO> searchbuyList(Map<String, String> paramap) {
		List<MyBuyingListVO> list = null;
		try {
			list = dao.searchbuyList(smc, paramap);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			list = null;
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Map<String, Object>> wishList(String mem_email) {
		List<Map<String, Object>> list = null;
		try {
			list = dao.wishList(smc, mem_email);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			list = null;
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public String addrcount(String mem_email) {
		String count = null;
		try {
			count = dao.addrcount(smc, mem_email);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			count = null;
			e.printStackTrace();
		}
		return count;
	}

	@Override
	public int updateaddr(AddressVo addressVo) {
		int cnt = 0;
		try {
			cnt = dao.updateaddr(smc, addressVo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			cnt = 0;
			e.printStackTrace();
		}
		return cnt;
	}

	@Override
	public String snsCount(String mem_sns) {
		String count = null;
		try {
			count = dao.snsCount(smc, mem_sns);
		} catch (SQLException e) {
			count = null;
			e.printStackTrace();
		}
		return count;
	}

	@Override
	public MemberVO getSnsMember(String mem_sns) {
		MemberVO memberVo = null;
		try {
			memberVo = dao.getSnsMember(smc, mem_sns);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			memberVo = null;
			e.printStackTrace();
		}
		return memberVo;
	}

	@Override
	public int updateProfile(MemberVO memberVo) {
		int cnt = 0;
		try {
			cnt = dao.updateProfile(smc, memberVo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			cnt = 0;
			e.printStackTrace();
		}
		return cnt;
	}

	@Override
	public int updateMember(Map<String, String> paramap) {
		int cnt = 0;
		try {
			cnt = dao.updateMember(smc, paramap);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			cnt = 0;
			e.printStackTrace();
		}
		return cnt;
	}

	@Override
	public int updateAcc(MemberVO memberVO) {
		int cnt = 0;
		try {
			cnt = dao.updateAcc(smc, memberVO);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			cnt = 0;
			e.printStackTrace();
		}
		return cnt;
	}

	@Override
	public String findEmail(String mem_name) {
		// TODO Auto-generated method stub
		String email = null;
		try {
			email = dao.findEmail(smc, mem_name);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			email = null;
			e.printStackTrace();
		}
		return email;
	}

	@Override
	public String findPass(MemberVO memberVO) {
		// TODO Auto-generated method stub
		String pass = null;
		try {
			pass = dao.findPass(smc, memberVO);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			pass = null;
			e.printStackTrace();
		}
		return pass;
	}
}
