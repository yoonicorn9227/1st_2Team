package com.java.www.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.www.dao.Stu_boardDao;
import com.java.www.dto.Stu_boardDto;

public class Ser_ListSelectOne implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		//변수선언
		int page = Integer.parseInt(request.getParameter("page"));
		int bsno = Integer.parseInt(request.getParameter("bsno"));
		String category =request.getParameter("category");
		String sword =request.getParameter("sword");
		
		//dao접근
		Stu_boardDao sbdao = new Stu_boardDao();
		Stu_boardDto sbdto = sbdao.dao_selectOne(bsno);
		
		
		//request추가
		request.setAttribute("sbdto", sbdto);
		request.setAttribute("page", page);
		request.setAttribute("category", category);
		request.setAttribute("sword", sword);
		
	}//execute(Ser_ListSelectOne)
}// CLASS(게시글 1개)
