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

@WebServlet("/ReDelete")
public class ReDelete extends HttpServlet {
	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doAction");
		request.setCharacterEncoding("utf-8");
		
		int result = 0;
		int sno = Integer.parseInt(request.getParameter("sno"));
		
		Stu_boardDao sbdao = new Stu_boardDao();
		result = sbdao.Re_Dlelte(sno);
		
		JSONObject json = new JSONObject();
		json.put("result", result);
		
		response.setContentType("application/json");
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
