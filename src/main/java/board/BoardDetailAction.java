package board;

import java.util.List;

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
		List<BoardVO> list = null;
		
		
		
		
		
		return null;
		
	}

}
