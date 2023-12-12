package com.java.www.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.java.www.dao.Stu_boardDao;

@WebServlet("/ReEdit")
public class ReEdit extends HttpServlet {
	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doAction");
		request.setCharacterEncoding("utf-8");
		
		int result = 0;
		int sno = Integer.parseInt(request.getParameter("sno"));
		String e_content = request.getParameter("e_content");
		System.out.println("ReEdit sno : "+ request.getParameter("sno"));
		System.out.println("ReEdit e_content : "+ request.getParameter("e_content"));
		
		Stu_boardDao sbdao = new Stu_boardDao();
		result = sbdao.Re_Edit(sno, e_content);
		
		JSONObject json = new JSONObject();
		json.put("result", result);
		System.out.println("ReEdit result : "+result);
		
		response.setContentType("application/json;charset=UTF-8"); 
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
