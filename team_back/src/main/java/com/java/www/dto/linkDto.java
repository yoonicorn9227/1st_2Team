package com.java.www.dto;

public class linkDto {

	private int pno;
	private String id;
	private String pname;
	private String purl;
	private String pfile;

	public linkDto() {
	}// 기본생성자

	public linkDto(int pno) {
		this.pno = pno;
		
	}// 1개 생성자
	
	public linkDto(int pno, String id, String pname, String purl) {
		this.pno = pno;
		this.id = id;
		this.pname = pname;
		this.purl = purl;
	}// 4개 생성자

	public linkDto(String id, String pname, String purl) {
		this.id = id;
		this.pname = pname;
		this.purl = purl;
	}// 3개 생성자

	public linkDto(int pno, String id, String pname, String purl, String pfile) {
		this.pno = pno;
		this.id = id;
		this.pname = pname;
		this.purl = purl;
		this.pfile = pfile;
	}// 전체생성자

	public int getPno() {
		return pno;
	}

	public void setPno(int pno) {
		this.pno = pno;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getPurl() {
		return purl;
	}

	public void setPurl(String purl) {
		this.purl = purl;
	}

	public String getPfile() {
		return pfile;
	}

	public void setPfile(String pfile) {
		this.pfile = pfile;
	}

}// linkDto
