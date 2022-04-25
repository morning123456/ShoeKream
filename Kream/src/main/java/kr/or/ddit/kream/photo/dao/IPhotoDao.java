package kr.or.ddit.kream.photo.dao;

import java.sql.SQLException;

public interface IPhotoDao {

	// '판매하기'에서 사진 넣기
	public String getPhoto(String prod_id);
}
