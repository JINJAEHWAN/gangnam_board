package board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import servletController.Action;
import servletController.ActionForward;

public class BoardUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		ActionForward forward = new ActionForward();
		BoardDAO dao = new BoardDAO();
		String idx = request.getParameter("board_idx");
		
		int boardIdx = Integer.parseInt(idx);
		BoardVO boardVO = dao.boardDetail(boardIdx);
		
		request.setAttribute("boardVO", boardVO);
		
		forward.setRedirect(false);
		forward.setPath("./boardUpdate.jsp");
		return forward;
	}

}
