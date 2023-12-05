package com.java.www.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.java.www.dao.linkDao;
import com.java.www.dto.linkDto;

public class Ser_MainModal implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {

		// 변수선언
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("session_id");
		String webName = request.getParameter("webName");
		String webURL = request.getParameter("webURL");
		System.out.println("id : " + id);
		System.out.println("webName : " + webName);
		System.out.println("webURL : " + webURL);

		// dao접근
		linkDao ldao = new linkDao();
		ArrayList<linkDto> list = ldao.dao_ModalInstList(id);
		System.out.println("Ser list : " + list);
		
		// request추가
		request.setAttribute("list", list);

	}// execute(Ser_MainModal)

}// CLASS(모달창 - 즐겨찾기)
