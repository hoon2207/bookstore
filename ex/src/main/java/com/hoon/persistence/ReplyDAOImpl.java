package com.hoon.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.hoon.domain.Criteria;
import com.hoon.domain.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "com.hoon.mapper.ReplyMapper";

	@Override //댓글 리스트
	public List<ReplyVO> list(Integer bno) throws Exception {
		return session.selectList(namespace+".list", bno);
	}

	@Override//댓글 등록
	public void create(ReplyVO vo) throws Exception {
		session.insert(namespace+".create", vo);
	}

	@Override// 댓글 수정
	public void update(ReplyVO vo) throws Exception {
		session.update(namespace+".update", vo);
	}

	@Override// 댓글 삭제
	public void delete(Integer rno) throws Exception {
		session.delete(namespace+".delete", rno);
	}

	@Override // 댓글 리스트
	public List<ReplyVO> listPage(Integer bno, Criteria cri) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		
		paramMap.put("bno", bno);
		paramMap.put("cri", cri);
		
		return session.selectList(namespace+".listPage", paramMap);
	}

	@Override // 댓글 수
	public int count(Integer bno) throws Exception {
		
		return session.selectOne(namespace+".count", bno);
	}

	@Override // 댓글이 삭제될 때 해당 게시물의 번호를 알아내는 기능
	public int getBno(Integer rno) throws Exception {
		return session.selectOne(namespace+".getBno", rno);
	}
	
}
