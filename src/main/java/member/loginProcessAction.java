package member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import servletController.*;

public class loginProcessAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		MemberDAO memDAO = new MemberDAO();
		MemberVO memVO1 = new MemberVO();

		/****************************
		 * 로그인, login Form에서 request 처리 과정
		 ***************************/
		memVO1.setUserId(request.getParameter("userId"));
		memVO1.setPassword(request.getParameter("password"));

		/****************************
		 * 로그인, DAO 유효성 검사 과정
		 ***************************/
		MemberVO memVO2 = memDAO.login(memVO1.getUserId());

		/****************************
		 * 로그인, 성공 프로세스
		 ****************************/
		if (memVO2 != null && memVO2.getPassword().equals(memVO1.getPassword())) {
			forward.setPath("list.co");
			forward.setRedirect(true);
			System.out.println("로그인 o");

			// 세션 등록 과정
			HttpSession session = request.getSession();
			session.setAttribute("userId", request.getParameter("userId"));
			session.setAttribute("userNick", memVO2.getNickname());
			return forward;

		}

		/****************************
		 * 로그인, 실패 프로세스
		 ***************************/
		forward.setPath("login.me");
		return forward;
	}

}
