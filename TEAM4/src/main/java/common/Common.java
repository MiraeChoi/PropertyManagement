package common;

public class Common {
	//부동산 메인 관련 jsp 경로
	public static final String VIEW_PATH = "WEB-INF/views/budongsan/";
	
	//관리사 관련 jsp 경로
	public static final String VIEW_PATH_M = "WEB-INF/views/manage/";
	
	//공인중개사 관련 jsp 경로
	public static final String VIEW_PATH_G = "WEB-INF/views/gongin/";
		
	//임대인 관련 jsp 경로
	public static final String VIEW_PATH_I = "WEB-INF/views/imdae/";
	
	//게시판별 관리를 편하게 하기 위한 클래스
	public static class Board{
		//한 페이지당 보여줄 게시물 수
		public final static int BLOCKLIST = 7;
		//한 화면에 보여지는 페이지 메뉴 수
		//◀  1 2 3 4 5  ▶
		public final static int BLOCKPAGE = 2;
	}
	
	//공지사항 게시판
	public static class Notice{
		//한 페이지당 보여줄 게시물 수
		public final static int BLOCKLIST = 5;
		//한 화면에 보여지는 페이지 메뉴 수
		//◀  1 2 3 4 5  ▶
		public final static int BLOCKPAGE = 3;
	}
}
