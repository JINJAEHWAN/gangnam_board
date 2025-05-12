package board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import servletController.Action;
import servletController.ActionForward;

public class BoardDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");	
		
		BoardDAO dao = new BoardDAO();
		BoardVO boardVO = new BoardVO();
		
		String idx = request.getParameter("board_idx");
		int boardIdx = Integer.parseInt(idx);
		
		dao.boardViewCount(boardIdx);
		boardVO = dao.boardDetail(boardIdx);
		
		dao.closeCon();
		
		request.setAttribute("boardVO", boardVO);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("board/boardDetail.jsp");
		
		return forward;
		
	}

}
