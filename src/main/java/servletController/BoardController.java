package servletController;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.BoardDeleteAction;

/**
 * Servlet implementation class BoardController
 */
@WebServlet("/BoardController")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		process(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String url = request.getRequestURI();
		String path = request.getContextPath();
		String command = url.substring(path.length());
		System.out.println("command: "+command);
		
		Action action = null;
		ActionForward forward = null;
		
		
		//나중에 페이지 이동 조건문 작성 필요
		
		if(command.equals("/deleteAction.co")) {
			action = new BoardDeleteAction();
		}
		//이후 else if 로 바꿔주세요. 그때 이 주석도 지워주세요.
		
		
		try {
			if(action != null) {
				forward = action.execute(request, response);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		if(forward.isRedirect()) {
			response.sendRedirect(forward.getPath());
		}
		else {
			RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
			dispatcher.forward(request, response);
		}
	}

}
