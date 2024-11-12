package com.project.trinity.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.trinity.member.model.vo.Member;
import com.project.trinity.member.service.MemberService;

@Controller
public class MemberController {
	private final MemberService memberService;
	//private final BCryptPasswordEncoder bcryptPasswordEncoder;
	
	//의존성 주입
	@Autowired
	public MemberController(MemberService memberService, BCryptPasswordEncoder bcryptPasswordEncoder) {
		this.memberService = memberService;
		//this.bcryptPasswordEncoder = bcryptPasswordEncoder;
	}
	
	//
	@RequestMapping("login.me")
	public String loginMember(String userId, String userPwd, HttpSession session, Model model) {
		Member m = new Member(userId, userPwd);
		Member loginMember = memberService.loginMember(m);
		
		if (loginMember == null) {
			System.out.println("로그인 실패");
			model.addAttribute("errorMsg", "로그인실패"); // requestScope에 에러문구를 담는다.
			
			// /WEB-INF/views/common/errorPage.jsp
			return "main";
		} else {
			session.setAttribute("loginUser", loginMember);
			System.out.println("로그인 성공");
			
			// /WEB-INF/views/main.jsp
			return "main";
		}
	}
	
	@RequestMapping("logout.me")
	public String logoutMember(HttpSession session) {
		session.invalidate();
		
		return "redirect:/";
	}
	
}
