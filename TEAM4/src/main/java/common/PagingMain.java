package common;
/*
	nowPage   : 현재 페이지
	rowTotal  : 전체 데이터 개수
	blockList : 한 페이지당 게시물 수
	blockPage : 한 화면에 나타낼 페이지 메뉴 수
 */
public class PagingMain {
	public static String getPaging(String pageURL, int nowPage, int rowTotal, int blockList, int blockPage) {
		int totalPage, //전체 페이지 수
            startPage, //시작 페이지 번호
            endPage;   //마지막 페이지 번호

		boolean isPrevPage, isNextPage;
		StringBuffer sb; //모든 상황을 판단하여 HTML코드를 저장할 곳
		
		isPrevPage = isNextPage = false;
		
		//입력된 전체 자원을 통해 전체 페이지 수를 구한다.
		totalPage = (int)(rowTotal/blockList);
		if(rowTotal % blockList != 0) totalPage++;

		//만약 잘못된 연산과 움직임으로 인해 현재 페이지 수가 전체 페이지 수를 넘을 경우
		//강제로 현재 페이지 값을 전체 페이지 값으로 변경
		if(nowPage > totalPage) nowPage = totalPage;

		//시작 페이지와 마지막 페이지를 구함
		startPage = (int)(((nowPage - 1) / blockPage) * blockPage + 1);
		endPage = startPage + blockPage - 1;
		
		//마지막 페이지 수가 전체 페이지 수보다 크면 마지막 페이지 값을 변경
		if(endPage > totalPage) endPage = totalPage;
		
		//마지막 페이지가 전체 페이지보다 작을 경우 다음 페이징이 적용될 수 있도록
		//boolean형 변수의 값을 설정
		if(endPage < totalPage) isNextPage = true;
		
		//시작 페이지의 값이 1보다 작으면 이전 페이징이 적용되도록 값 설정
		if(startPage > 1) isPrevPage = true;
		
		//HTML코드를 저장할 StringBuffer 생성 -> 코드 생성
		sb = new StringBuffer();
		
//-----그룹 페이지 처리 이전 --------------------------------------------------------------------------------------------		
		if(isPrevPage) {
			sb.append("<a href ='" + pageURL + "?page=");
			//sb.append(nowPage - blockPage);
			sb.append(startPage - 1);
			sb.append("'>prev</a>");
		} else
			sb.append("prev");
//------페이지 목록 출력 -------------------------------------------------------------------------------------------------
		//sb.append("|");
		for(int i = startPage; i <= endPage; i++) {
			if(i > totalPage) break;
			if(i == nowPage) { //현재 있는 페이지
				sb.append("&nbsp;<b><font color='#f00'>");
				sb.append(i);
				sb.append("</font></b>");
			} else{ //현재 페이지가 아니면
				sb.append("&nbsp;<a href='"+pageURL+"?page=");
				sb.append(i);
				sb.append("'>");
				sb.append(i);
				sb.append("</a>");
			}
		}
		
		sb.append("&nbsp;");
//-----그룹 페이지 처리 다음 ----------------------------------------------------------------------------------------------
		if(isNextPage){
			sb.append("<a href='"+pageURL+"?page=");
			sb.append(endPage + 1);
			/*if(nowPage+blockPage > totalPage) nowPage = totalPage;
			else
				nowPage = nowPage + blockPage;
			sb.append(nowPage);*/
			sb.append("'>next</a>");
		}
		else
			sb.append("next");
//---------------------------------------------------------------------------------------------------------------------	    

		return sb.toString();
	}
}