package com.java.www.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.java.www.dto.linkDto;

public class linkDao {

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int pno, result;
	String query, id, pname, purl, pfile;
	ArrayList<linkDto> list = new ArrayList();
	linkDto ldto = null;

	// ★커넥션풀에서 Connection객체 가져오기
	public Connection getConnection() {
		Connection connection = null;
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource) context.lookup("java:comp/env/jdbc/Oracle18");
			connection = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return connection;
	}// getConnection

	public ArrayList<linkDto> dao_ModalInstList(String id2) {
		try {
			conn = getConnection();
			query = "select * from link where id =? order by pno asc";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id2);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				pno = rs.getInt("pno");
				id = rs.getString("id");
				pname = rs.getString("pname");
				purl = rs.getString("purl");
				pfile = rs.getString("pfile");
				System.out.println("dao_ModalList pno : " + pno);
				System.out.println("id : " + id);
				System.out.println("pname : " + pname);
				System.out.println("purl : " + purl);
				System.out.println("pfile : " + pfile);
				list.add(new linkDto(pno, id, pname, purl, pfile));
			} // while
			if(list.size()==0) list=null;
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
	}// dao_ModalInst
	
	public int dao_ModalView(String id2, String webName, String webURL) {
		try {
			query="insert into link values (link_seq.nextval,?,?,?,'link3.png')";
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, id2);
			pstmt.setString(2, webName);
			pstmt.setString(3, webURL);
			result=pstmt.executeUpdate();
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
	}//dao_ModalView

	public linkDto dao_ModalInsert(String id2, String webName, String webURL) {
		try {
			conn=getConnection();
			//select - nextval pno가져오기
			query = "select link_seq.nextval pno from dual";
			pstmt=conn.prepareStatement(query);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				pno = rs.getInt("pno");
				System.out.println("dao MD_insert pno : "+pno);
			}//while
			
			//insert - 즐겨찾기 1개 저장
			query="insert into link values (?,?,?,?,'link3.png')";
			pstmt=conn.prepareStatement(query);
			pstmt.setInt(1, pno);
			pstmt.setString(2, id2);
			pstmt.setString(3, webName);
			pstmt.setString(4, webURL);
			pstmt.executeUpdate();
			
			//select - 즐겨찾기 1개 가져오기
			query="select * from link where id=?";
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, id2);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				pno=rs.getInt("pno");
				id=rs.getString("id");
				pname=rs.getString("pname");
				purl=rs.getString("purl");
				pfile=rs.getString("pfile");
				ldto=new linkDto(pno, id, pname, purl, pfile);
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
		return ldto;
	}//linkDto

	public int dao_ModalDelete(String id2, int pno2) {
		try {
			conn=getConnection();
			query="delete from link where id=? and pno=?";
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, id2);
			pstmt.setInt(2, pno2);
			result=pstmt.executeUpdate();
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
	}//dao_ModalDelete()
}// linkDao
