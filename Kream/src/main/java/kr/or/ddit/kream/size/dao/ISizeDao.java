package kr.or.ddit.kream.size.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;


public interface ISizeDao {

	public List<String>sizeInfo(String prod_id) throws SQLException;
	
}
