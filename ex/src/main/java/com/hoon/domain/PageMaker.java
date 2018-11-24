package com.hoon.domain;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageMaker {
	
	private int totalCount;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	
	//화면에 보여지는 페이지 번호의 수
	private int displayPageNum = 10;
	private Criteria cri;
		
	public void setCri(Criteria cri) {
		this.cri = cri;
	}
		
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		
		calcData();
	}
		
	private void calcData() {
		
		//끝 페이지 번호
		endPage = (int) (Math.ceil(cri.getPage() / (double) displayPageNum)*displayPageNum);
			
		//시작 페이지 번호
		startPage = (endPage - displayPageNum) + 1;
			
		//ex) 11~13 13
		int tempEndPage = (int) (Math.ceil(totalCount/ (double) cri.getPerPageNum()));
			
		if(endPage > tempEndPage) {
			endPage = tempEndPage;
		}
			
		prev = startPage == 1? false : true;
			
		next = endPage * cri.getPerPageNum() >= totalCount ? false : true;
	}
	
	// uri 작성 page, perPageNum
	public String makeQuery(int page) {
		
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("perPageNum", cri.getPerPageNum())
				.build();
		
		return uriComponents.toUriString();
	}
	
	//uri 문자열 생성
	public String makeSearch(int page) {
		
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("perPageNum", cri.getPerPageNum())
				.queryParam("searchType", ((SearchCriteria) cri).getSearchType())
				.queryParam("keyword", encoding(((SearchCriteria) cri).getKeyword()))
				.build();
		
		return uriComponents.toUriString();
	}
	
	private String encoding(String keyword) {
		
		if(keyword == null || keyword.trim().length() == 0) {
			return "";
		}
		
		try {
			return URLEncoder.encode(keyword, "UTF-8");
		}catch(UnsupportedEncodingException e) {
			return "";
		}
	}
	
	public int getTotalCount() {
		return totalCount;
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public boolean isNext() {
		return next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public Criteria getCri() {
		return cri;
	}
}
