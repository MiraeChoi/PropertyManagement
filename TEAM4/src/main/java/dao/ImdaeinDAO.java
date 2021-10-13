package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.GunmulVO;
import vo.ImdaeinVO;

public class ImdaeinDAO {
	SqlSession sqlSession;
	
	public ImdaeinDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//임대인 회원가입
	public int imdae_insert(ImdaeinVO vo) {
		int res = sqlSession.insert("b.imdae_insert", vo);
		return res;
	}
	
	//로그인하고자 하는 임대인 id하나 검색
	public ImdaeinVO i_selectOne(String id) {
		ImdaeinVO vo = sqlSession.selectOne("b.imdae_one", id);
		return vo;
	}

	//회원정보 수정
	public int imdae_modify(ImdaeinVO vo) {
		int res=sqlSession.update("gm.imdae_modify", vo);
		return res;
	}
	
	//내가 공인중개사 페이지에 등록한 매물 목록 전체 조회
	public List<ImdaeinVO> maemulList(int ref) {
		List<ImdaeinVO> list = null;
		list = sqlSession.selectList("gm.maemul_list_idi", ref);
		return list;
	}
	
	//내 건물 관리 목록 전체 조회
	public List<GunmulVO> selectList(int ref) {
		List<GunmulVO> list = null;
		list = sqlSession.selectList("gm.gunmul_list_idi", ref);
		return list;
	}
	
	//내 건물 관리 : 공인중개사 페이지에 등록하기(라고 쓰고 수정이라 읽음)
	public int gonginUpdate(int idx) {
		int res = sqlSession.update("gm.gongin_reg", idx);
		return res;
	}
	
	//내 건물 관리 : 공인중개사 페이지에 등록된 매물 취소하기(라고 쓰고 수정이라 읽음)
	public int gonginCancel(int idx) {
		int res = sqlSession.update("gm.gongin_cancel", idx);
		return res;
	}
	
	//내 건물 관리 : 새 건물 등록하기
	public int insert(GunmulVO vo) {
		int res = sqlSession.insert("gm.gunmul_insert", vo);
		return res;
	}
	
	//건물 정보 1건 불러오기
	public GunmulVO selectOne(int idx) {
		GunmulVO vo = sqlSession.selectOne("gm.gunmul_one", idx);
		return vo;
	}
	
	//내 건물 관리 : 건물 정보 수정
	public int update(GunmulVO vo) {
		int res = sqlSession.update("gm.gunmul_update", vo);
		return res;
	}
	
	//내 건물 관리 : 등록된 건물 삭제
	public int delete(int idx) {
		int res = sqlSession.delete("gm.gunmul_delete", idx);
		return res;
	}
}
