package com.korea.four;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import common.Common;
import common.Paging;
import common.PagingMain;
import dao.GonginDAO;
import dao.ImdaeinDAO;
import dao.InfoDAO;
import dao.KwanriDAO;
import dao.MainDAO;
import vo.GonginVO;
import vo.GunmulVO;
import vo.ImdaeinVO;
import vo.InfoVO;
import vo.KwanriVO;
import vo.PolygonVO;

@Controller
@RequestMapping("/")
public class BudongsanController {
	@Autowired
	ServletContext application;
	@Autowired
	HttpServletRequest request;
	
	GonginDAO gongin_dao;
	ImdaeinDAO imdaein_dao;
	InfoDAO info_dao;
	MainDAO main_dao;
	KwanriDAO kwanri_dao;
	
	//HttpSession session_g;
	//HttpSession session_i;
	//HttpSession session_m;
	
	private String param_id; //메인에서 공지사항을 띄울 때 아이디를 파라미터로 받지 못할 때 사용
	private int idx; //임대인 컨트롤러에 필요
	
	public String getParam_id() {
		return param_id;
	}
	public void setParam_id(String param_id) {
		this.param_id = param_id;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}

	public BudongsanController(GonginDAO gongin_dao, ImdaeinDAO imdaein_dao, KwanriDAO kwanri_dao, InfoDAO info_dao, MainDAO main_dao) {
		this.gongin_dao = gongin_dao;
		this.imdaein_dao = imdaein_dao;
		this.info_dao = info_dao;
		this.main_dao = main_dao;
		this.kwanri_dao = kwanri_dao;
	}
	
	//부동산 컨트롤러------------------------------------------------------------------------------------------------------------------------
	//메인화면
	@RequestMapping(value= {"/", "budongsanmain.do"})
	public String main(Model model, Integer page) {
		int nowPage = 1;

		if(page != null) {
			nowPage = page;
		}

		//한 페이지에 표시되는 게시물의 시작과 끝번호를 계산
		int start = (nowPage - 1) * Common.Board.BLOCKLIST + 1;
		int end = start + Common.Board.BLOCKLIST - 1;

		//start와 end를 맵에 저장
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("end", end);

		//게시글 전체목록 가져오기
		List<InfoVO> list = null;
		list = info_dao.selectList(map);
		
		//메인에서 regdate 작성 시간 빼고 년월일만 나오게 설정
		for(int i = 0; i < list.size(); i++) {
			String[] regdate = list.get(i).getRegdate().split(" ");
			list.get(i).setRegdate(regdate[0]);
		}

		//전체 게시물 수 구하기
		int row_total = info_dao.getRowTotal();

		//Paging 클래스를 사용하여 페이지 메뉴 생성하기
		String pageMenu = PagingMain.getPaging("budongsanmain.do", nowPage, row_total, Common.Board.BLOCKLIST, Common.Board.BLOCKPAGE);

		model.addAttribute("row", row_total);
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);

		//세션에 기록되어 있던 show 정보를 삭제
		request.getSession().removeAttribute("show");
		
