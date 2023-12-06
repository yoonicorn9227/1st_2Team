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
import com.java.www.dto.linkDto;

@WebServlet("/MD_Insert")
public class MD_Insert extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Modal - doAction");
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();

		String id = request.getParameter("id");
		String webName = request.getParameter("webName");
		String webURL = request.getParameter("webURL");
		System.out.println("id : " + id);
		System.out.println("ajax webName : " + webName);
		System.out.println("ajax webURL : " + webURL);

		// dao 접근
		linkDao ldao = new linkDao();
		linkDto ldto = ldao.dao_ModalInsert(id, webName, webURL);

		System.out.println("ser_ModalInsert ldto Pname: " + ldto.getPname());
		System.out.println("ser_ModalInsert ldto purl: " + ldto.getPurl());

		//json 형태로 보내기 
		JSONObject json = new JSONObject();
		json.put("webName",ldto.getPname());
		json.put("webURL",ldto.getPurl());
		
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

}// SerVlet(모달 컨트롤러)
