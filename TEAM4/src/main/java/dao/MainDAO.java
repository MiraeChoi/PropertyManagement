package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.GunmulVO;
import vo.PolygonVO;

public class MainDAO {

	SqlSession sqlSession;
	
	public MainDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	//addr로 검색하는 지역별 건물 리스트
	public List<GunmulVO> selectGunmulAddrList(String addr){
		List<GunmulVO> list = sqlSession.selectList("b.select_gunmul_list_addr", addr);
		
		//주소 동으로 쪼개기
		for(int i = 0; i< list.size(); i++) {
			String juso = list.get(i).getAddr();
			String[] arr = juso.split(" ");
			list.get(i).setDong(arr[2]);
		}
		return list;
	}
	
	public PolygonVO getPolygon( String location) {
		PolygonVO polygon = sqlSession.selectOne("b.get_polygon", location);
		
		return polygon;
	}
}
