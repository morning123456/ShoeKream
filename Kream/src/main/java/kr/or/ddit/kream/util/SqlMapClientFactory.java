package kr.or.ddit.kream.util;

import java.io.IOException;
import java.io.Reader;
import java.nio.charset.Charset;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

public class SqlMapClientFactory {
	private static SqlMapClient smc;

	// iBatis를 이용하여 DB자료를 처리하는 순서 및 방법
	public static SqlMapClient getSqlMapClient() {
		if (smc == null) {

			Reader rd = null;
			// 1. iBatis의 환경설정 파일을 읽어와서 실행한다.(sqlMapConfig.xml)
			try {
				// 1-1. 문자 인코딩 케릭터셋 설정
				Charset charset = Charset.forName("utf-8");

				// 1-2. 환경 설정 파일을 읽어올 스트림객체 생성
				rd = Resources.getResourceAsReader("kr/or/ddit/kream/config/sqlMapConfig.xml");

				// 1-3. 위에서 생성한 스트림 객체를 이용하여 환경설정 파일을 읽어서 실행한다.
				// iBatis를 처리할 객체가 반환된다.
				smc = SqlMapClientBuilder.buildSqlMapClient(rd);

			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				if (rd != null)
					try {
						rd.close();
					} catch (IOException e) {
					}
			}
		}
		return smc;
	}

}
