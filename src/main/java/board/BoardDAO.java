package board;

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
		String sql = "SELECT * FROM TRAVEL_BOARD WHERE DEL_YN = 'N' ORDER BY BOARD_IDX DESC";
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardVO vo = new BoardVO();
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
				list.add(vo);
			}		
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			closeCon();
		}
		return list;
	}
	
	public List<BoardVO> searchByKeyword(String keyword) {
		List<BoardVO> list = new ArrayList<>();
		String sql = "SELECT * FROM TRAVEL_BOARD WHERE DEL_YN = N AND (BOARD_TITLE LIKE ? OR BOARD_CONTENT LIKE ?) ORDER BY BOARD_IDX DESC";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + keyword + "%");
			pstmt.setString(2, "%" + keyword + "%");
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			closeCon();
		}
		
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
