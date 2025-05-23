package servletController;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.BoardDeleteAction;
import board.BoardDetailAction;
import board.BoardLikeAction;
import board.BoardListAction;
import board.BoardUpdateAction;
import board.BoardUpdateResultAction;
import board.BoardWriteAction;


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
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		process(request, response);
	}
    
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
		
		if(command.equals("/deleteAction.co")) {
			action = new BoardDeleteAction();
		} else if (command.equals("/write.co")) {
			forward = new ActionForward();
			forward.setPath("board/boardWrite.jsp");
			forward.setRedirect(true);
		} 
		else if (command.equals("/writeAction.co")) {
			action = new BoardWriteAction();
		}
		else if (command.equals("/update.co")) {
			action = new BoardUpdateAction();
		} else if (command.equals("/updateAction.co")) {
			action = new BoardUpdateResultAction();
		} else if (command.equals("/list.co")) {
			action = new BoardListAction();
		} else if (command.equals("/detail.co")) {
			action = new BoardDetailAction();
		} else if (command.equals("/like.co")) {
			action = new BoardLikeAction();
		}
		
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
