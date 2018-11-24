package com.hoon.persistence;

import java.util.List;

import com.hoon.domain.BookVO;
import com.hoon.domain.Criteria;
import com.hoon.domain.SearchCriteria;

public interface BookDAO {
	
	//도서 등록
	public void create(BookVO vo) throws Exception;
	
	//도서 내용 가져오기
	public BookVO read(Integer bno) throws Exception;
	
	//도서 수정
	public void update(BookVO vo) throws Exception;
	
	//도서 삭제
	public void delete(Integer bno) throws Exception;
	
	//도서 목록
	public List<BookVO> listAll() throws Exception;
	
	//페이징 처리 기능
	public List<BookVO> listPage(int page) throws Exception;
	
	//리스트 출력
	public List<BookVO> listCriteria(SearchCriteria cri) throws Exception;
	
	//totalCount 반환
	public int countPaging(SearchCriteria cri) throws Exception;
	
	//댓글 수 변경
	public void updateReplyCnt() throws Exception;
	
	//이미지 파일 저장하는 기능
	public void addImage(String fullName) throws Exception;
	
	//이미지 파일 시간 순서대로 가져오는 기능
	public List<String> getImage(Integer bno) throws Exception;
	
	//이미지 파일 삭제
	public void deleteImage(Integer bno) throws Exception;
	
	//이미지 파일 수정
	public void replaceImage(String fullName, Integer bno) throws Exception;
	
	
	
}
