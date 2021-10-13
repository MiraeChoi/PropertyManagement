package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.GonginVO;
import vo.GunmulVO;
import vo.ImdaeinVO;
import vo.KwanriVO;

public class KwanriDAO {
	SqlSession sqlSession;
	
	public KwanriDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//로그인하고자 하는 관리사 id 하나 검색
	public KwanriVO m_selectOne(String id) {
		KwanriVO vo = sqlSession.selectOne("b.kwanri_one", id);
		return vo;
	}
	
	//회원정보 수정
	public int manage_modify( KwanriVO vo) {
		int res=sqlSession.update("m.manage_modify", vo);
		return res;
	}
	
	//공인중개사 리스트 불러오기
	public List<GonginVO> selectGongList(){
		List<GonginVO> list = sqlSession.selectList("m.select_list_gong");
		return list;
	}
	
	//임대인 리스트 불러오기
	public List<ImdaeinVO> selectImList(){
		List<ImdaeinVO> list = sqlSession.selectList("m.select_list_im");
		return list;
	}
	
	//전체 매물리스트 불러오기
	public List<GunmulVO> selectgunList(){
		List<GunmulVO> list = sqlSession.selectList("m.select_list_gun");
		return list;
	}
	
	//idx로 공인중개사 정보 불러오기
	public GonginVO g_selectOne(int idx) {
		GonginVO vo = sqlSession.selectOne("m.select_one_gong", idx);
		return vo;
	}
	
	//idx로 임대인 정보 불러오기
	public ImdaeinVO i_selectOne(int idx) {
		ImdaeinVO vo = sqlSession.selectOne("m.select_one_im", idx);
		return vo;
	}
	
	//공인중개사 정보 수정
	public int updateHyoiwonGongin(GonginVO vo) {
		int res = sqlSession.update("m.update_hyoiwon_gongin", vo);
		return res;
	}
	
	//임대인 정보 수정
	public int updateHyoiwonImdaein(ImdaeinVO vo) {
		int res = sqlSession.update("m.update_hyoiwon_imdaein", vo);
		return res;
	}
	
	//공인중개사 정보 삭제
	public int delHyoiwonGongin(int idx) {
		int res = sqlSession.delete("m.delete_hyoiwon_gongin", idx);
		return res;
	}
	
	//임대인 정보 삭제
	public int delHyoiwonImdaein(int idx) {
		int res = sqlSession.delete("m.delete_hyoiwon_imdaein", idx);
		return res;
	}
	
	//매물 전체보기에서 검색
	public List<GunmulVO> selectgunregList( String searchRegion ){
		List<GunmulVO> list = sqlSession.selectList("m.select_search_gun_reg", searchRegion);
		return list;
	}
	
	//등록된 매물 목록 보기
	public List<GunmulVO> selectgunregList(){
		List<GunmulVO> list = sqlSession.selectList("m.select_list_gun_reg");
		return list;
	}
	
	//건물 관리 : 새 건물 등록하기
	public int insert(GunmulVO vo) {
		int res = sqlSession.insert("m.gunmul_insert", vo);
		return res;
	}
	
	//전체 매물보기에서 등록
	public int mnggonginUpdate(int idx) {
		int res = sqlSession.update("m.gongin_reg", idx);
		return res;
	}
	
	//전체 메물보기에서 수정
	public int update( GunmulVO vo){
		int res = sqlSession.update("m.gunmul_update", vo);
		return res;
	}
	
	//매물내리기
	public int cancel(int idx) {
		int res = sqlSession.update("m.cancel", idx);
		return res;
	}
	
	//매물올리기
	public int reg(int idx) {
		int res = sqlSession.update("m.reg", idx);
		return res;
	}
}
