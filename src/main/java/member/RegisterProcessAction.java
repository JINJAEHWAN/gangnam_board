package member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import servletController.Action;
import servletController.ActionForward;

public class RegisterProcessAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		MemberDAO memDAO = new MemberDAO();
		MemberVO memVO = new MemberVO();
		
		memVO.setUserId(request.getParameter("userId"));
		memVO.setNickname(request.getParameter("nickname"));
		memVO.setPassword(request.getParameter("password"));
		
		memDAO.register(memVO);
		
		return forward;
	}

}
