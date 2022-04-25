package kr.or.ddit.kream.photo.service;

import java.sql.SQLException;

public interface IPhotoService {

	// '판매하기'에서 사진 넣기
		public String getPhoto(String prod_id) throws SQLException;
}
