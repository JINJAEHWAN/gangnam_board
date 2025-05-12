package Board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ServletController.Action;
import ServletController.ActionForward;



public class BoardDeleteAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        
        // 로그인하지 않은 경우
        if (userId == null) {
            response.sendRedirect("/login.me");
            return null;
        }
        
        int boardIdx = Integer.parseInt(request.getParameter("board_idx"));
        BoardDAO dao = new BoardDAO();
        
        // 게시글 작성자 확인
        BoardVO boardVO = dao.boardDetail(boardIdx);
        if (!userId.equals(boardVO.getInstUser())) {
            response.sendRedirect("list.co");
            return null;
        }
        
        // 게시글 삭제 (DEL_YN을 'Y'로 업데이트)
        System.out.println("board_idx: "+boardIdx);
        dao.boardDelete(boardIdx);
        
        ActionForward forward = new ActionForward();
        forward.setPath("list.co");
        forward.setRedirect(true);
        
        return forward;
    }
}
