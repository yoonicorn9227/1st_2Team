package com.java.www.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.java.www.dao.Stu_boardDao;
import com.java.www.dto.Stu_boardDto;

public class Ser_ListSelectOne implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("session_id");

		// 변수선언
		int page = Integer.parseInt(request.getParameter("page"));
		int bsno = Integer.parseInt(request.getParameter("bsno"));
		String category = request.getParameter("category");
		String sword = request.getParameter("sword");

		// dao접근
		Stu_boardDao sbdao = new Stu_boardDao();
		Stu_boardDto sbdto = sbdao.dao_selectOne(bsno);

		// -------view
		String uri = request.getRequestURI();
		String cPath = request.getContextPath();
		String fileName = uri.substring(cPath.length());
		Stu_boardDto preDto = null;
		Stu_boardDto nextDto = null;
		if (fileName.equals("/b_view.do")) {
			// hit
			sbdao.bhitup(bsno);
			preDto = sbdao.preSelectOne(bsno);
			nextDto = sbdao.nextSelectOne(bsno);
		}

		// ------좋아요 (id,bsno)
		int my_like_count = sbdao.myLikeSelect(id, bsno);
		int all_like_count = sbdao.allLikeSelect(bsno);

		// request추가
		request.setAttribute("sbdto", sbdto);
		request.setAttribute("preDto", preDto);
		request.setAttribute("nextDto", nextDto);
		request.setAttribute("page", page);
		request.setAttribute("category", category);
		request.setAttribute("sword", sword);
		request.setAttribute("my_like_count", my_like_count);
		request.setAttribute("all_like_count", all_like_count);

	}// execute(Ser_ListSelectOne)
}// CLASS(게시글 1개)
