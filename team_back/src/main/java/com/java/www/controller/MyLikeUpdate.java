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

@WebServlet("/MyLikeUpdate")
public class MyLikeUpdate extends HttpServlet {
	
	
	
	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doAction");
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("session_id");
		int bsno = Integer.parseInt(request.getParameter("bsno"));
		int like_status = Integer.parseInt(request.getParameter("like_status"));
		
		System.out.println("MLU bsno :"+bsno);
		System.out.println("MLU like_status :"+like_status);
		
		//dao접근
		Stu_boardDao sbdao = new Stu_boardDao();
		int all_like_count = sbdao.myLikeUpdate(id,bsno,like_status);
		System.out.println("Con all_like_count : "+all_like_count);
		
		//ajax 전송
		JSONObject json = new JSONObject();
		json.put("all_like_count", all_like_count);
		response.setContentType("application/x-json; charset=utf-8");
		PrintWriter writer = response.getWriter();
		writer.print(json);
		writer.close();
		
	}
	
	
	
	
	//-----
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost");
		doAction(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost");
		doAction(request, response);
	}

}
