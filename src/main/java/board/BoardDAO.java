package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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

	
	public BoardVO boardDetail(int boardIdx) {
		BoardVO vo = null;
		String sql = "SELECT * FROM TRAVEL_BOARD WHERE BOARD_IDX = ? AND DEL_YN = 'N'";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardIdx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo = new BoardVO();
				vo.setBoardIdx(rs.getInt("BOARD_IDX"));
				vo.setBoardTitle(rs.getString("BOARD_TITLE"));
				vo.setBoardContent(rs.getString("BOARD_CONTENT"));
				vo.setBoardCategory(rs.getString("BOARD_CATEGORY"));
				vo.setTravelLocation(rs.getString("TRAVEL_LOCATION"));
				vo.setTravelPeriod(rs.getString("TRAVEL_PERIOD"));
				vo.setTravelBudget(rs.getInt("TRAVEL_BUDGET"));
				vo.setViewCount(rs.getInt("VIEW_COUNT"));
				vo.setLikeCount(rs.getInt("LIKE_COUNT"));
				vo.setInstUser(rs.getString("INST_USER"));
				vo.setInstDate(rs.getString("INST_DATE"));
				vo.setUpdtUser(rs.getString("UPDT_USER"));
				vo.setUpdtDate(rs.getString("UPDT_DATE"));
				vo.setDelYn(rs.getString("DEL_YN"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			//closeCon();
		}
		return vo;
	}
	
	public int boardDelete(int boardIdx) {
		int result = 0;
		String sql = "UPDATE TRAVEL_BOARD SET DEL_YN = 'Y' WHERE BOARD_IDX = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardIdx);
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			closeCon();
		}
		return result;
	}
	
	//BoardUpdateResultAction
	public int boardUpdate(BoardVO vo) {
		int result = 0;
		String sql = "UPDATE TRAVEL_BOARD SET BOARD_TITLE = ?, BOARD_CONTENT = ?, BOARD_CATEGORY = ?, TRAVEL_LOCATION = ?, TRAVEL_PERIOD = ?, TRAVEL_BUDGET = ?, UPDT_USER = ?, UPDT_DATE = NOW() WHERE BOARD_IDX = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getBoardTitle());
			pstmt.setString(2, vo.getBoardContent());
			pstmt.setString(3, vo.getBoardCategory());
			pstmt.setString(4, vo.getTravelLocation());
			pstmt.setString(5, vo.getTravelPeriod());
			pstmt.setInt(6, vo.getTravelBudget());
			pstmt.setString(7, vo.getUpdtUser());
			pstmt.setInt(8, vo.getBoardIdx());
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			closeCon();
		}
		return result;
	}
}
