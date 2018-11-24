package com.hoon.service;

import java.util.List;

import com.hoon.domain.BookVO;
import com.hoon.domain.SearchCriteria;

public interface BookService {
	
	public void regist(BookVO book) throws Exception;
	
	public BookVO read(Integer bno) throws Exception;
	
	public void modify(BookVO book) throws Exception;
	
	public void remove(Integer bno) throws Exception;
	
	public List<BookVO> listAll() throws Exception;
	
	public List<BookVO> listCriteria(SearchCriteria cri) throws Exception;
	
	public int listCountCriteria(SearchCriteria cri) throws Exception;
	
	public List<String> getImage(Integer bno) throws Exception;
	
}
