package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public MemberDAO() {
		try {

			Context init = new InitialContext();
			DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MysqlDB");
			conn = ds.getConnection();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void conClose() {
		try {
			if (rs != null)
				rs.close();
		} catch (Exception e) {
		}
		try {
			if (pstmt != null)
				pstmt.close();
		} catch (Exception e) {
		}
		try { 
			if (conn != null)
				conn.close();
		} catch (Exception e) {
		}
	}

	public int register(MemberVO memVO) {
		
		try {
			String input = "INSERT INTO member (user_id, nickname, password) VALUES (?,?,?)";
			pstmt = conn.prepareStatement(input);
			pstmt.setString(1, memVO.getUserId());
			pstmt.setString(2, memVO.getNickname());
			pstmt.setString(3, memVO.getPassword());

			int result = pstmt.executeUpdate();

			if (result > 0) {
				// 회원가입 성공
				return 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}finally {
			conClose();
		}
		
		return 0;
	}
	
	public MemberVO login(String name) {
		
		MemberVO memberVO = null;
		
		try {

			String sql = "select password, nickname from member where USER_ID = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, name);
			// SELECT 할 경우, ResultSet 필요
			rs = pstmt.executeQuery();

			// 결과값은 1개만 있으므로, if만 있어도 가능
			if (rs.next()) {
				memberVO = new MemberVO();
				String pw = rs.getString("password");
				String nickname = rs.getString("nickname");
				
				memberVO.setPassword(pw);
				memberVO.setNickname(nickname);
				
				return memberVO;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conClose();
		}

		return null;
		
	}
	
}
