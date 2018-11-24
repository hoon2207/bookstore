package com.hoon.controller;

import java.util.Date;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import com.hoon.domain.BookVO;
import com.hoon.domain.UserVO;
import com.hoon.dto.LoginDTO;
import com.hoon.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	
	@Inject
	private UserService service;
	
	@RequestMapping(value = "/login", method=RequestMethod.GET)
	public void loginGET(@ModelAttribute("dto") LoginDTO dto) {

	}
	
	@RequestMapping(value = "/loginPost", method=RequestMethod.POST)
	public void loginGET(LoginDTO dto, HttpSession session, Model model) throws Exception {
		
		UserVO vo = service.login(dto);
		
		if(vo == null) {
			return;
		}
		
		model.addAttribute("userVO", vo);
		
		if(dto.isUseCookie()) {
			
			int amount = 60 * 60 * 24 * 7;
			
			Date sessionLimit = new Date(System.currentTimeMillis()+(100*amount));
			
			service.keepLogin(vo.getUid(), session.getId(), sessionLimit);
		}
	}
	
	//로그아웃 처리
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		Object object = session.getAttribute("login");
		
		if(object != null) {
			UserVO vo = (UserVO) object;
			
			session.removeAttribute("login");
			session.invalidate();
			
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			
			if(loginCookie != null) {
				loginCookie.setPath("/");
				loginCookie.setMaxAge(0);
				response.addCookie(loginCookie);
				service.keepLogin(vo.getUid(), session.getId(), new Date());
			}
		}
		return "user/logout";
	}
	
	//회원가입 페이지 이동
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void registerGET(UserVO user, Model model) throws Exception {
		
		logger.info("도서 등록 페이지 이동");
	}
	
	//회원 가입 실행
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registPOST(UserVO user, RedirectAttributes rttr) throws Exception {
		
		logger.info("회원 가입");
		
		service.regist(user);
		
		//한번만 사용되는 데이터 전송
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		return "redirect:/user/login";
	}
}
