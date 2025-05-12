package board;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ServletController.Action;
import ServletController.ActionForward;

public class BoardListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");		
		
		BoardDAO dao = new BoardDAO();
		List<BoardVO> list = null;
		
		String keyword = request.getParameter("kewword");
		String category = request.getParameter("category");
		
//		if (keyword != null && !keyword.trim().isEmpty() && category != null && !category.trim().isEmpty()) {
//			list = dao.searchByKeywordAndCategory(keyword, category);
//		}
//		else if (keyword != null && !keyword.trim().isEmpty()) {
//			list = dao.searchByKeyword(keyword);
//		}
//		else if (category != null && !category.trim().isEmpty()) {
//			list = dao.searchByCategory(category);
//		}
//		else {
//			list = dao.boardList();
//		}
//		
		request.setAttribute("list", list);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/boardList.jsp");
		
		return forward;
	}
	
	
	
}
