package com.hoon.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hoon.domain.Criteria;
import com.hoon.domain.ReplyVO;
import com.hoon.persistence.BookDAO;
import com.hoon.persistence.ReplyDAO;

@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Inject
	private ReplyDAO replyDAO;
	
	@Inject
	private BookDAO bookDAO;
	

	@Override
	public List<ReplyVO> listReply(Integer bno) throws Exception {
		return replyDAO.list(bno);
	}
	
	@Transactional
	@Override
	public void addReply(ReplyVO vo) throws Exception {
		
		replyDAO.create(vo);
		bookDAO.updateReplyCnt();
	}

	@Override
	public void modifyReply(ReplyVO vo) throws Exception {
		replyDAO.update(vo);
	}
	
	@Transactional
	@Override
	public void removeReply(Integer rno) throws Exception {
		
		replyDAO.delete(rno);
		bookDAO.updateReplyCnt();
	}

	@Override
	public List<ReplyVO> listReplyPage(Integer bno, Criteria cri) throws Exception {
		return replyDAO.listPage(bno, cri);
	}

	@Override
	public int count(Integer bno) throws Exception {
		return replyDAO.count(bno);
	}
	
	
	
}
