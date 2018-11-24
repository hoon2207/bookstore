package com.hoon.domain;

public class Criteria {
	
	private int page; //페이지 번호
	private int perPageNum; // 리스트당 데이터의 수
	
	
	public Criteria() {
		this.page = 1;
		this.perPageNum = 10;
	}
	
	
	//페이지 번호 설정 함수
	public void setPage(int page) {
		
		if(page <= 0) {
			this.page = 1;
			return;
		}
		
		this.page = page;
	}
	
	//리스트당 데이터의 수 설정 함수
	public void setPerPageNum(int perPageNum) {
		
		if(perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
	}
	
	public int getPage() {
		return page;
	}
	
	public int getPerPageNum() {
		return this.perPageNum;
	}
	
	//시작 데이터 번호 구하는 함수
	public int getPageStart() {
		return (this.page - 1) * perPageNum;
	}


	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + "]";
	}
	

}
