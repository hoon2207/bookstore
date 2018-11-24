package com.hoon.test;

import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.hoon.domain.BookVO;
import com.hoon.domain.Criteria;
import com.hoon.domain.SearchCriteria;
import com.hoon.persistence.BookDAO;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class BookDAOTest {
	
	@Inject
	private BookDAO dao;
	
	private static Logger logger = LoggerFactory.getLogger(BookDAOTest.class);
	
	@Test
	public void testCreate() throws Exception {
		BookVO book = new BookVO();
		book.setTitle("새로운 책");
		book.setAuthor("한정훈");
		book.setPublisher("출판사");
		book.setPubday("2018년 10월");
		book.setContent("책 설명");
		book.setPrice(1000);
		book.setQuantity(2);
		dao.create(book);
	}
	
	@Test
	public void testRead() throws Exception {
		logger.info(dao.read(2).toString());
	}
	
	@Test
	public void testUpdate() throws Exception {
		BookVO book = new BookVO();
		book.setBno(2);
		book.setTitle("수정된 책");
		dao.update(book);
	}
	
	@Test
	public void testDelete() throws Exception {
		dao.delete(1);
	}
	
	@Test
	public void testListPage() throws Exception {
		
		int page = 3;
		
		List<BookVO> list = dao.listPage(page);
		
		for(BookVO bookVO : list) {
			logger.info(bookVO.getBno() + ":" + bookVO.getTitle());
		}
	}
	
	@Test
	public void testListCriteria() throws Exception{
		
		SearchCriteria cri = new SearchCriteria();
		cri.setPage(2);
		cri.setPerPageNum(50);
		
		List<BookVO> list = dao.listCriteria(cri);
		
		for(BookVO bookVO : list) {
			logger.info(bookVO.getBno() + ":" + bookVO.getTitle());
		}
	}
	
	
	//UriComponentsBuilder
	@Test
	public void testURI() throws Exception {
		
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
				.path("/sbook/read")
				.queryParam("bno", 12)
				.queryParam("perPageNum", 20)
				.build();
		
		logger.info("/sbook/read?bno=12&perPageNum=20");
		logger.info(uriComponents.toString());
	}
	
	@Test
	public void testDynamic1() throws Exception {
		
		SearchCriteria cri = new SearchCriteria();
		cri.setPage(1);
		cri.setKeyword("글");
		cri.setSearchType("book");
		
		logger.info("===========================");
		
		List<BookVO> list = dao.listCriteria(cri);
		
		for (BookVO bookVO : list) {
			logger.info(bookVO.getBno() +": " + bookVO.getTitle());
		}
		
		logger.info("==========================");
		
		logger.info("COUNT: " + dao.countPaging(cri));
	}
}
