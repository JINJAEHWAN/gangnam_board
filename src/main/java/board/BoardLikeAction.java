package board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import servletController.Action;
import servletController.ActionForward;

public class BoardLikeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		 request.setCharacterEncoding("UTF-8");
	     response.setCharacterEncoding("UTF-8");
	     
	     // 로그인 체크
	     HttpSession session = request.getSession();
	     String userId = (String) session.getAttribute("userId");
	     
	     if (userId == null) {
	    	 //로그인하지 않은 경우 로그인 페이지로 리다이렉트
	    	 ActionForward forward = new ActionForward();
	    	 forward.setRedirect(true);
	    	 forward.setPath("login.co");
	    	 return forward;
	     }
	     
	     // 게시글 번호 가져오기
	     int boardIdx = Integer.parseInt(request.getParameter("board_idx"));
	     
	     // 좋아요 처리
	     BoardVO boardVO = (BoardVO) request.getAttribute("boardVO");
         if (userId != null && !userId.equals(boardVO.getInstUser())) {
        	 BoardDAO dao = new BoardDAO();
        	 dao.boardLikeCount(boardIdx);     	 
         }
	     
	     // 상세 페이지로 리다이렉트
	     ActionForward forward = new ActionForward();
	     forward.setRedirect(true);
	     forward.setPath("detail.co?board_idx=" + boardIdx);
		
	     return forward;
	}

}
