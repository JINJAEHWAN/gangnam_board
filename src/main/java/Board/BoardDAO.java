package Board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board.BoardVO;

public class BoardDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public BoardDAO() {
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MysqlDB");
			conn = ds.getConnection();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public List<BoardVO> boardList() {
		List<BoardVO> list = new ArrayList<>();
		
		return list;
	}
	
	public List<BoardVO> searchByKeyword(String keyword) {
		List<BoardVO> list = new ArrayList<>();
		
		return list;
	}
	
	public List<BoardVO> searchByCategory(String category) {
		List<BoardVO> list = new ArrayList<>();
		
		return list;
	}
	
	public List<BoardVO> searchByKeywordAndCategory(String keyword, String category) {
		List<BoardVO> list = new ArrayList<>();
		
		return list;
	}
	
	
	
	public void closeCon() {
		try { if(rs != null) rs.close(); } catch(Exception e) {}
		try { if(pstmt != null) pstmt.close(); } catch(Exception e) {}
		try { if(conn != null) conn.close(); } catch(Exception e) {}
	}

}
