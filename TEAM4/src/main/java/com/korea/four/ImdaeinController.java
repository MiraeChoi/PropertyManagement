package com.korea.four;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import common.Common;
import dao.ImdaeinDAO;
import vo.GunmulVO;
import vo.ImdaeinVO;

@Controller
public class ImdaeinController {
	//web상의 절대경로를 가져오기 위한 클래스
	@Autowired
	ServletContext application;
	@Autowired
	HttpServletRequest request;
	ImdaeinDAO imdaein_dao;
	int idx;
	int ref;

	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	
	public ImdaeinController(ImdaeinDAO gunmul_dao) {
		this.imdaein_dao = gunmul_dao;
	}
	
	//회원 정보 수정  폼으로 이동
	@RequestMapping("/user_modify_imdae.do")
	public String user_modify_manage(Model model, String id) {
		ImdaeinVO vo = imdaein_dao.i_selectOne(id);
		model.addAttribute("vo", vo);
		return Common.VIEW_PATH_I+"user_modify_form.jsp";
	}
	   
	//회원 정보 수정
	@RequestMapping("/imdae_modify.do")
	public String manage_modify(ImdaeinVO vo, Model model, String id) {
		imdaein_dao.imdae_modify(vo);
	    model.addAttribute("id", id);
		request.setAttribute("imdaein_vo", vo);
	    return "budongsanmain.do";
	}
	//매물 리스트 : 전체 목록(메인)
	@RequestMapping(value = {"/gm_maemul_list_f.do"})
	public String total_list(Model model, int ref) {
		setRef(ref);
		
		List<ImdaeinVO> list = imdaein_dao.maemulList(ref);
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/imdae/imdae_maemul_list.jsp";
	}
	
	//매물 리스트 : 전체 목록
	@RequestMapping(value = {"/gm_maemul_list.do"})
	public String total_list(Model model) {
		List<ImdaeinVO> list = imdaein_dao.maemulList(getRef());
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/imdae/imdae_maemul_list.jsp";
	}
	
	//내 건물 관리 : 전체 목록(메인)
	@RequestMapping("/my_gmlist_f.do")
	public String my_list(Model model, int ref) {
		setRef(ref);
		
		List<GunmulVO> list = imdaein_dao.selectList(ref);
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/imdae/imdae_kwanri.jsp";
	}
	
	//내 건물 관리 : 전체 목록(수정 또는 삭제 후)
	@RequestMapping("/my_gmlist.do")
	public String my_list(Model model) {
		List<GunmulVO> list = imdaein_dao.selectList(getRef());
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/imdae/imdae_kwanri.jsp";
	}
	
	//내 건물 관리 : 공인중개사 페이지에 등록(건물 테이블의 reg_gyeyak_info=1로 수정)
	@RequestMapping("/gongin_reg.do")
	@ResponseBody
	public String gongin_reg(Model model, int idx) {
		int res = imdaein_dao.gonginUpdate(idx);
		
		String result = "no";
		//등록 성공 시
		if(res != 0) {
			result = "yes";
		}
		
		return result;
	}
	
	//내 건물 관리 : 공인중개사 페이지 등록 취소(건물 테이블의 reg_gyeyak_info=0으로 수정)
	@RequestMapping("/gongin_cancel.do")
	@ResponseBody
	public String gongin_cancel(Model model, int idx) {
		int res = imdaein_dao.gonginCancel(idx);
		
		String result = "no";
		//취소 성공 시
		if(res != 0) {
			result = "yes";
		}
		
		return result;
	}
	
	//내 건물 관리 : 건물 등록 페이지로 이동
	@RequestMapping("/gm_insert_form.do")
	public String gm_insert_form() {
		return "/WEB-INF/views/imdae/imdae_kwanri_insert_form.jsp";
	}
	
