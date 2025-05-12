package board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import servletController.Action;
import servletController.ActionForward;

public class BoardUpdateResultAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		BoardVO boardVO = new BoardVO();
		boardVO.setBoardIdx(Integer.parseInt(request.getParameter("board_idx")));
		boardVO.setBoardTitle(request.getParameter("board_title"));
		boardVO.setBoardContent(request.getParameter("board_content"));
		boardVO.setTravelLocation(request.getParameter("travel_location"));
		boardVO.setTravelPeriod(request.getParameter("travel_period"));
		boardVO.setTravelBudget(Integer.parseInt(request.getParameter("travel_budget")));
		boardVO.setBoardCategory(request.getParameter("board_category"));
		
		BoardDAO dao = new BoardDAO();
		dao.boardUpdate(boardVO);
		
		ActionForward forward = new ActionForward();
		forward.setPath("list.co");
		forward.setRedirect(true);
		
		return forward;
	}
	

}
