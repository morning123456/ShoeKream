package kr.or.ddit.kream.photo.service;

import java.sql.SQLException;

import kr.or.ddit.kream.photo.dao.IPhotoDao;
import kr.or.ddit.kream.photo.dao.PhotoDaoImpl;

public class PhotoServiceImpl implements IPhotoService{

	private IPhotoDao dao;  // 
	private static IPhotoService Service;
	
	private PhotoServiceImpl() {
		dao = PhotoDaoImpl.getInstance();	//
	}

	public static IPhotoService getInstance(){
		if(Service==null) Service = new PhotoServiceImpl();
		return Service;
	}
	
	
	@Override
	public String getPhoto(String prod_id) throws SQLException {
		return dao.getPhoto(prod_id);
	}
	
	
	
}