	//내 건물 관리 : 건물 등록
	@RequestMapping("/gm_insert.do")
	public String insert(MultipartHttpServletRequest mtfRequest, GunmulVO vo) {
		String webPath = "/resources/upload/";
		String savePath = application.getRealPath(webPath);
		System.out.println(savePath);
		
		//업로드된 파일의 정보
		MultipartFile photo_s = vo.getPhoto_s();
		List<MultipartFile> photo_l = vo.getPhoto_l();

		String gun_img_s = "no_file";
		String gun_img_l = "no_file";
		String img_l_arr = "";
		String temp = "";
		
		vo.setGun_img_s(gun_img_s);
		vo.setGun_img_l(gun_img_l);
		
		//메인 이미지(단일 파일)
		if(!photo_s.isEmpty()) {//업로드된 파일이 존재한다면...
			gun_img_s = photo_s.getOriginalFilename();

			//파일저장 경로
			File saveFile = new File(savePath, gun_img_s);
			
			if(!saveFile.exists()) {
				saveFile.mkdirs();
			}else {
				//동일한 파일명으로 등록이 시도될 경우에 대비하여
				//현재 업로드 시간을 붙여서 중복을 방지해준다.
				long time = System.currentTimeMillis();
				gun_img_s = String.format("%d_%s", time, gun_img_s);
				saveFile = new File(savePath, gun_img_s);
			}

			try {
				//업로드를 위한 파일은 MultipartResolver 클래스가 지정한 임시 저장소에
				//저장되지만 이 임시 저장소는 일정 시간이 지나면 사라지기 때문에
				//내가 지정한 savePath경로에 영구적으로 기록되도록 복사해 놓아야 한다.
				photo_s.transferTo(saveFile);
				vo.setGun_img_s(gun_img_s);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}//if_s
		
		//상세정보 이미지(다중 파일)
		if(!photo_l.isEmpty()) {//업로드된 파일이 존재한다면...
			for(MultipartFile mf : photo_l) {
				img_l_arr = mf.getOriginalFilename();
				
				//파일저장 경로
				File saveFile = new File(savePath, img_l_arr);
				
				if(!saveFile.exists()) {
					saveFile.mkdirs();
				}else {
					//동일한 파일명으로 등록이 시도될 경우에 대비하여
					//현재 업로드 시간을 붙여서 중복을 방지해준다.
					if(img_l_arr != "") {
						long time = System.currentTimeMillis();
						img_l_arr = String.format("%d_%s", time, img_l_arr);
						saveFile = new File(savePath, img_l_arr);
					}
				}
				temp += img_l_arr + "/";
				
				try {
					//업로드를 위한 파일은 MultipartResolver 클래스가 지정한 임시 저장소에
					//저장되지만 이 임시 저장소는 일정 시간이 지나면 사라지기 때문에
					//내가 지정한 savePath경로에 영구적으로 기록되도록 복사해 놓아야 한다.
					gun_img_l = temp;
					
					mf.transferTo(saveFile);
					vo.setGun_img_l(gun_img_l);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}//for
		}//if_l
		
		mtfRequest.setAttribute("vo", vo);
		imdaein_dao.insert(vo);

		return "my_gmlist.do";
	}
	
	//상세 정보 페이지로 이동
	@RequestMapping("/gm_view.do")
	public String view_detail(Model model, int idx) {
		GunmulVO vo = imdaein_dao.selectOne(idx);
		
		String temp = vo.getGun_img_l();
		vo.setGun_img_arr(temp.split("/"));
		
		vo.setFile_gaesu(vo.getGun_img_arr().length);
		
		if(vo.getGun_option() != null) {
			String temp2 = vo.getGun_option();
			vo.setGun_op_arr(temp2.split(","));
		}
		
		if(vo != null) {
			model.addAttribute("vo", vo);
		}
		
		return "/WEB-INF/views/imdae/imdae_gunmul_detail.jsp";
	}
	
	//내 건물 관리 : 건물 수정 페이지로 이동
	@RequestMapping("/gm_modify_form.do")
	public String modify_form(Model model, int idx) {
		setIdx(idx);
		
		GunmulVO vo = imdaein_dao.selectOne(idx);
		
		if(vo != null) {
			model.addAttribute("vo", vo);
		}
		
		return "/WEB-INF/views/imdae/imdae_kwanri_modify_form.jsp";
	}
	
	//내 건물 관리 : 건물 수정 ajax로 넘기기
	@RequestMapping("/gm_modify_info.do")
	@ResponseBody
	public GunmulVO modify_info() {
		int idx = getIdx();
		GunmulVO vo = imdaein_dao.selectOne(idx);
		
		if(vo.getGun_option() != null) {
			String temp2 = vo.getGun_option();
			vo.setGun_op_arr(temp2.split(","));
		}
		
		return vo;
	}
	
	//내 건물 관리 : 건물 정보 수정
	@RequestMapping("/gm_update.do")
	public String update(Model model, GunmulVO vo) {
		String webPath = "/resources/upload/";
		String savePath = application.getRealPath(webPath);
		System.out.println(savePath);
		
		//업로드된 파일의 정보
		MultipartFile photo_s = vo.getPhoto_s();
		List<MultipartFile> photo_l = vo.getPhoto_l();

		String gun_img_s = "no_file";
		String gun_img_l = "no_file";
		String img_l_arr = "";
		String temp = "";
		
		vo.setGun_img_s(gun_img_s);
		vo.setGun_img_l(gun_img_l);
		
		//메인 이미지(단일 파일)
		if(!photo_s.isEmpty()) {//업로드된 파일이 존재한다면...
			gun_img_s = photo_s.getOriginalFilename();

			//파일저장 경로
			File saveFile = new File(savePath, gun_img_s);
			
			if(!saveFile.exists()) {
				saveFile.mkdirs();
			}else {
				//동일한 파일명으로 등록이 시도될 경우에 대비하여
				//현재 업로드 시간을 붙여서 중복을 방지해준다.
				long time = System.currentTimeMillis();
				gun_img_s = String.format("%d_%s", time, gun_img_s);
				saveFile = new File(savePath, gun_img_s);
			}

			try {
				//업로드를 위한 파일은 MultipartResolver 클래스가 지정한 임시 저장소에
				//저장되지만 이 임시 저장소는 일정 시간이 지나면 사라지기 때문에
				//내가 지정한 savePath경로에 영구적으로 기록되도록 복사해 놓아야 한다.
				photo_s.transferTo(saveFile);
				vo.setGun_img_s(gun_img_s);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}//if_s
		
		//상세정보 이미지(다중 파일)
		if(!photo_l.isEmpty()) {//업로드된 파일이 존재한다면...
			for(MultipartFile mf : photo_l) {
				img_l_arr = mf.getOriginalFilename();
				
				//파일저장 경로
				File saveFile = new File(savePath, img_l_arr);
				
				if(!saveFile.exists()) {
					saveFile.mkdirs();
				}else {
					//동일한 파일명으로 등록이 시도될 경우에 대비하여
					//현재 업로드 시간을 붙여서 중복을 방지해준다.
					if(img_l_arr != "") {
						long time = System.currentTimeMillis();
						img_l_arr = String.format("%d_%s", time, img_l_arr);
						saveFile = new File(savePath, img_l_arr);
					}
				}
				temp += img_l_arr + "/";
				
				try {
					//업로드를 위한 파일은 MultipartResolver 클래스가 지정한 임시 저장소에
					//저장되지만 이 임시 저장소는 일정 시간이 지나면 사라지기 때문에
					//내가 지정한 savePath경로에 영구적으로 기록되도록 복사해 놓아야 한다.
					gun_img_l = temp;
					
					mf.transferTo(saveFile);
					vo.setGun_img_l(gun_img_l);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}//for
		}//if_l
		
		model.addAttribute("vo", vo);
		imdaein_dao.update(vo);
		
		return "redirect:my_gmlist.do";
	}
	
	//내 건물 관리 : 등록된 건물 삭제
	@RequestMapping("/gm_delete.do")
	@ResponseBody //return값을 view로 인식하지 말고 콜백 메서드로 돌려보내렴
	public String delete(int idx) {
		int res = imdaein_dao.delete(idx);
		
		String result = "no";
		//삭제 성공 시
		if(res != 0) {
			result = "yes";
		}
		
		return result;
	}
}
