package vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class GunmulVO {
	private int idx;
	private String gun_name; //건물 이름
	private String floor; //층, 건물 층수
	private String bang_num; //호(ex:101)
	private String gujo; //원룸/투룸
	private String gun_img_s; //작은 이미지
	private String gun_img_l; //큰 이미지
	private String addr; //주소
	private String gun_park; //주차
	private String gun_option; //건물 옵션
	private String content; //건물 상세정보
	private String square; //면적(m2)
	private int ref; //건물주 idx
	
	private String seipja_name; //세입자 이름
	private String seipja_tel; //세입자 전화번호
	private String seipja_date_begin; //세입자 계약 체결일
	private String seipja_date_end; //세입자 계약 만료일
	
	public String getSeipja_date_begin() {
		return seipja_date_begin;
	}
	public void setSeipja_date_begin(String seipja_date_begin) {
		this.seipja_date_begin = seipja_date_begin;
	}
	public String getSeipja_date_end() {
		return seipja_date_end;
	}
	public void setSeipja_date_end(String seipja_date_end) {
		this.seipja_date_end = seipja_date_end;
	}
	private int bojung; //보증금
	private int weolse; //월세
	private int susuryo; //수수료
	
	private int reg_gyeyak_info; //등록 및 계약 여부에 따라 알림 & 매물 목록에서 숨기기
	private int yeyak_gongin_idx;
	private String addr_num; //경도 및 위도
	
	private MultipartFile photo_s;
	private List<MultipartFile> photo_l;
	private String[] gun_img_arr;
	private int file_gaesu;
	private String[] gun_op_arr;
	private String dong; //경도 및 위도저장
	
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}
	public int getYeyak_gongin_idx() {
		return yeyak_gongin_idx;
	}
	public void setYeyak_gongin_idx(int yeyak_gongin_idx) {
		this.yeyak_gongin_idx = yeyak_gongin_idx;
	}
	public String getGun_park() {
		return gun_park;
	}
	public void setGun_park(String gun_park) {
		this.gun_park = gun_park;
	}
	public String[] getGun_op_arr() {
		return gun_op_arr;
	}
	public void setGun_op_arr(String[] gun_op_arr) {
		this.gun_op_arr = gun_op_arr;
	}
	public String getGun_option() {
		return gun_option;
	}
	public void setGun_option(String gun_option) {
		this.gun_option = gun_option;
	}
	public int getFile_gaesu() {
		return file_gaesu;
	}
	public void setFile_gaesu(int file_gaesu) {
		this.file_gaesu = file_gaesu;
	}
	public String[] getGun_img_arr() {
		return gun_img_arr;
	}
	public void setGun_img_arr(String[] gun_img_arr) {
		this.gun_img_arr = gun_img_arr;
	}
	public List<MultipartFile> getPhoto_l() {
		return photo_l;
	}
	public void setPhoto_l(List<MultipartFile> photo_l) {
		this.photo_l = photo_l;
	}
	public String getAddr_num() {
		return addr_num;
	}
	public void setAddr_num(String addr_num) {
		this.addr_num = addr_num;
	}
	public MultipartFile getPhoto_s() {
		return photo_s;
	}
	public void setPhoto_s(MultipartFile photo_s) {
		this.photo_s = photo_s;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getGun_name() {
		return gun_name;
	}
	public void setGun_name(String gun_name) {
		this.gun_name = gun_name;
	}
	public String getFloor() {
		return floor;
	}
	public void setFloor(String floor) {
		this.floor = floor;
	}
	public String getBang_num() {
		return bang_num;
	}
	public void setBang_num(String bang_num) {
		this.bang_num = bang_num;
	}
	public String getGujo() {
		return gujo;
	}
	public void setGujo(String gujo) {
		this.gujo = gujo;
	}
	public String getGun_img_s() {
		return gun_img_s;
	}
	public void setGun_img_s(String gun_img_s) {
		this.gun_img_s = gun_img_s;
	}
	public String getGun_img_l() {
		return gun_img_l;
	}
	public void setGun_img_l(String gun_img_l) {
		this.gun_img_l = gun_img_l;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSquare() {
		return square;
	}
	public void setSquare(String square) {
		this.square = square;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public String getSeipja_name() {
		return seipja_name;
	}
	public void setSeipja_name(String seipja_name) {
		this.seipja_name = seipja_name;
	}
	public String getSeipja_tel() {
		return seipja_tel;
	}
	public void setSeipja_tel(String seipja_tel) {
		this.seipja_tel = seipja_tel;
	}
	public int getBojung() {
		return bojung;
	}
	public void setBojung(int bojung) {
		this.bojung = bojung;
	}
	public int getWeolse() {
		return weolse;
	}
	public void setWeolse(int weolse) {
		this.weolse = weolse;
	}
	public int getSusuryo() {
		return susuryo;
	}
	public void setSusuryo(int susuryo) {
		this.susuryo = susuryo;
	}
	public int getReg_gyeyak_info() {
		return reg_gyeyak_info;
	}
	public void setReg_gyeyak_info(int gyeyak_info) {
		this.reg_gyeyak_info = gyeyak_info;
	}
}
