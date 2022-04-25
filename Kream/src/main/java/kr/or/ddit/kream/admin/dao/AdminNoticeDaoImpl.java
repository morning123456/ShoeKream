package kr.or.ddit.kream.admin.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.kream.util.SqlMapClientFactory;
import kr.or.ddit.kream.vo.MemberVO;
import kr.or.ddit.kream.vo.NoticeVo;

public class AdminNoticeDaoImpl implements IAdminNoticeDao{
	private SqlMapClient  client ;
	private static IAdminNoticeDao dao;
	
	//생성자 - client객체 얻어오기 
	private AdminNoticeDaoImpl() {
		client = SqlMapClientFactory.getSqlMapClient();
	}
	
	//getInstance()메소드 - dao객체생성하고 리턴 
	public  static IAdminNoticeDao getInstance() {
		if(dao == null) dao = new AdminNoticeDaoImpl();
		
		return  dao;
	}

	

	@Override
	public int totalCount() throws SQLException {
		// TODO Auto-generated method stub
		return (int)client.queryForObject("adminNotice.totalCount");
	}
	
	@Override
	public List<NoticeVo> selectList(Map<String, Object> map) throws SQLException {
		// TODO Auto-generated method stub
		return  client.queryForList("adminNotice.selectList", map);
	}

	@Override
	public NoticeVo noticeDetail(String notice) throws SQLException {
		// TODO Auto-generated method stub
		NoticeVo vo = (NoticeVo)client.queryForObject("adminNotice.noticeDetail", notice);
		
		
		System.out.println(vo.getNotice_title()+"-------------");
		
		return (NoticeVo)client.queryForObject("adminNotice.noticeDetail", notice);
	}

	@Override
	public int noticeUpdate(NoticeVo vo) throws SQLException {
		// TODO Auto-generated method stub
		return client.update("adminNotice.noticeUpdate",vo);
	}

	@Override
	public int noticeDelete(String notice) throws SQLException {
		// TODO Auto-generated method stub
		return client.delete("adminNotice.noticeDelete",notice);
	}

	@Override
	public int noticeInsert(NoticeVo vo) throws SQLException {
		Object obj = client.insert("adminNotice.noticeInsert", vo);
		if(obj == null) return 1;
		else return 0;
		
	}
}
