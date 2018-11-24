package com.hoon.service;

import java.util.Date;

import com.hoon.domain.UserVO;
import com.hoon.dto.LoginDTO;

public interface UserService {
	
	public UserVO login(LoginDTO dto) throws Exception;
	
	//로그인한 사용자의 sessionKey 와 sesssionLimit를 업데이트하는 기능
	public void keepLogin(String uid, String sessionId, Date next) throws Exception;
		
	//loginCookie에 기록된 값으로 정보를 조회하는 기능을 추가
	public UserVO checkLoginBefore(String value);
	
	//회원가입
	public void regist(UserVO user) throws Exception;
	
}
