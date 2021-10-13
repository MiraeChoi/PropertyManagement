package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.GonginVO;
import vo.GunmulVO;

public class GonginDAO {
	SqlSession sqlSession;
	
	public GonginDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//공인중개사 회원가입
	public int gongin_insert(GonginVO vo) {
		int res = sqlSession.insert("b.gongin_insert", vo);
		return res;
	}
	
	//로그인하고자 하는 공인중개사 id하나 검색
	public GonginVO g_selectOne(String id) {
		GonginVO vo = sqlSession.selectOne("b.gongin_one", id);
		return vo;
	}
	
	//내 건물 관리 목록 전체 조회
	public List<GunmulVO> selectList() {
		List<GunmulVO> list = null;
		list = sqlSession.selectList("gi.gongin_maemul_list");
		return list;
	}
	
	//내 건물 관리 목록 검색한 것 조회
	public List<GunmulVO> selectList( String searchRegion ) {
		List<GunmulVO> list = null;
		list = sqlSession.selectList("gi.gongin_maemul_list_searchRegion", searchRegion);
	 	return list;
	}
	
 	//특정 공인중개사가 매물 예약
 	public int gonginYeyak(int gun_idx, int gong_idx) {
 		HashMap<String, Integer> map = new HashMap<String, Integer>();
 		map.put("gun_idx", gun_idx);
 		map.put("gong_idx", gong_idx);
 		int res = sqlSession.update("gi.gongin_yeyak", map);
 		return res;
 	}
 	
 	//특정 공인중개사가 매물 계약
 	public int gonginGyeyak(int gun_idx) {
 		int res = sqlSession.update("gi.gongin_gyeyak", gun_idx);
 		return res;
 	}
 	
 	//매물 예약한거 계약 안 해서 초기화
 	public int gonginYeyakReset( int gun_idx) {
 		int res = sqlSession.update("gi.gongin_yeyak_reset", gun_idx);
 		return res;
 	}
 	
 	//공인중개사에서 예약한 매물 리스트 보기
 	public List<GunmulVO> selectYeyakList(int yeyak_gongin_idx){
 		List<GunmulVO> list = sqlSession.selectList("gi.gongin_yeyak_list", yeyak_gongin_idx);
 		return list;
 	}
 	
 	//예약한 매물리스트에서 예약 취소
 	public int cancelGonginYeyak( int gun_idx ) {
 		int res = sqlSession.update("gi.gongin_yeyak_reset", gun_idx);
 		return res;
 	}
	
	//공인중개사 회원정보 수정
	public int gongin_modify(GonginVO vo) {
		int res=sqlSession.update("b.gongin_modify", vo);
		return res;
	}
}
