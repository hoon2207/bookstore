package com.hoon.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hoon.domain.BookVO;
import com.hoon.domain.PageMaker;
import com.hoon.domain.SearchCriteria;
import com.hoon.service.BookService;

@Controller
@RequestMapping("/sbook/*")
public class BookController {
	
	private static final Logger logger = LoggerFactory.getLogger(BookController.class);
	
	@Inject
	private BookService service;
	
	
	//도서 등록 페이지 이동
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void registerGET(BookVO book, Model model) throws Exception {
		
		logger.info("도서 등록 페이지 이동");
	}
	
	//도서 등록 실행
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registPOST(BookVO book, RedirectAttributes rttr) throws Exception {
		
		logger.info("도서 등록");
		logger.info(book.toString());
		
		service.regist(book);
		
		//한번만 사용되는 데이터 전송
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		return "redirect:/sbook/booklist";
	}
	
	//도서 목록 페이지 이동
	@RequestMapping(value = "/booklist", method = RequestMethod.GET)
	public void booklist(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		
		logger.info(cri.toString());
		
		
		model.addAttribute("list", service.listCriteria(cri));
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
		//totalCount 입력
		pageMaker.setTotalCount(service.listCountCriteria(cri));
		
		model.addAttribute("pageMaker", pageMaker);
	}
	
	//도서 조회 페이지 이동
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public void read(@RequestParam("bno") int bno, @ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		
		model.addAttribute(service.read(bno));
	}
	
	//도서 삭제 실행
	@RequestMapping(value = "/remove", method = RequestMethod.POST)
	public String remove(@RequestParam("bno") int bno, SearchCriteria cri, RedirectAttributes rttr) throws Exception {
		
		service.remove(bno);
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		//한번만 사용되는 데이터 전송
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		return "redirect:/sbook/booklist";
	}
	
	//도서 수정 페이지 이동
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public void modifyGET(@RequestParam("bno") int bno, @ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		
		model.addAttribute(service.read(bno));
	}
	
	//도서 수정 실행
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modifyPOST(BookVO book, SearchCriteria cri, RedirectAttributes rttr) throws Exception {
		
		logger.info("도서 수정");
		
		service.modify(book);
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		//한번만 사용되는 데이터 전송
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		return "redirect:/sbook/booklist";
	}
	
	// Ajax로 호출되는 특정 게시물의 첨부파일 처리
	@RequestMapping("/getImage/{bno}")
	@ResponseBody
	public List<String> getImage(@PathVariable("bno")Integer bno) throws Exception {
		
		return service.getImage(bno);
		
	}
}
