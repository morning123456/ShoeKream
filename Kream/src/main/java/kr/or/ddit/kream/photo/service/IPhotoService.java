package kr.or.ddit.kream.photo.service;

import java.sql.SQLException;

public interface IPhotoService {

	// '�Ǹ��ϱ�'���� ���� �ֱ�
		public String getPhoto(String prod_id) throws SQLException;
}
