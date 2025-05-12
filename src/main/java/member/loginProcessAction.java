package member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import servletController.*;

public class loginProcessAction implements Action {
	

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		// TODO Auto-generated method stub
		MemberDAO memDAO  = new MemberDAO();
		MemberVO memVO1 =new MemberVO();
		memVO1.setUserId(request.getParameter("userId"));
		memVO1.setPassword("password");
		MemberVO memVO2 = memDAO.login(memVO1.getUserId());
		
		
		
		return forward;
	}
	

}
