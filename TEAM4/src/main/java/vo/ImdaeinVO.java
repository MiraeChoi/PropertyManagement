package vo;

import java.util.List;

public class ImdaeinVO {
	private int idx;
	private String name;
	private String id;
	private String pwd;
	private String gun_name;
	private String tel;
	private String email;
	
	List<GunmulVO> gm_list;
	
	public List<GunmulVO> getGm_list() {
		return gm_list;
	}
	public void setGm_list(List<GunmulVO> gm_list) {
		this.gm_list = gm_list;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getGun_name() {
		return gun_name;
	}
	public void setGun_name(String gun_name) {
		this.gun_name = gun_name;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
}
