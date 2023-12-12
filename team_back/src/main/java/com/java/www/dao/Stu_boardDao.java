package com.java.www.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.java.www.dto.ScommentDto;
import com.java.www.dto.Stu_boardDto;

public class Stu_boardDao {

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	Stu_boardDto sbdto;
	ScommentDto scdto;
	ArrayList<Stu_boardDto> list = new ArrayList<Stu_boardDto>();
	String query, btitle, bcontent, id, bfile, spw, scontent;
	Timestamp bdate, sdate;
	int bsno, bgroup, bstep, bindent, bhit, sno;
	int listCount;
	int result;

	// ★커넥션풀에서 Connection객체 가져오기
	public Connection getConnection() {
		Connection connection = null;
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource) context.lookup("java:comp/env/jdbc/Oracle18");
			connection = ds.getConnection();
		} catch (Exception e) {e.printStackTrace();}
		return connection;
	}// getConnection

	// 1.게시글 전체 가져오기
	public ArrayList<Stu_boardDto> dao_Blist(int startRow, int endRow) {
		try {
			conn = getConnection();
			query = "select *from (select row_number() over(order by bgroup desc, bstep asc) rnum, a.*from stu_board a) where rnum between ? and ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				bsno = rs.getInt("bsno");
				btitle = rs.getString("btitle");
				bcontent = rs.getString("bcontent");
				bdate = rs.getTimestamp("bdate");
				id = rs.getString("id");
				bgroup = rs.getInt("bgroup");
				bstep = rs.getInt("bstep");
				bindent = rs.getInt("bindent");
				bhit = rs.getInt("bhit");
				bfile = rs.getString("bfile");
				list.add(new Stu_boardDto(bsno, btitle, bcontent, bdate, id, bgroup, bstep, bindent, bhit, bfile));
			} // while
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {e2.printStackTrace();}
		} // try
		return list;
	}// dao_Blist() 게시글 전체 메소드 : Select

	// 1-2.게시글 전체개수
	public int dao_ListCount() {
		try {
			conn = getConnection();
			query = "select count(*) listCount from stu_board";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				listCount = rs.getInt("listCount");
			} // if
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {e2.printStackTrace();}
		} // try
		return listCount;
	}// dao_ListCount() - 게시글 전체개수 메소드 : Select(Count)

	// 게시글 전체 가져오기/검색
	public ArrayList<Stu_boardDto> b_listSelect(String category, String sword, int startRow, int endRow) {
		try {
			conn = getConnection();
			if (category == null) {
				query = "select * from (select row_number() over (order by bgroup desc,bstep asc) rnum, a.* from stu_board a) where rnum between ? and ?";
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else if (category.equals("all")) {
				query = "select * from (select row_number() over (order by bgroup desc,bstep asc) rnum, a.* from stu_board a where btitle like '%'||?||'%' or bcontent like '%'||?||'%') where rnum between ? and ?";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, sword);
				pstmt.setString(2, sword);
				pstmt.setInt(3, startRow);
				pstmt.setInt(4, endRow);
			} else if (category.equals("btitle")) {
				query = "select * from (select row_number() over (order by bgroup desc,bstep asc) rnum, a.* from stu_board a where btitle like '%'||?||'%') where rnum between ? and ?";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, sword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			} else {
				query = "select * from (select row_number() over (order by bgroup desc,bstep asc) rnum, a.* from stu_board a where bcontent like '%'||?||'%') where rnum between ? and ?";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, sword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				bsno = rs.getInt("bsno");
				btitle = rs.getString("btitle");
				bcontent = rs.getString("bcontent");
				bdate = rs.getTimestamp("bdate");
				id = rs.getString("id");
				bgroup = rs.getInt("bgroup");
				bstep = rs.getInt("bstep");
				bindent = rs.getInt("bindent");
				bhit = rs.getInt("bhit");
				bfile = rs.getString("bfile");
				list.add(new Stu_boardDto(bsno, btitle, bcontent, bdate, id, bgroup, bstep, bindent, bhit, bfile));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {e2.printStackTrace();}
		} // try
		return list;
	}// b_listSelect

	// 게시글 전체개수
	public int bListCount(String category, String sword) {
		try {
			conn = getConnection();
			if (category == null) {
				query = "select count(*) listCount from stu_board";
				pstmt = conn.prepareStatement(query);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					listCount = rs.getInt("listCount");
				}
			} else if (category.equals("all")) {
				query = "select count(*) listCount from stu_board where btitle like '%'||?||'%' or bcontent like '%'||?||'%'";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, sword);
				pstmt.setString(2, sword);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					listCount = rs.getInt("listCount");
				}
			} else if (category.equals("btitle")) {
				query = "select count(*) listCount from stu_board where btitle like '%'||?||'%'";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, sword);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					listCount = rs.getInt("listCount");
				}
			} else {
				query = "select count(*) listCount from stu_board where bcontent like '%'||?||'%'";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, sword);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					listCount = rs.getInt("listCount");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {e2.printStackTrace();}
		} // try
		return listCount;
	}// bListCount

	// 2.게시글 1개 가져오기
	public Stu_boardDto dao_selectOne(int bsno2) {
		try {
			conn = getConnection();
			query = "select * from stu_board where bsno=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bsno2);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bsno = rs.getInt("bsno");
				btitle = rs.getString("btitle");
				bcontent = rs.getString("bcontent");
				bdate = rs.getTimestamp("bdate");
				id = rs.getString("id");
				bgroup = rs.getInt("bgroup");
				bstep = rs.getInt("bstep");
				bindent = rs.getInt("bindent");
				bhit = rs.getInt("bhit");
				bfile = rs.getString("bfile");
				sbdto = new Stu_boardDto(bsno, btitle, bcontent, bdate, id, bgroup, bstep, bindent, bhit, bfile);
			} // if
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {e2.printStackTrace();}
		} // try
		return sbdto;
	}// dao_selectOne() - 게시글 1개 보기 메소드 : Select

	// 3.게시글 삭제
	public int dao_Bdelete(int bsno2) {
		try {
			conn = getConnection();
			query = "delete from Stu_board where bsno=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bsno2);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {e2.printStackTrace();}
		} // try
		return result;
	}// dao_Bdelete() - 게시글 삭제 메소드 : Delete

	// 4.게시글 쓰기
	public int b_write(Stu_boardDto sbdto) {
		try {
			conn = getConnection();
			query = "insert into stu_board values(STU_BOARD_SEQ.nextval,?,?,sysdate,?,STU_BOARD_SEQ.currval,0,0,1,?)";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, sbdto.getBtitle());
			System.out.println("b_write btitle : " + sbdto.getBtitle());
			pstmt.setString(2, sbdto.getBcontent());
			pstmt.setString(3, sbdto.getId());
			pstmt.setString(4, sbdto.getBfile());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {e2.printStackTrace();}
		} // try
		return result;
	}// b_write

	// 작성글 수정
	public int b_edit(Stu_boardDto sbdto2) {
		try {
			conn = getConnection();
			query = "update stu_board set btitle=?, bcontent=?, bfile=? where bsno=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, sbdto2.getBtitle());
			pstmt.setString(2, sbdto2.getBcontent());
			pstmt.setString(3, sbdto2.getBfile());
			pstmt.setInt(4, sbdto2.getBsno());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {e2.printStackTrace();}
		} // try
		return result;
	}

	// 게시글 삭제
	public int b_delete(int bsno2) {
		try {
			conn = getConnection();
			query = "delete stu_board where bsno=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bsno2);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {e2.printStackTrace();}
		} // try
		return result;
	}// b_delete

	public void stepup(int bgroup2, int bstep2) {
		try {
			conn = getConnection();
			query = "update stu_board set bstep=bstep+1 where bgroup=? and bstep>?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bgroup2);
			pstmt.setInt(2, bstep2);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {e2.printStackTrace();}
		} // try
	}// stepup

	public int b_reply(Stu_boardDto sbdto2) {
		try {
			conn = getConnection();
			query = "insert into stu_board values(stu_board_seq.nextval,?,?,sysdate,?,?,?,?,1,?)";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, sbdto2.getBtitle());
			pstmt.setString(2, sbdto2.getBcontent());
			pstmt.setString(3, sbdto2.getId());
			pstmt.setInt(4, sbdto2.getBgroup());
			pstmt.setInt(5, sbdto2.getBstep() + 1);
			pstmt.setInt(6, sbdto2.getBindent() + 1);
			pstmt.setString(7, sbdto2.getBfile());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {e2.printStackTrace();}
		} // try
		return result;
	}

	// 이전글
	public Stu_boardDto preSelectOne(int bsno2) {
		try {
			conn = getConnection();
			query = "select * from (select row_number() over(order by bgroup desc, bstep asc) rnum, a.* from stu_board a) where rnum = (select rnum from (select row_number() over(order by bgroup desc, bstep asc) rnum, a.* from stu_board a) where bsno=?)+1";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bsno2);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bsno = rs.getInt("bsno");
				btitle = rs.getString("btitle");
				bcontent = rs.getString("bcontent");
				bdate = rs.getTimestamp("bdate");
				id = rs.getString("id");
				bgroup = rs.getInt("bgroup");
				bstep = rs.getInt("bstep");
				bindent = rs.getInt("bindent");
				bhit = rs.getInt("bhit");
				bfile = rs.getString("bfile");
				sbdto = new Stu_boardDto(bsno, btitle, bcontent, bdate, id, bgroup, bstep, bindent, bhit, bfile);
			}//if
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {e2.printStackTrace();}
		} // try
		return sbdto;
	}// preSelectOne

	// 다음글
	public Stu_boardDto nextSelectOne(int bsno2) {
		try {
			conn = getConnection();
			query = "select * from (select row_number() over(order by bgroup desc, bstep asc) rnum, a.* from stu_board a) where rnum = (select rnum from (select row_number() over(order by bgroup desc, bstep asc) rnum, a.* from stu_board a) where bsno=?)-1";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bsno2);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bsno = rs.getInt("bsno");
				btitle = rs.getString("btitle");
				bcontent = rs.getString("bcontent");
				bdate = rs.getTimestamp("bdate");
				id = rs.getString("id");
				bgroup = rs.getInt("bgroup");
				bstep = rs.getInt("bstep");
				bindent = rs.getInt("bindent");
				bhit = rs.getInt("bhit");
				bfile = rs.getString("bfile");
				sbdto = new Stu_boardDto(bsno, btitle, bcontent, bdate, id, bgroup, bstep, bindent, bhit, bfile);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {e2.printStackTrace();}
		} // try
		return sbdto;
	}// nextSelectOne

	// 조회수
	public void bhitup(int bsno2) {
		try {
			conn = getConnection();
			query = "update stu_board set bhit = bhit+1 where bsno=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bsno2);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {e2.printStackTrace();}
		} // try

	}// bhitup

	// 좋아요 (내가 좋아요 누른 상태 - select)
	public int myLikeSelect(String id2, int bsno2) {
		int my_like_count = 0;
		try {
			conn = getConnection();
			query = "select count(*) my_like_count from s_likes where bsno=? and id=? and like_status=1";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bsno2);
			pstmt.setString(2, id2);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				my_like_count = rs.getInt("my_like_count");
			}//while
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {e2.printStackTrace();}
		} // try
		return my_like_count;
	}// myLikeSelect

	// 좋아요 (전체 좋아요 개수 - select)
	public int allLikeSelect(int bsno2) {
		int all_like_count = 0;
		try {
			conn = getConnection();
			query = "select count(*) all_like_count from s_likes where bsno=? and like_status=1";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bsno2);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				all_like_count = rs.getInt("all_like_count");
			}//while
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {e2.printStackTrace();}
		} // try
		return all_like_count;
	}// allLikeSelect

	//
	public int myLikeUpdate(String id2, int bsno2, int like_status) {
		int all_like_count = 0;
		try {
			conn = getConnection();
			// 내가 좋아요를 누른 적이 있는지 체크
			query = "select count(*) count from s_likes where bsno=? and id=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bsno2);
			pstmt.setString(2, id2);
			rs = pstmt.executeQuery();
			int count = 0;
			if (rs.next()) {
				count = rs.getInt("count");
			}//if
			if (count == 0) {
				// 내가 좋아요 누른 적이 없을때 - insert
				query = "insert into s_likes values (s_likes_seq.nextval, ?,?,?)";
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, bsno2);
				pstmt.setString(2, id2);
				pstmt.setInt(3, like_status);
				pstmt.executeUpdate();
			} else {
				// 내가 좋아요 누른적이 있을때 - update
				query = "update s_likes set like_status=? where bsno=? and id=?";
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, like_status);
				pstmt.setInt(2, bsno2);
				pstmt.setString(3, id2);
				pstmt.executeUpdate();
			}//if-else
			// 좋아요 전체
			all_like_count = allLikeSelect(bsno2);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {e2.printStackTrace();}
		} // try
		return all_like_count;
	}// myLikeUpdate

	// 댓글 모두 가져오기
		public ArrayList<ScommentDto> commSelectAll(int bsno2) {
			ArrayList<ScommentDto> slist = new ArrayList();
			try {
				conn = getConnection();
				query = "select * from s_comment where bsno=? order by sno desc";
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, bsno2);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					sno = rs.getInt("sno");
					System.out.println("Stu_boardDao ScommentDto sno : "+sno);
					bsno = rs.getInt("bsno");
					id = rs.getString("id");
					spw = rs.getString("spw");
					scontent = rs.getString("scontent");
					sdate = rs.getTimestamp("sdate");
					slist.add(new ScommentDto(sno, bsno, id, spw, scontent, sdate));
				}
			}catch (Exception e) {	e.printStackTrace();
			}finally {
				try {
					if(rs!=null) rs.close();
					if(pstmt!=null) pstmt.close();
					if(conn!=null) conn.close();
				} catch (Exception e2) { e2.printStackTrace();}
			}
			return slist;
		}
		
		//하단댓글 1개 저장 및 검색
		public ScommentDto S_Insert(int bsno2, String id2, String spw2, String scontent2) {
			try {
				conn = getConnection();
				//select = nextval sno 가져오기
				query = "select s_comment_seq.nextval sno from dual";
				pstmt = conn.prepareStatement(query);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					sno = rs.getInt("sno");
					System.out.println("Stu_boardDao S_Insert sno : " + sno);
				}
				
				//insert - 하단댓글 1개 저장
				query = "insert into s_comment values(?,?,?,?,?,sysdate)";
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, sno);
				pstmt.setInt(2, bsno2);
				pstmt.setString(3, id2);
				pstmt.setString(4, spw2);
				pstmt.setString(5, scontent2);
				pstmt.executeUpdate();
				
				//select - 하단댁글 1개 가져오기
				query = "select * from s_comment where sno=?";
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, sno);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					sno = rs.getInt("sno");
					System.out.println("Stu_boardDao S_Insert sno : " + sno);
					bsno = rs.getInt("bsno");
					id = rs.getString("id");
					spw = rs.getString("spw");
					scontent = rs.getString("scontent");
					sdate = rs.getTimestamp("sdate");
					scdto = new ScommentDto(sno, bsno, id, spw, scontent, sdate);
				}
			}catch (Exception e) { e.printStackTrace();
			}finally {
				try {
					if(rs!=null) rs.close();
					if(pstmt!=null) pstmt.close();
					if(conn!=null) conn.close();
				} catch (Exception e2) { e2.printStackTrace();}
			}
			return scdto;
		}

	// 댓글 삭제 - Re_Delete
	public int Re_Dlelte(int sno2) {
		try {
			conn = getConnection();
			query = "delete from s_comment where sno=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, sno2);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {e2.printStackTrace();}
		} // try
		System.out.println(result);
		return result;
	}//Re_Dlelte

	// 댓글 수정메소드 - Update
	public int Re_Edit(int sno2, String e_content) {
		try {
			conn = getConnection();
			query = "update s_comment set scontent=?, sdate=sysdate where sno=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, e_content);
			pstmt.setInt(2, sno2);
			System.out.println("Re_Edit : "+sno2);
			result = pstmt.executeUpdate();
			System.out.println("Dao Re_Edit result : "+result);
		} catch (Exception e) {	e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) { e2.printStackTrace();}
		}//try
		return result;
	}//Re_Edit()

}// BoardDao
