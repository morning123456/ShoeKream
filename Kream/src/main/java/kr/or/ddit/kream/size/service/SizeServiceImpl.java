package kr.or.ddit.kream.size.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.kream.size.dao.ISizeDao;
import kr.or.ddit.kream.size.dao.SizeDaoImpl;

public class SizeServiceImpl implements ISizeService{


	private ISizeDao dao;  // 
	private static ISizeService Service;
	
	private SizeServiceImpl() {
		dao = SizeDaoImpl.getInstance();	//
	}

	public static ISizeService getInstance(){
		if(Service==null) Service = new SizeServiceImpl();
		return Service;
	}

	
	@Override
	public List<String> sizeInfo(String prod_id) {
		List<String> list = null;
		
		try {
			list = dao.sizeInfo(prod_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list; 
	}
}
