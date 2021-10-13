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
import dao.KwanriDAO;
import vo.GonginVO;
import vo.GunmulVO;
import vo.ImdaeinVO;
import vo.KwanriVO;

@Controller
public class ManageController {
	@Autowired
	ServletContext application;
	@Autowired
	HttpServletRequest request;
	KwanriDAO kwanri_dao;
	ImdaeinDAO imdaein_dao;
	
	private int idx; //정보 수정에 필요
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	
	public ManageController(KwanriDAO kwanri_dao, ImdaeinDAO imdaein_dao) {
		this.kwanri_dao = kwanri_dao;
		this.imdaein_dao = imdaein_dao;
	}
	
	@RequestMapping("manage_hyoiwon.do")
	public String manage_hyoiwon(Model model) {
		List<GonginVO> gongList = kwanri_dao.selectGongList();
		List<ImdaeinVO> imList = kwanri_dao.selectImList();
		
		model.addAttribute("gongList", gongList);
		model.addAttribute("imList", imList);
		
		return Common.VIEW_PATH_M + "manage_hyoiwon.jsp";
	}
	
	//회원 정보 수정  폼으로 이동
	@RequestMapping("/user_modify_manage.do")
	public String user_modify_manage(Model model, String id) {
		KwanriVO vo = kwanri_dao.m_selectOne(id);
		model.addAttribute("vo", vo);
		return Common.VIEW_PATH_M+"user_modify_form.jsp";
	}
	
	//회원 정보 수정
	@RequestMapping("/manage_modify.do")
	public String manage_modify(KwanriVO vo, Model model, String id) {
		kwanri_dao.manage_modify(vo);
	    model.addAttribute("id", id);
	    request.setAttribute("manage_vo", vo);
	    return "budongsanmain.do";
	}
	
	//공인중개사 수정 폼으로 이동
	@RequestMapping("manage_hyoiwon_gongin_sujung.do")
	public String manage_hyoiwon_gongin_sujung(Model model, GonginVO vo) {
		if(vo != null) {
			model.addAttribute("vo", vo);
		}
		return Common.VIEW_PATH_M + "manage_hyoiwon_sujung_gongin.jsp";
	}
	
	//임대인 수정 폼으로 이동
	@RequestMapping("manage_hyoiwon_imdaein_sujung.do")
	public String manage_hyoiwon_imdaein_sujung(Model model, ImdaeinVO vo) {
		if(vo != null) {
			model.addAttribute("vo", vo);
		}
		return Common.VIEW_PATH_M + "manage_hyoiwon_sujung_imdaein.jsp";
	}
	
	//공인중개사 정보 수정하기
	@RequestMapping("manage_hyoiwon_gongin_update.do")
	public String manage_hyoiwon_gongin_update(GonginVO vo) {
		kwanri_dao.updateHyoiwonGongin(vo);
		
		return "redirect:manage_hyoiwon.do";
	}
	
	//임대인 정보 수정하기
	@RequestMapping("manage_hyoiwon_imdaein_update.do")
	public String manage_hyoiwon_imdaein_update(ImdaeinVO vo) {
		kwanri_dao.updateHyoiwonImdaein(vo);
		
		return "redirect:manage_hyoiwon.do";
	}
	
	//공인중개사 정보 삭제하기
	@RequestMapping("manage_hyoiwon_gongin_del.do")
	@ResponseBody
	public String manage_hyoiwon_gongin_del(int idx) {
		int res = kwanri_dao.delHyoiwonGongin(idx);
		
		String result = "no";
		//삭제 성공 시
		if(res != 0) {
			result = "yes";
		}
		
		return result;
	}
	
	//임대인 정보 삭제하기
	@RequestMapping("manage_hyoiwon_imdaein_del.do")
	@ResponseBody
	public String manage_hyoiwon_imdaein_del(int idx) {
		int res = kwanri_dao.delHyoiwonImdaein(idx);
		
		String result = "no";
		//삭제 성공 시
		if(res != 0) {
			result = "yes";
		}
		
		return result;
	}
	
