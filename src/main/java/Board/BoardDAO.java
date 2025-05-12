package Board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


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
	
	public void closeCon() {
		try { if(rs != null) rs.close(); } catch(Exception e) {}
		try { if(pstmt != null) pstmt.close(); } catch(Exception e) {}
		try { if(conn != null) conn.close(); } catch(Exception e) {}
	}
	
	
	//BoardWriteAction
	public int boardInsert(BoardVO vo) {
		int result = 0;
		String sql = "INSERT INTO TRAVEL_BOARD (BOARD_TITLE, BOARD_CONTENT, BOARD_CATEGORY, TRAVEL_LOCATION, TRAVEL_PERIOD, TRAVEL_BUDGET, INST_USER, UPDT_USER) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getBoardTitle());
			pstmt.setString(2, vo.getBoardContent());
			pstmt.setString(3, vo.getBoardCategory());
			pstmt.setString(4, vo.getTravelLocation());
			pstmt.setString(5, vo.getTravelPeriod());
			pstmt.setInt(6, vo.getTravelBudget());
			pstmt.setString(7, vo.getInstUser());
			pstmt.setString(8, vo.getInstUser());
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			closeCon();
		}
		return result;
	}

}
