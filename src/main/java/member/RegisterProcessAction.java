package member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import servletController.Action;
import servletController.ActionForward;

public class RegisterProcessAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("회원가입시작");
		ActionForward forward = new ActionForward();
		MemberDAO memDAO = new MemberDAO();
		MemberVO memVO = new MemberVO();
		
		memVO.setUserId(request.getParameter("userId"));
		memVO.setNickname(request.getParameter("nickname"));
		memVO.setPassword(request.getParameter("password"));
		
		int result = memDAO.register(memVO);
		
		if(result >0) {
			System.out.println("회원가입성공");
			forward.setPath("login.me");
			forward.setRedirect(true);
		}else {
			forward.setPath("register.me");
			forward.setRedirect(false);
		}
		
		return forward;
	}

}
