package com.java.www.service;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.java.www.dao.Stu_boardDao;
import com.java.www.dto.Stu_boardDto;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class Ser_Reply implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		Stu_boardDao sbdao = new Stu_boardDao();
		
		//변수선언
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("session_id");
		String btitle = "", bcontent = "", bfile = "";
		int bgroup = 0, bstep = 0, bindent = 0, page = 1;
		
		String upload = "c:/upload";
		int size = 10*1024*1024;
		
		try {
			MultipartRequest multi = new MultipartRequest(request, upload, size, "utf-8", new DefaultFileRenamePolicy());
			page = Integer.parseInt(multi.getParameter("page"));
			btitle = multi.getParameter("btitle");
			bcontent = multi.getParameter("bcontent");
			bgroup = Integer.parseInt(multi.getParameter("bgroup"));
			bstep = Integer.parseInt(multi.getParameter("bstep"));
			bindent = Integer.parseInt(multi.getParameter("bindent"));
			
			Enumeration files = multi.getFileNames();
			while(files.hasMoreElements()) {
				String f = (String)files.nextElement();
				bfile = multi.getFilesystemName(f);
			}
			
			Stu_boardDto sbdto = new Stu_boardDto(btitle, bcontent, id, bgroup, bstep, bindent, bfile);
			
			// bstep 큰수들을 1씩 증가
			sbdao.stepup(bgroup, bstep);
			// 답글달기 저장
			int result  = sbdao.b_reply(sbdto);
			
			request.setAttribute("result", result);
			request.setAttribute("page", page);
			
		} catch (Exception e) { e.printStackTrace();
		}
	}

}
