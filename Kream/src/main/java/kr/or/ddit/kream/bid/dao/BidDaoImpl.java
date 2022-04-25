package kr.or.ddit.kream.bid.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.kream.util.SqlMapClientFactory;
import kr.or.ddit.kream.vo.BidVo;

public class BidDaoImpl implements IBidDao {

	private SqlMapClient smc;
	private static IBidDao dao;

		private BidDaoImpl(){	
			smc = SqlMapClientFactory.getSqlMapClient();
			
		}
		
		public static IBidDao getInstance(){
			if(dao==null) dao = new BidDaoImpl();
			
			return dao;
		}
		
		

		
		@Override
		public List<BidVo> sellInfo(String prodid) throws SQLException {
			 return smc.queryForList("bid.sellInfo", prodid);
		}

		@Override
		public List<BidVo> buyInfo(String prodid) throws SQLException {
			// TODO Auto-generated method stub
			return smc.queryForList("bid.buyInfo", prodid);
		}

		@Override
		public int insertBid(BidVo bidvo) throws SQLException {
			int cnt=0;
			Object obj = smc.insert("bid.insertBid",bidvo);
			if(obj==null) cnt = 1;
			return cnt;
		}

		@Override
		public String selectBid(BidVo bidvo) throws SQLException {
			// TODO Auto-generated method stub
			return (String) smc.queryForObject("bid.selectBid",bidvo);
		}

		@Override
		public int updateBid(BidVo bidvo) throws SQLException {
			// TODO Auto-generated method stub
			return smc.update("bid.updateBid",bidvo);
		}


		@Override
		public String sellNowCall(Map<String, String> map) throws SQLException {
			// TODO Auto-generated method stub
			return (String) smc.queryForObject("bid.sellNowCall",map);
		}

		@Override
		public String buyNowCall(Map<String, String> map) throws SQLException {
			// TODO Auto-generated method stub
			return (String) smc.queryForObject("bid.buyNowCall",map);
		}

	


}
