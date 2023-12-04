package com.java.www.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.www.dao.Stu_boardDao;
import com.java.www.dto.Stu_boardDto;

public class Ser_ListSelect implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// dao 접근 - select
		Stu_boardDao sbdao = new Stu_boardDao();

		// 검색
		String category = request.getParameter("category");
		String sword = request.getParameter("sword");

		// -----하단 넘버링
		int rowPage = 10;
		int bottomPage = 10;
		int page = 1;
		if (request.getParameter("page") != null)
			page = Integer.parseInt(request.getParameter("page"));

		// 게시글 수
		int listCount = sbdao.bListCount(category, sword);

		int maxPage = (int) Math.ceil((double) listCount / rowPage);
		int startPage = (int) ((page - 1) / bottomPage) * bottomPage + 1;
		int endPage = startPage + bottomPage - 1;
		if (endPage > maxPage)
			endPage = maxPage;
		int startRow = (page - 1) * rowPage + 1;
		int endRow = startRow + rowPage - 1;
		// ----------넘버링 끝

		ArrayList<Stu_boardDto> list = sbdao.b_listSelect(category, sword, startRow, endRow);

		//request추가
		request.setAttribute("list", list);
		request.setAttribute("page", page);
		request.setAttribute("listCount", listCount);
		request.setAttribute("maxPage", maxPage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("category", category);
		request.setAttribute("sword", sword);
	}//execute(Ser_ListSelect)
}// CLASS
