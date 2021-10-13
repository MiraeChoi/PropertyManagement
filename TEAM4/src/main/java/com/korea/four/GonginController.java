package com.korea.four;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.GonginDAO;
import dao.InfoDAO;
import vo.GunmulVO;

@Controller
public class GonginController {
	@Autowired
	HttpServletRequest request;
	ServletContext application;
	
	GonginDAO gongin_dao;
	InfoDAO info_dao;
	
	public GonginController(GonginDAO gongin_dao, InfoDAO info_dao) {
		this.gongin_dao = gongin_dao;
		this.info_dao = info_dao;
	}
	
	//매물 리스트 : 공인중개사 페이지에 등록된 전체 목록
	@RequestMapping(value = {"/gongin_list.do"})
	public String total_list(Model model) {
		List<GunmulVO> list = gongin_dao.selectList();
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/gongin/gongin_login_list.jsp";
	}
	
	/*
	//예약 매물 목록으로 넘어가기
	@RequestMapping("/gongin_yeyak_list.do")
	public String gongin_yeyak_list() {
		return Common.VIEW_PATH_G + "gongin_yeyak_list.jsp";
	}
	*/
	
	//특정 공인중개사가 매물 예약
	@RequestMapping("/gongin_yeyak.do")
	@ResponseBody
	public String gongin_yeyak(Model model, int gun_idx, int gong_idx) {
		int res = gongin_dao.gonginYeyak(gun_idx, gong_idx);
		String result = String.format("[{'result':'no'}]");
		//등록 성공 시
		if(res != 0) {
			result = String.format("[{'result':'yes'}]");
		}
		
		try {
			Thread.sleep(10000);
			System.out.println("10초지남");
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
		gongin_dao.gonginYeyakReset(gun_idx);
		return result;
	}
	
	//매물리스트에서 특정 공인중개사가 매물 계약
	@RequestMapping("/gong_gyeyak.do")
	public String gong_gyeyak(Model model, int gun_idx) {
		int res = gongin_dao.gonginGyeyak(gun_idx);
		
		List<GunmulVO> list = gongin_dao.selectList();
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/gongin/gongin_login_list.jsp";
	}

	//매물리스트에서 검색하면 검색 내역 나오게
	@RequestMapping("/gong_searchRegion.do")
	public String gong_searchRegion( Model model, String searchRegion) {
		List<GunmulVO> list = gongin_dao.selectList(searchRegion);
		model.addAttribute("list", list);
		return "/WEB-INF/views/gongin/gongin_login_list.jsp";
	}
	
	//예약리스트 보기
	@RequestMapping("/gongin_yeyak_list.do")
	public String gongin_yeyak_list(Model model, int yeyak_gongin_idx ) {
		List<GunmulVO> list = gongin_dao.selectYeyakList(yeyak_gongin_idx);
		model.addAttribute("list", list);

		return "/WEB-INF/views/gongin/gongin_yeyak_list.jsp";
	}
	
	//예약리스트에서 예약 취소하기
	@RequestMapping("/gongin_cancel_yeyak.do")
	public String gongin_cancel_yeyak( Model model, int gun_idx, int yeyak_gongin_idx ) {
		gongin_dao.cancelGonginYeyak( gun_idx );
		List<GunmulVO> list = gongin_dao.selectYeyakList(yeyak_gongin_idx);
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/gongin/gongin_yeyak_list.jsp";
	}
	
	//예약리스트에서 계약하기
	@RequestMapping("/gongin_gyeyak_in_yeyak_list.do")
	public String gongin_gyeyak_in_yeyak_list( Model model, int gun_idx, int yeyak_gongin_idx ) {
		gongin_dao.gonginGyeyak( gun_idx );
		List<GunmulVO> list = gongin_dao.selectYeyakList(yeyak_gongin_idx);
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/gongin/gongin_yeyak_list.jsp";
	}
}
