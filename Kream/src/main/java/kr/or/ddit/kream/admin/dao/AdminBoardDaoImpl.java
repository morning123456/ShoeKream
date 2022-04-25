package kr.or.ddit.kream.admin.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.kream.util.SqlMapClientFactory;
import kr.or.ddit.kream.vo.MemberVO;

public class AdminBoardDaoImpl implements IAdminBoardDao{

	private SqlMapClient  client ;
	private static IAdminBoardDao dao;
	
	//생성자 - client객체 얻어오기 
	private AdminBoardDaoImpl() {
		client = SqlMapClientFactory.getSqlMapClient();
	}
	
	//getInstance()메소드 - dao객체생성하고 리턴 
	public  static IAdminBoardDao getInstance() {
		if(dao == null) dao = new AdminBoardDaoImpl();
		
		return  dao;
	}
	
	@Override
	public List<MemberVO> selectList(Map<String, Object> map) throws SQLException {
		// TODO Auto-generated method stub
		return  client.queryForList("adminBoard.selectList", map);
	}

	@Override
	public int totalCount() throws SQLException {
		// TODO Auto-generated method stub
		return (int)client.queryForObject("adminBoard.totalCount");
	}

	@Override
	public int insertAdmin(MemberVO vo) throws SQLException {
		Object obj = client.insert("adminBoard.insertAdmin", vo);
		if(obj == null) return 1;
		else return 0;
		
	}

	@Override
	public int updateAdmin(MemberVO vo) throws SQLException {
		// TODO Auto-generated method stub
		
		return client.update("adminBoard.updateAdmin", vo);
	}

	@Override
	public int deleteAdmin(String id) throws SQLException {
		// TODO Auto-generated method stub
		return client.delete("adminBoard.deleteAdmin", id);
	}

}
