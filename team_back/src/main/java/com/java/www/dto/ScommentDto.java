package com.java.www.dto;

import java.sql.Timestamp;

public class ScommentDto {
	
	public ScommentDto() {}
	public ScommentDto(int sno, int bsno, String id, String spw, String scontent, Timestamp sdate) {
		super();
		this.sno = sno;
		this.bsno = bsno;
		this.id = id;
		this.spw = spw;
		this.scontent = scontent;
		this.sdate = sdate;
	}
	public ScommentDto(int bsno, String id, String spw, String scontent) {
		super();
		this.bsno = bsno;
		this.id = id;
		this.spw = spw;
		this.scontent = scontent;
	}

	private int sno;
	private int bsno;
	private String id;
	private String spw;
	private String scontent;
    private Timestamp sdate;
    
	public int getSno() {
		return sno;
	}
	public void setSno(int sno) {
		this.sno = sno;
	}
	public int getBsno() {
		return bsno;
	}
	public void setBsno(int bsno) {
		this.bsno = bsno;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSpw() {
		return spw;
	}
	public void setSpw(String spw) {
		this.spw = spw;
	}
	public String getScontent() {
		return scontent;
	}
	public void setScontent(String scontent) {
		this.scontent = scontent;
	}
	public Timestamp getSdate() {
		return sdate;
	}
	public void setSdate(Timestamp sdate) {
		this.sdate = sdate;
	}

}
