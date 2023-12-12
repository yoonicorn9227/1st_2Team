package com.java.www.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.java.www.dao.Stu_boardDao;
import com.java.www.dto.ScommentDto;

/**
 * Servlet implementation class SInsert
 */
@WebServlet("/SInsert")
public class SInsert extends HttpServlet {
	
	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doAction");
		request.setCharacterEncoding("utf-8");
		
		int bsno = Integer.parseInt(request.getParameter("bsno"));
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("session_id");
		//String id = "aaa";
		String spw = request.getParameter("spw");
		String scontent = request.getParameter("scontent");
		System.out.println("SInsert bsno : "+bsno);
		
		ScommentDto scdto = null;
		Stu_boardDao sbdao = new Stu_boardDao();
		scdto = sbdao.S_Insert(bsno, id, spw, scontent);
		
		System.out.println("SInsert sno : "+scdto.getSno());
		
		//하단댓글 1개 ajax으로 보내기
		JSONObject json = new JSONObject();
		json.put("sno", scdto.getSno());
		json.put("id", scdto.getId());
		json.put("scontent", scdto.getScontent());
		json.put("sdate",""+ scdto.getSdate());
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/x-json charset=utf-8");
		PrintWriter writer = response.getWriter();
		writer.print(json);
		writer.close();
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGet");
		doAction(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost");
		doAction(request, response);
	}

}
