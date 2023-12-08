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

import com.java.www.dao.linkDao;

@WebServlet("/MD_Delete")
public class MD_Delete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Modal - doAction");
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();

		String id = request.getParameter("id");
		int pno = Integer.parseInt(request.getParameter("pno"));
		System.out.println("id : " + id);
		System.out.println("ajax pno: " + pno);

		// dao 접근
		linkDao ldao = new linkDao();
		int result = ldao.dao_ModalDelete(id, pno);

		System.out.println("ser_ModalDelete result : " + result);
		
		//하단 댓글 1개 ajax으로 보내기
		//json형태로 보내기 또는 xml ->html - 자바jsp
		JSONObject json = new JSONObject();
		json.put("result",result); //key, value

		response.setContentType("application/x-json; charset=UTF-8");
		PrintWriter writer = response.getWriter();
		writer.print(json);
		writer.close();

	}// doAction

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Modal doGet");
		doAction(request, response);
	}// doGet

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Modal doPost");
		doAction(request, response);
	}// doPost

}
