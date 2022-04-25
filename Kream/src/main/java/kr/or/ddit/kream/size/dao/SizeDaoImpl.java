package kr.or.ddit.kream.size.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.kream.util.SqlMapClientFactory;

public class SizeDaoImpl implements ISizeDao{

	
	private SqlMapClient smc;
	private static ISizeDao dao;

		private SizeDaoImpl(){	
			smc = SqlMapClientFactory.getSqlMapClient();
			
		}
		
		public static ISizeDao getInstance(){
			if(dao==null) dao = new SizeDaoImpl();
			
			return dao;
		}
		
	
	
	@Override
	public List<String> sizeInfo(String prod_id) throws SQLException {
		 return smc.queryForList("size.sizeInfo", prod_id);

	}

	
}
