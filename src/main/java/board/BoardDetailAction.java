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
		BoardVO vo = new BoardVO();
		
		String idx = request.getParameter("board_idx");
		int boardIdx = Integer.parseInt(idx);
		
		vo = dao.boardDetail(boardIdx);
		dao.boardViewCount(boardIdx);
		
		dao.closeCon();
		
		request.setAttribute("vo", vo);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("board/boardDetail.jsp");
		
		return null;
		
	}

}