	//전체 매물목록 페이지로 연결
	@RequestMapping("manage_gongin_login_list.do")
	public String manage_gongin_login_list( Model model ) {
		List<GunmulVO> list = kwanri_dao.selectgunregList();
		model.addAttribute("list", list);
		
		return Common.VIEW_PATH_M + "manage_gongin_login_list.jsp";
	}
	
	//전체 매물목록에서 매물 검색
	@RequestMapping("mng_searchRegion.do")
	public String mng_searchRegion(Model model, String searchRegion) {
		List<GunmulVO> list = kwanri_dao.selectgunregList(searchRegion);
		model.addAttribute("list", list);
		
		return Common.VIEW_PATH_M + "manage_gongin_login_list.jsp";
	}
	
	//등록된 매물목록 페이지로 연결
	@RequestMapping("manage_gongin_login_reg_list.do")
	public String manage_gongin_login_reg_list( Model model ) {
		List<GunmulVO> list = kwanri_dao.selectgunregList();
		model.addAttribute("list", list);
		
		return Common.VIEW_PATH_M + "manage_gongin_login_reg_list.jsp";
	}
	
	//전체 건물 관리 페이지로 연결
	@RequestMapping("total_gunmul_manage.do")
	public String total_gunmul_manage( Model model ) {
		List<GunmulVO> list = kwanri_dao.selectgunList();
		model.addAttribute("list", list);
		return Common.VIEW_PATH_M + "total_gunmul_manage.jsp";
	}
	
	//새건물 추가 페이지로 이동
	@RequestMapping("manage_gm_insert_form.do")
	public String manage_gm_insert_form() {
		return Common.VIEW_PATH_M + "manage_insert_form.jsp";
	}
	
	//새건물 추가
	@RequestMapping("manage_gm_insert.do")
	public String manage_gm_insert(Model model, MultipartHttpServletRequest mtfRequest, GunmulVO vo) {
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
		kwanri_dao.insert(vo);

		return "redirect:total_gunmul_manage.do";
	}
	
	//빌딩 등록하기
	@RequestMapping("manage_gongin_reg.do")
	@ResponseBody
	public String manage_gongin_reg(int idx) {
		int res = kwanri_dao.mnggonginUpdate(idx);
		
		String result = "no";
		//등록 성공 시
		if(res != 0) {
			result = "yes";
		}
		return result;
	}
	
	//전체보기에서 빌딩 수정 페이지 가기
	@RequestMapping("/manager_gm_modify_form.do")
	public String manager_gm_modify_form(Model model, int idx) {
		setIdx(idx);
		
		GunmulVO vo = imdaein_dao.selectOne(idx);
		
		if(vo != null) {
			model.addAttribute("vo", vo);
		}
		
		return Common.VIEW_PATH_M + "manage_kwanri_modify_form.jsp";
	}
	
	//수정하고 전체보기로 다시 가기
	@RequestMapping("manage_gm_update.do")
	public String manage_gm_update(Model model, GunmulVO vo) {
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
			kwanri_dao.update(vo);
			
			return "redirect:total_gunmul_manage.do";
		}
	
	//전체에서 삭제삭제
	@RequestMapping("manage_gm_delete.do")
	@ResponseBody
	public String manage_gm_delete(int idx) {
		int res = imdaein_dao.delete(idx);
		
		String result = "no";
		//삭제 성공 시
		if(res != 0) {
			result = "yes";
		}
		
		return result;
	}
	
	//매물 공인에서 내리기
	@RequestMapping("cancelReg.do")
	public String cancelReg(int idx) {
		kwanri_dao.cancel(idx);
		return "redirect:manage_gongin_login_reg_list.do";
	}
	
	//매물 공인에서 올리기
	@RequestMapping("reg.do")
	public String reg(int idx) {
		kwanri_dao.reg(idx);
		return "redirect:manage_gongin_login_list.do";
	}
}
