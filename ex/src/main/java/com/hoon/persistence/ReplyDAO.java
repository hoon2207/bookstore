package com.hoon.persistence;

import java.util.List;

import com.hoon.domain.Criteria;
import com.hoon.domain.ReplyVO;

public interface ReplyDAO {
	
	//댓글 리스트
	public List<ReplyVO> list(Integer bno) throws Exception;
	
	//댓글 등록
	public void create(ReplyVO vo) throws Exception;
	
	//댓글 수정
	public void update(ReplyVO vo) throws Exception;
	
	//댓글 삭제
	public void delete(Integer rno) throws Exception;
	
	//댓글 페이징 처리
	public List<ReplyVO> listPage(Integer bno, Criteria cri) throws Exception;
	
	//댓글 수
	public int count(Integer bno) throws Exception;
	
	//댓글이 삭제될 때 해당 게시물의 번호를 알아내는 기능
	public int getBno(Integer rno) throws Exception;
	
}
