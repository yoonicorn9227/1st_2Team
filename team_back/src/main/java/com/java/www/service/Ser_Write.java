package com.java.www.service;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.java.www.dao.Stu_boardDao;
import com.java.www.dto.Stu_boardDto;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class Ser_Write implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		//객체선언
		Stu_boardDao sbdao = new Stu_boardDao();
		
		//변수선언
		String btitle = "", bcontent = "", id = "", bfile = "";
		HttpSession session = request.getSession();
		id = (String) session.getAttribute("session_id");
		
		int result = 0;
		Stu_boardDto sbdto = null;
		//파일선언
		String upath = "c:/upload";
		int size = 10*1024*1024;
		
		//파일이름 가져오기
		try {
			MultipartRequest multi = new MultipartRequest(request, upath, size,"utf-8",new DefaultFileRenamePolicy());
		    btitle = multi.getParameter("btitle");
		    bcontent = multi.getParameter("bcontent");
		    id = multi.getParameter("id");
			
			//파일첨부이름 가져오기
		    Enumeration files = multi.getFileNames();
		    while(files.hasMoreElements()) {
		    	String f = (String)files.nextElement();
		    	bfile = multi.getFilesystemName(f);
			}
			sbdto  = new Stu_boardDto(btitle, bcontent, id, bfile);
			result = sbdao.b_write(sbdto);
			System.out.println("Ser_Write result : "+result);
			
		} catch (Exception e) {e.printStackTrace();}

	}

}
