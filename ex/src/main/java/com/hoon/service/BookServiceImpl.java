package com.hoon.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hoon.domain.BookVO;
import com.hoon.domain.SearchCriteria;
import com.hoon.persistence.BookDAO;

@Service
public class BookServiceImpl implements BookService {

	@Inject
	private BookDAO dao;
	
	@Transactional
	@Override
	public void regist(BookVO book) throws Exception {
		
		dao.create(book);
		
		String[] files = book.getFiles();
		
		if(files == null) { return; }
		
		for(String fileName : files) {
			dao.addImage(fileName);
		}
	}

	@Override
	public BookVO read(Integer bno) throws Exception {
		return dao.read(bno);
	}
	
	@Transactional
	@Override
	public void modify(BookVO book) throws Exception {
		dao.update(book);
		
		Integer bno = book.getBno();
		
		dao.deleteImage(bno);
		
		String[] files = book.getFiles();
		
		if(files == null) { return; }
		
		for(String fileName : files) {
			dao.replaceImage(fileName, bno);
		}
	}
	
	@Transactional
	@Override
	public void remove(Integer bno) throws Exception {
		
		dao.deleteImage(bno);
		dao.delete(bno);
	}

	@Override
	public List<BookVO> listAll() throws Exception {
		return dao.listAll();
	}

	@Override
	public List<BookVO> listCriteria(SearchCriteria cri) throws Exception {
		return dao.listCriteria(cri);
	}

	@Override
	public int listCountCriteria(SearchCriteria cri) throws Exception {
		return dao.countPaging(cri);
	}
	
	@Override
	public List<String> getImage(Integer bno) throws Exception {
		
		return dao.getImage(bno);
	}

}
