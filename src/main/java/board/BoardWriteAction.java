package board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ServletController.*;

public class BoardWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		ActionForward forward = new ActionForward();
		BoardDAO dao = new BoardDAO();
		BoardVO boardVO = new BoardVO();
		boardVO.setBoardTitle(request.getParameter("boardTitle"));
		boardVO.setBoardContent(request.getParameter("boardContent"));
		boardVO.setBoardCategory(request.getParameter("boardCategory"));
		boardVO.setTravelLocation(request.getParameter("travelLocation"));
		boardVO.setTravelPeriod(request.getParameter("travelPeriod"));
		boardVO.setTravelBudget(Integer.parseInt(request.getParameter("travelBudget")));
		
		HttpSession session = request.getSession();
		String user = null;
		if(session.getAttribute("userId") == null) {
			user = "admin";
		} else {
			user = (String) session.getAttribute("userId");
		}
		boardVO.setInstUser(user);
		boardVO.setUpdtUser(user);
		
		dao.boardInsert(boardVO);
		
		forward.setPath("list.co");
		forward.setRedirect(true);
				
		return forward;
	}
	
}
