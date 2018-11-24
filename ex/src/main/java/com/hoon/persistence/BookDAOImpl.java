package com.hoon.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.hoon.domain.BookVO;
import com.hoon.domain.SearchCriteria;

@Repository
public class BookDAOImpl implements BookDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace ="com.hoon.mapper.BookMapper";
	
	@Override //도서 등록
	public void create(BookVO vo) throws Exception {
		session.insert(namespace+".create", vo);
	}

	@Override //도서 내용 가져오기
	public BookVO read(Integer bno) throws Exception {
		return session.selectOne(namespace+".read", bno);
	}

	@Override //도서 수정
	public void update(BookVO vo) throws Exception {
		session.update(namespace+".update", vo);
	}

	@Override //도서 삭제
	public void delete(Integer bno) throws Exception {
		session.delete(namespace+".delete", bno);
		
	}

	@Override //도서 목록
	public List<BookVO> listAll() throws Exception {
		return session.selectList(namespace+".listAll");
	}

	@Override //페이징 처리
	public List<BookVO> listPage(int page) throws Exception {
		
		if(page <= 0) {
			page = 1;
		}
		page = (page - 1) * 10;
		
		return session.selectList(namespace +".listPage", page);
	}

	@Override //리스트 출력
	public List<BookVO> listCriteria(SearchCriteria cri) throws Exception {
		
		return session.selectList(namespace+".listCriteria", cri);
	}

	@Override //totalCount 반환
	public int countPaging(SearchCriteria cri) throws Exception {
		
		return session.selectOne(namespace+".countPaging", cri);
	}

	@Override //댓글 수 계산
	public void updateReplyCnt() throws Exception {
		
		session.update(namespace+".updateReplyCnt");
		
	}

	@Override //이미지 파일 저장하는 기능
	public void addImage(String fullName) throws Exception {
		
		session.insert(namespace+".addImage", fullName);
		
	}

	@Override //이미지 파일 시간 순서대로 가져오는 기능
	public List<String> getImage(Integer bno) throws Exception {
			
		return session.selectList(namespace+".getImage", bno);
	}

	@Override // 이미지파일 삭제
	public void deleteImage(Integer bno) throws Exception {
		session.delete(namespace+".deleteImage", bno);
	}

	@Override // 이미지파일 수정
	public void replaceImage(String fullName, Integer bno) throws Exception {
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("bno", bno);
		paramMap.put("fullName", fullName);
		
		session.insert(namespace+".replaceImage", paramMap);
	}
	
}

