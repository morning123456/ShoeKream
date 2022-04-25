package kr.or.ddit.kream.photo.dao;

import java.sql.SQLException;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.kream.util.SqlMapClientFactory;

public class PhotoDaoImpl implements IPhotoDao{

	private SqlMapClient smc;
	private static IPhotoDao dao;

		private PhotoDaoImpl(){	
			smc = SqlMapClientFactory.getSqlMapClient();
			
		}
		
		public static IPhotoDao getInstance(){
			if(dao==null) dao = new PhotoDaoImpl();
			
			return dao;
		}
		
	
	@Override
	public String getPhoto(String prod_id) {
		String cnt=null;
		try {
		 cnt=  (String) smc.queryForObject("bid.getPhoto",prod_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return cnt;
	}
}
