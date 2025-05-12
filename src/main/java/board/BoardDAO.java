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
	
	public BoardVO boardDetail(int boardIdx) {		
		BoardVO vo = new BoardVO();
		String sql = "SELECT * FROM TRAVEL_BOARD WHERE BOARD_IDX = ? AND DEL_YN = 'N'";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardIdx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
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
		} 
		catch(Exception e) {
			e.printStackTrace();
		} 
		finally {
			closeCon();
		}
		return vo;
	}
	
	public int boardViewCount(int boardIdx) {
		int result = 0;
		String sql = "UPDATE TRAVEL_BOARD SET VIEW_COUNT = VIEW_COUNT + 1 WHERE BOARD_IDX = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardIdx);
			result = pstmt.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
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
		catch(Exception e) {
			e.printStackTrace();
		} 
		finally {
			closeCon();
		}
		return list;
	}
	
	public List<BoardVO> searchByKeyword(String keyword) {
		List<BoardVO> list = new ArrayList<>();
		String sql = "SELECT * FROM TRAVEL_BOARD WHERE DEL_YN = 'N' AND (BOARD_TITLE LIKE ? OR BOARD_CONTENT LIKE ?) ORDER BY BOARD_IDX DESC";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + keyword + "%");
			pstmt.setString(2, "%" + keyword + "%");
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
	
	public List<BoardVO> searchByCategory(String category) {
		List<BoardVO> list = new ArrayList<>();
		String sql = "SELECT * FROM TRAVEL_BOARD WHERE DEL_YN = 'N' AND BOARD_CATEGORY = ? ORDER BY BOARD_IDX DESC";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, category);
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

	public List<BoardVO> searchByKeywordAndCategory(String keyword, String category) {
		List<BoardVO> list = new ArrayList<>();
		String sql = "SELECT * FROM TRAVEL_BOARD WHERE DEL_YN = 'N' AND (BOARD_TITLE LIKE ? OR BOARD_CONTENT LIKE ?) AND BOARD_CATEGORY = ? ORDER BY BOARD_IDX DESC";
				
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + keyword + "%");
			pstmt.setString(2, "%" + keyword + "%");
			pstmt.setString(3, category);
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
	
	// BoardLikeAction
	public int boardLikeCount(int boardIdx) {
		int result = 0;
		String sql = "UPDATE TRAVEL_BOARD SET LIKE_COUNT = LIKE_COUNT + 1 WHERE BOARD_IDX = ?";
		
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
}