		return Common.VIEW_PATH + "budongsanmain.jsp";
		//return "redirect:budongsanmain.jsp";
	}
	
	//매물 리스트 : 전체 목록
	@RequestMapping(value = {"/total_maemul_list.do"})
	public String total_list(Model model) {
		List<GunmulVO> list = gongin_dao.selectList();
		model.addAttribute("list", list);
		
		return Common.VIEW_PATH + "maemul_list.jsp";
	}
	
	//-----------------------------------------------------------
	
	//로그인 선택창으로 넘어가기
	@RequestMapping("/login_select.do")
	public String reg_select() {
		return Common.VIEW_PATH + "login_select.jsp";
	}
	
	//회원가입 선택창으로 넘어가기
	@RequestMapping("/reg_select.do")
	public String login_select() {
		return Common.VIEW_PATH + "reg_select.jsp";
	}
	//-----------------------------------------------------------
	
	//공인중개사 회원가입 폼으로 넘어가기
	@RequestMapping("/gongin_reg_form.do")
	public String gongin_reg_form() {
	
		return Common.VIEW_PATH_G + "gongin_reg_form.jsp";
	}
	
	//공인중개사 회원가입
	@RequestMapping("/gongin_insert.do")
	public String gongin_insert(GonginVO vo) {
		gongin_dao.gongin_insert(vo);
		return "redirect:budongsanmain.do";
	}
	//-----------------------------------------------------------
	
	//임대인 회원가입 폼으로 넘어가기
	@RequestMapping("/imdae_reg_form.do")
	public String imdae_reg_form() {
		return Common.VIEW_PATH_I + "imdae_reg_form.jsp";
	}
	
	//임대인 회원가입
	@RequestMapping("/imdae_insert.do")
	public String imdae_insert(ImdaeinVO vo) {
		imdaein_dao.imdae_insert(vo);
		return "redirect:budongsanmain.do";
	}
	//-----------------------------------------------------------
	
	//관리사 로그인 폼으로 이동
	@RequestMapping("/manage.do")
	public String manage_login() {
		return Common.VIEW_PATH_M + "manage_login.jsp";
	}
	
	//관리사 로그인
	@RequestMapping("/manage_login.do")
	@ResponseBody
	public String m_login(String id, String pwd) {
		
		KwanriVO vo = kwanri_dao.m_selectOne(id);
		String res = "";
		
		if( vo == null || vo.equals("")) {
			res = String.format("[{'result':'no'}, {'result':'no'}]");
		}
		
		if(vo != null) {
			
			if(!vo.getPwd().equals(pwd)) { 
				res = String.format("[{'result':'yes'}, {'result':'no'}]");
			}
			
			if(vo.getPwd().equals(pwd)) {
				res = String.format("[{'result':'yes'}, {'result':'yes'}, {'id':'%s'}]", vo.getId());
				//유저 정보를 세션에 저장
				HttpSession session = request.getSession();
				session.setAttribute("manage_vo", vo);
			}
		}
		
		return res;
	}
	//-----------------------------------------------------------

	//공인중개사 로그인 폼으로 이동
	@RequestMapping("/gongin.do")
	public String gongin_login() {
		return Common.VIEW_PATH_G + "gongin_login.jsp";
	}
	 
	//공인중개사 로그인
	@RequestMapping("/gongin_login.do")
	@ResponseBody
	public String g_login(String id, String pwd) {
		GonginVO vo = gongin_dao.g_selectOne(id);
		String res = "";
		
		if( vo == null || vo.equals("")) {
			res = String.format("[{'result':'no'}, {'result':'no'}]");
		}
		
		if(vo != null) {
			
			if(!vo.getPwd().equals(pwd)) { 
				res = String.format("[{'result':'yes'}, {'result':'no'}]");
			}
			
			if(vo.getPwd().equals(pwd)) {
				res = String.format("[{'result':'yes'}, {'result':'yes'}, {'id':'%s'}]", vo.getId());
				//유저 정보를 세션에 저장
				HttpSession session = request.getSession();
				session.setAttribute("gongin_vo", vo);
			}
		}
		return res;
	}

	//-----------------------------------------------------------
	
	//임대인 로그인 폼으로 이동
	@RequestMapping("/imdae.do")
	public String imdae_login() {
		return Common.VIEW_PATH_I + "imdae_login.jsp";
	}
	
	//임대인 로그인
	@RequestMapping("/imdae_login.do")
	@ResponseBody
	public String i_login(String id, String pwd) {
		ImdaeinVO vo = imdaein_dao.i_selectOne(id);
		String res = "";
		
		if( vo == null || vo.equals("")) {
			res = String.format("[{'result':'no'}, {'result':'no'}]");
		}
		
		if(vo != null) {
			
			if(!vo.getPwd().equals(pwd)) { 
				res = String.format("[{'result':'yes'}, {'result':'no'}]");
			}
			
			if(vo.getPwd().equals(pwd)) {
				res = String.format("[{'result':'yes'}, {'result':'yes'}, {'id':'%s'}]", vo.getId());
				//유저 정보를 세션에 저장
				HttpSession session = request.getSession();
				session.setAttribute("imdaein_vo", vo);
			}
		}
		return res;
	}
	
	//----------------------------------------------------------------
	//메인 공지사항
	//완전 처음 메인화면-글 등록, 수정, 삭제, 답변 기능 필요없음/목록보기만 남겨둠
	@RequestMapping("/view.do")
	public String view(Model model, int idx) {			
		//idx에 해당하는 게시글 한 건 얻어오기
		InfoVO vo = info_dao.selectOne(idx); 
		
		//조회수 증가
		HttpSession session = request.getSession();
		String show = (String)session.getAttribute("show");
		
		if(show == null) {
			info_dao.update_readhit(idx);
			session.setAttribute("show", "");
		}
		
		model.addAttribute("vo", vo);
		
		return Common.VIEW_PATH + "info_view.jsp";
	}
	
	@RequestMapping("/insert_form.do")
	public String insert_form() {
		return Common.VIEW_PATH + "info_write.jsp";
	}
	
	@RequestMapping("/insert.do")
	public String insert(InfoVO vo) {
		String ip = request.getRemoteAddr();
		vo.setIp(ip);
		
		info_dao.insert(vo);
		
		return "redirect:budongsanmain.do";
	}
	
	@RequestMapping("/del.do")
	@ResponseBody
	public String del(int idx, String pwd) {
		InfoVO baseVO = info_dao.selectOne(idx, pwd);
		
		String result = "no";
		
		if(baseVO == null) {
			return result;
		}
		
		//찾아온 게시글의 정보를 수정
		baseVO.setSubject("삭제된 게시글입니다.");
		baseVO.setName("unknown");
		
		int res = info_dao.del_update(baseVO);
		if(res == 1) {
			result = "yes";
		}
		
		return result;
	}
	
	//댓글 등록 창으로 전환
	@RequestMapping("/reply_form.do")
	public String reply_form() {
		return Common.VIEW_PATH + "info_reply.jsp";
	}
	
	//댓글 등록
	@RequestMapping("/reply.do")
	public String reply(InfoVO vo, String page) {
		//idx사용하여 게시물 정보 얻기
		InfoVO baseVO = info_dao.selectOne(vo.getIdx());
		
		//기준글의 step보다 큰 값은 모두 step - step + 1 처리
		info_dao.update_step(baseVO);
		
		//달고자 하는 댓글을 vo에 포함
		String ip = request.getRemoteAddr();
		vo.setIp(ip);
		
		vo.setRef(baseVO.getRef());
		vo.setStep(baseVO.getStep() + 1);
		vo.setDepth(baseVO.getDepth() + 1);
		
		//댓글 등록
		info_dao.reply(vo);
		
		return "redirect:budongsanmain.do?page=" + page;
	}
	
	//게시글 수정 폼으로 이동
	@RequestMapping("/modify_form.do")
	public String modify_form(Model model, InfoVO vo) {
		model.addAttribute("vo", vo);
		return Common.VIEW_PATH + "info_modify.jsp";
	}
	
	//게시글 수정
	@RequestMapping("/modify.do")
	public String modify(InfoVO vo) {
		String ip = request.getRemoteAddr();
		vo.setIp(ip);
		int idx = vo.getIdx();
		
		System.out.println("idx:" +vo.getIdx());
		System.out.println(vo.getContent());
		System.out.println(vo.getName());
		System.out.println(vo.getSubject());
		
		info_dao.modify(vo);
		
		return "redirect:view.do?idx=" + idx;
	}

	//----------------------------------------------------------------
		
	//관리사로 로그인 시 메인&공지
	//관리사는 글 등록, 수정, 삭제, 목록보기 기능 필요. 답변 기능은 필요 없음
	@RequestMapping("/m_login_main.do")
	public String managelogin_main(Model model, String id, Integer page) {
		KwanriVO vo = kwanri_dao.m_selectOne(id);
		setParam_id(id);
		
		if(vo != null) {
			model.addAttribute("name", vo.getName());
			model.addAttribute("id", id);
			int nowPage = 1;

			if(page != null) {
				nowPage = page;
			}

			//한 페이지에 표시되는 게시물의 시작과 끝번호를 계산
			int start = (nowPage - 1) * Common.Board.BLOCKLIST + 1;
			int end = start + Common.Board.BLOCKLIST - 1;

			//start와 end를 맵에 저장
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("start", start);
			map.put("end", end);

			//게시글 전체목록 가져오기
			List<InfoVO> list = null;
			list = info_dao.selectList(map);
			
			//메인에서 regdate 작성 시간 빼고 년월일만 나오게 설정
			for(int i = 0; i < list.size(); i++) {
				String[] regdate = list.get(i).getRegdate().split(" ");
				list.get(i).setRegdate(regdate[0]);
			}

			// 전체 게시물 수 구하기
			int row_total = info_dao.getRowTotal();

			// Paging클래스를 사용하여 페이지 메뉴 생성하기
			String pageMenu = Paging.getPaging("m_login_main.do?id="+id, nowPage, row_total, Common.Board.BLOCKLIST,Common.Board.BLOCKPAGE);

			model.addAttribute("row", row_total);

			model.addAttribute("list", list);
			model.addAttribute("pageMenu", pageMenu);

			// 세션에 기록되어 있던 show정보를 삭제
			request.getSession().removeAttribute("show");
		}
		
		return Common.VIEW_PATH_M + "managemain.jsp";
	}
	
	@RequestMapping("/m_view.do")
	public String m_view(Model model, int idx, String id) {			
		//idx에 해당하는 게시글 한 건 얻어오기
		InfoVO vo = info_dao.selectOne(idx); 
		
		//조회수 증가
		HttpSession session = request.getSession();
		String show = (String)session.getAttribute("show");
		if(show == null) {
			info_dao.update_readhit(idx);
			session.setAttribute("show", "");
		}
		
		model.addAttribute("vo", vo);
		model.addAttribute("id", id);
		
		return Common.VIEW_PATH_M + "info_view.jsp";
	}
	
	@RequestMapping("/m_insert_form.do")
	public String m_insert_form(Model model, String id) {
		id = getParam_id();
		model.addAttribute("id", id);
		
		return Common.VIEW_PATH_M + "info_write.jsp";
	}
	
	@RequestMapping("/m_insert.do")
	public String m_insert(Model model, InfoVO vo, String id) {
		String ip = request.getRemoteAddr();
		vo.setIp(ip);
		
		model.addAttribute("id", id);
		info_dao.insert(vo);
		
		return "redirect:m_login_main.do?id" + id;
	}
	
	@RequestMapping("/m_del.do")
	@ResponseBody
	public String m_del(int idx, String pwd) {
		InfoVO baseVO = info_dao.selectOne(idx, pwd);
		
		String result = "no";
		
		if(baseVO == null) {
			return result;
		}
		
		//찾아온 게시글의 정보를 수정
		baseVO.setSubject("삭제된 게시글입니다.");
		baseVO.setName("unknown");
		
		int res = info_dao.del_update(baseVO);
		if(res == 1) {
			result = "yes";
		}
		
		return result;
	}
	
	//게시글 수정폼으로 이동
	@RequestMapping("/m_modify_form.do")
	public String m_modify_form(Model model, String id, int idx ) {
		InfoVO vo = info_dao.m_selectOne(idx);
		model.addAttribute("vo", vo);
		model.addAttribute("id", id);
		return Common.VIEW_PATH_M + "info_modify.jsp";
	}
	
	//게시글 수정
	@RequestMapping("/m_modify.do")
	public String m_modify(Model model, InfoVO vo, String id, Integer page) {
		String ip = request.getRemoteAddr();
		vo.setIp(ip);
		int idx = vo.getIdx();
		model.addAttribute("id", id);
		
		System.out.println("idx:" + vo.getIdx());
		System.out.println(vo.getContent());
		System.out.println(vo.getName());
		System.out.println(vo.getSubject());
		
		info_dao.modify(vo);
		
		return "redirect:m_view.do?idx="+idx+"&page="+page;
	}
		
	//----------------------------------------------------------------
		
	//공인중개사로 로그인 시 메인&공지
	//답변, 답변 수정, 목록보기 기능만 필요. 그 외는 삭제
	@RequestMapping("/g_login_main.do")
	public String gonginlogin_main(Model model, String id, Integer page) {
		GonginVO vo = gongin_dao.g_selectOne(id);
		
		if(vo != null) {
			model.addAttribute("name", vo.getName());
			model.addAttribute("id", id);
			int nowPage = 1;
			
			if (page != null) {
				nowPage = page;
			}
	
			//한 페이지에 표시되는 게시물의 시작과 끝번호를 계산
			int start = (nowPage - 1) * Common.Board.BLOCKLIST + 1;
			int end = start + Common.Board.BLOCKLIST - 1;
	
			//start와 end를 맵에 저장
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("start", start);
			map.put("end", end);
	
			//게시글 전체목록 가져오기
			List<InfoVO> list = null;
			list = info_dao.selectList(map);
			
			//메인에서 regdate 작성 시간 빼고 년월일만 나오게 설정
			for(int i = 0; i < list.size(); i++) {
				String[] regdate = list.get(i).getRegdate().split(" ");
				list.get(i).setRegdate(regdate[0]);
			}
			
			//전체 게시물 수 구하기
			int row_total = info_dao.getRowTotal();
	
			//Paging클래스를 사용하여 페이지 메뉴 생성하기
			String pageMenu = Paging.getPaging("g_login_main.do?id="+id, nowPage, row_total, Common.Board.BLOCKLIST,Common.Board.BLOCKPAGE);
	
			model.addAttribute("row", row_total);
			model.addAttribute("list", list);
			model.addAttribute("pageMenu", pageMenu);
	
			//세션에 기록되어 있던 show정보를 삭제
			request.getSession().removeAttribute("show");
		}
		
		return Common.VIEW_PATH_G + "gonginmain.jsp";
	}
	
	@RequestMapping("/g_view.do")
	public String g_view(Model model, int idx, String id) {			
		//idx에 해당하는 게시글 한 건 얻어오기
		InfoVO vo = info_dao.selectOne(idx); 
		
		//조회수 증가
		HttpSession session = request.getSession();
		String show = (String)session.getAttribute("show");
		if(show == null) {
			info_dao.update_readhit(idx);
			session.setAttribute("show", "");
		}
		
		model.addAttribute("vo", vo);
		model.addAttribute("id", id);
		
		return Common.VIEW_PATH_G + "info_view.jsp";
	}
	
	//댓글 등록 창으로 전환
	@RequestMapping("/g_reply_form.do")
	public String g_reply_form(Model model, String id) {
		model.addAttribute("id", id);
		
		return Common.VIEW_PATH_G + "info_reply.jsp";
	}
	
	//댓글 등록
	@RequestMapping("/g_reply.do")
	public String g_reply(Model model, InfoVO vo, String page, String id) {
		//idx사용하여 게시물 정보 얻기
		InfoVO baseVO = info_dao.selectOne(vo.getIdx());
		
		//기준글의 step보다 큰 값은 모두 step - step + 1 처리
		info_dao.update_step(baseVO);
		
		//달고자 하는 댓글을 vo 에 포함
		String ip = request.getRemoteAddr();
		vo.setIp(ip);
		
		vo.setRef(baseVO.getRef());
		vo.setStep(baseVO.getStep() + 1);
		vo.setDepth(baseVO.getDepth() + 1);
		
		model.addAttribute("id", id);
		//댓글 등록
		info_dao.reply(vo);
		
		return "redirect:g_login_main.do?page=" + page;
	}
		
	//----------------------------------------------------------------
		
	//임대인으로 로그인 시 메인&공지
	//답변, 답변 수정, 목록보기 기능만 필요. 그 외는 삭제
	@RequestMapping("/i_login_main.do")
	public String imdaelogin_main(Model model, String id, Integer page) {
		ImdaeinVO vo = imdaein_dao.i_selectOne(id);
		
		if(vo != null) {
			model.addAttribute("name", vo.getName());
			model.addAttribute("id", id);
			int nowPage = 1;

			if(page != null) {
				nowPage = page;
			}

			//한 페이지에 표시되는 게시물의 시작과 끝번호를 계산
			int start = (nowPage - 1) * Common.Board.BLOCKLIST + 1;
			int end = start + Common.Board.BLOCKLIST - 1;

			//start와 end를 맵에 저장
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("start", start);
			map.put("end", end);

			//게시글 전체목록 가져오기
			List<InfoVO> list = null;
			list = info_dao.selectList(map);
			
			//메인에서 regdate 작성 시간 빼고 년월일만 나오게 설정
			for(int i = 0; i < list.size(); i++) {
				String[] regdate = list.get(i).getRegdate().split(" ");
				list.get(i).setRegdate(regdate[0]);
			}
			
			//전체 게시물 수 구하기
			int row_total = info_dao.getRowTotal();

			//Paging클래스를 사용하여 페이지 메뉴 생성하기
			String pageMenu = Paging.getPaging("i_login_main.do?id="+id, nowPage, row_total, Common.Board.BLOCKLIST,Common.Board.BLOCKPAGE);

			model.addAttribute("row", row_total);

			model.addAttribute("list", list);
			model.addAttribute("pageMenu", pageMenu);

			//세션에 기록되어 있던 show정보를 삭제
			request.getSession().removeAttribute("show");
		}
		
		return Common.VIEW_PATH_I + "imdaemain.jsp";
	}
	
	@RequestMapping("/i_view.do")
	public String i_view(Model model, int idx, String id) {			
		//idx에 해당하는 게시글 한 건 얻어오기
		InfoVO vo = info_dao.selectOne(idx); 
		
		//조회수 증가
		HttpSession session = request.getSession();
		String show = (String)session.getAttribute("show");
		if(show == null) {
			info_dao.update_readhit(idx);
			session.setAttribute("show", "");
		}
		
		model.addAttribute("vo", vo);
		model.addAttribute("id", id);
		
		return Common.VIEW_PATH_I + "info_view.jsp";
	}
	
	//댓글 등록 창으로 전환
	@RequestMapping("/i_reply_form.do")
	public String i_reply_form(Model model, String id) {
		model.addAttribute("id", id);
		return Common.VIEW_PATH_I + "info_reply.jsp";
	}
	
	//댓글 등록
	@RequestMapping("/i_reply.do")
	public String i_reply(Model model, InfoVO vo, String page, String id) {
		//idx사용하여 게시물 정보 얻기
		InfoVO baseVO = info_dao.selectOne(vo.getIdx());
		
		//기준글의 step보다 큰 값은 모두 step - step + 1 처리
		info_dao.update_step(baseVO);
		
		//달고자 하는 댓글을 vo 에 포함
		String ip = request.getRemoteAddr();
		vo.setIp(ip);
		vo.setRef(baseVO.getRef());
		vo.setStep(baseVO.getStep() + 1);
		vo.setDepth(baseVO.getDepth() + 1);
		
		model.addAttribute("id", id);
		//댓글 등록
		info_dao.reply(vo);
		
		return "redirect:i_login_main.do?page="+page;
	}
	
	//이용안내
	@RequestMapping("/use_info.do")
	public String use_info() {
		return Common.VIEW_PATH + "use_info.jsp";
	}
	
	//오시는 길
	@RequestMapping("/come.do")
	public String come() {
		return Common.VIEW_PATH + "come.jsp";
	}
	
	//메인에서 지도 위치 클릭했을 때 넘어감
	@RequestMapping("/map.do")
	public String map(String location, Model model) {
		//ex) location=구로구
		PolygonVO vo = main_dao.getPolygon(location);
		String polygon = vo.getPolygonpath();
		String center = vo.getCenter();
		List<GunmulVO> list = main_dao.selectGunmulAddrList(location);
		
		model.addAttribute("list", list	);
		model.addAttribute("center", center);
		model.addAttribute("polygon", polygon);
		
		return Common.VIEW_PATH + "map.jsp";
	}
	
	//로그아웃
	@RequestMapping("/logout.do")
	public String logout() {
		HttpSession session = request.getSession();
		session.removeAttribute("manage_vo");
		session.removeAttribute("gongin_vo");
		session.removeAttribute("imdaein_vo");
		
		return "redirect:budongsanmain.do";
	}
	
	//회원 정보 수정  폼으로 이동
	@RequestMapping("/user_modify.do")
	public String user_modify(Model model, String id) {
		GonginVO vo = gongin_dao.g_selectOne(id);
		model.addAttribute("vo", vo);
		
		return Common.VIEW_PATH_G+"user_modify_form.jsp";
	}
	   
	//회원 정보 수정
	@RequestMapping("/gongin_modify.do")
	public String modify(GonginVO vo, Model model, String id) {
	    gongin_dao.gongin_modify(vo);
	    model.addAttribute("id", id);
	    request.setAttribute("gongin_vo", vo);
	    return "budongsanmain.do";
	}
}
