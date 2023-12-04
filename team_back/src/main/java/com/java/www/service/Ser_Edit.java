package com.java.www.service;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.java.www.dao.Stu_boardDao;
import com.java.www.dto.Stu_boardDto;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class Ser_Edit implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		//객체선언
		Stu_boardDao sbdao = new Stu_boardDao();
		
		//변수선언
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("session_id");
		int bsno = 0, page=1;
		String btitle = "", bcontent = "", bfile = "";

		//파일선언
		String uPath = "c:/upload";
		int size = 10*1024*1024;
				
		//파일이름 가져오기
		try {
			MultipartRequest multi = new MultipartRequest(request,uPath,size,"utf-8",new DefaultFileRenamePolicy());
			page = Integer.parseInt(multi.getParameter("page"));
			System.out.println("N_UpdateService page : "+page);
			bsno = Integer.parseInt(multi.getParameter("bsno"));
			btitle = multi.getParameter("btitle");
			bcontent = multi.getParameter("bcontent");
			
			System.out.println("btitle 확인 : "+btitle);
			
			//파일첨부가 되지 않았을때 이전파일을 그대로 사용
			bfile = multi.getParameter("oldfile");
			
			//파일첨부이름 가져오기
			Enumeration files = multi.getFileNames();
			while(files.hasMoreElements()) {
				String f = (String) files.nextElement(); //enum 형변환
				String tempfile = multi.getFilesystemName(f); //똑같은 파일이 있을경우 이름을 변경해서 저장
				if(tempfile !=null) bfile = tempfile;
			}
						
			//객체
			Stu_boardDto sbdto = new Stu_boardDto(bsno, btitle, bcontent, id, bfile);
			
			int result = sbdao.b_edit(sbdto);
			
			//request추가
			request.setAttribute("result", result);
			request.setAttribute("page", page);
			
		} catch (Exception e) { e.printStackTrace();}
	}

}
