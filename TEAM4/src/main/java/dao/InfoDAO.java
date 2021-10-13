package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.InfoVO;

public class InfoDAO {
	SqlSession sqlSession;
	
	public InfoDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//메인화면 공지사항
	//필요한 기능은 별로 없지만
	//부동산 컨트롤러 오류 예방으로 전부 다 남겨둠

	//게시글 추가
	public int insert(InfoVO vo) {
		int res = sqlSession.insert("b.info_insert", vo);
		return res;
	}

	//idx에 해당하는 게시글 한 건 얻어오기
	public InfoVO selectOne(int idx) {
		InfoVO vo = null;
		vo = sqlSession.selectOne("b.info_one", idx);
		return vo;
	}
	
	//조회수 증가
	public int update_readhit(int idx) {
		int res = sqlSession.update("b.info_update_readhit", idx);
		return res;
	}

	//기준글의 step보다 큰 값 +1처리
	public int update_step(InfoVO baseVo) {
		int res = sqlSession.update("b.info_update_step", baseVo);
		return res;
	}
	
	//댓글달기
	public int reply(InfoVO vo) {
		int res = sqlSession.insert("b.info_reply", vo);
		return res;
	}
	
	//삭제를 위한 게시글의 정보 가져오기
	public InfoVO selectOne(int idx, String pwd) {
		InfoVO vo = null;	
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("idx", idx);
		map.put("pwd", pwd);
		vo = sqlSession.selectOne("b.info_idx_pwd", map);
		return vo;
	}
	
	//게시글 삭제(된 것 처럼) 업데이트
	public int del_update(InfoVO vo) {
		int res = sqlSession.update("b.info_del_update", vo);
		return res;
	}
	
	//페이징을 포함한 검색
	public List<InfoVO> selectList(Map<String, Integer> map){
		List<InfoVO> list = null;
		list = sqlSession.selectList("b.info_list_condition", map);
		return list;
	}

	//게시판의 전체 게시물 수
	public int getRowTotal() {
		int count = sqlSession.selectOne("b.info_count");
		return count;
	}
	
	//게시글 수정
	public int modify(InfoVO vo) {
		int res = sqlSession.update("b.info_modify", vo);
		System.out.println(res);
		return res;
	}
	//-----------------------------------------------------------------
	
	//공인중개사 메인 공지사항
	
	//idx에 해당하는 게시글 한 건 얻어오기
	public InfoVO g_selectOne( int idx ) {
		InfoVO vo = null;
		vo = sqlSession.selectOne("b.info_one", idx);
		return vo;
	}
		
	//조회수 증가
	public int g_update_readhit(int idx) {
		int res = sqlSession.update("b.info_update_readhit", idx);
		return res;
	}

	//기준글의 step보다 큰 값 +1처리
	public int g_update_step(InfoVO baseVo) {
		int res = sqlSession.update("b.info_update_step", baseVo);
		return res;
	}
	
	//댓글달기
	public int g_reply(InfoVO vo) {
		int res = sqlSession.insert("b.info_reply", vo);
		return res;
	}
	
	//페이징을 포함한 검색
	public List<InfoVO> g_selectList(Map<String, Integer> map){
		List<InfoVO> list = null;
		list = sqlSession.selectList("b.info_list_condition", map);
		return list;
	}

	//게시판의 전체 게시물 수
	public int g_getRowTotal() {
		int count = sqlSession.selectOne("b.info_count");
		return count;
	}
	//-----------------------------------------------------------------
	
	//임대인 메인 공지사항
	
	//idx에 해당하는 게시글 한 건 얻어오기
	public InfoVO i_selectOne(int idx) {
		InfoVO vo = null;
		vo = sqlSession.selectOne("b.info_one", idx);
		return vo;
	}
	
	//조회수 증가
	public int i_update_readhit(int idx) {
		int res = sqlSession.update("b.info_update_readhit", idx);
		return res;
		
	}

	//기준글의 step보다 큰 값 +1처리
	public int i_update_step(InfoVO baseVo) {
		int res = sqlSession.update("b.info_update_step", baseVo);
		return res;
	}
	
	//댓글달기
	public int i_reply(InfoVO vo) {
		int res = sqlSession.insert("b.info_reply", vo);
		return res;
	}
	
	//페이징을 포함한 검색
	public List<InfoVO> i_selectList(Map<String, Integer> map){
		List<InfoVO> list = null;
		list = sqlSession.selectList("b.info_list_condition", map);
		return list;
		
	}

	//게시판의 전체 게시물 수
	public int i_getRowTotal() {
		int count = sqlSession.selectOne("b.info_count");
		return count;
	}
	//-----------------------------------------------------------------
	
	//관리사 메인 공지사항
	
	//게시글 추가
	public int m_insert(InfoVO vo) {
		int res = sqlSession.insert("b.info_insert", vo);
		return res;
	}

	//idx에 해당하는 게시글 한 건 얻어오기
	public InfoVO m_selectOne(int idx) {
		InfoVO vo = null;
		vo = sqlSession.selectOne("b.info_one", idx);
		return vo;
	}
	
	//조회수 증가
	public int m_update_readhit(int idx) {
		int res = sqlSession.update("b.info_update_readhit", idx);
		return res;
	}

	//기준글의 step보다 큰 값 +1처리
	public int m_update_step(InfoVO baseVo) {
		int res = sqlSession.update("b.info_update_step", baseVo);
		return res;
	}
	
	//삭제를 위한 게시글의 정보 가져오기
	public InfoVO m_selectOne(int idx, String pwd) {
		InfoVO vo = null;	
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("idx", idx);
		map.put("pwd", pwd);
		vo = sqlSession.selectOne("b.info_idx_pwd", map);
		return vo;
	}
	
	//게시글 삭제(된 것 처럼) 업데이트
	public int m_del_update(InfoVO vo) {
		int res = sqlSession.update("b.info_del_update", vo);
		return res;
		
	}
	
	//페이징을 포함한 검색
	public List<InfoVO> m_selectList(Map<String, Integer> map){
		List<InfoVO> list = null;
		list = sqlSession.selectList("b.info_list_condition", map);
		return list;
		
	}

	//게시판의 전체 게시물 수
	public int m_getRowTotal() {
		int count = sqlSession.selectOne("b.info_count");
		return count;
		
	}
	
	//게시글 수정
	public int m_modify(InfoVO vo) {
		int res = sqlSession.update("b.info_modify", vo);
		System.out.println(res);
		return res;
	}
}
