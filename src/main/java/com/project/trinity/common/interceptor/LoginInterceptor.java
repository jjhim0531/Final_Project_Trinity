package com.project.trinity.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//return : true -> ������û�帧��� ����(Controller�� �̵�)
		//return : false -> ��û�ߴ��� ��ȯ
		System.out.println("���ͼ��� ������...");
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") != null) {
			System.out.println("���� ����");
			return true;
		} else {
			session.setAttribute("alertMsg", "�α��� �� �̿밡���� �����Դϴ�.");
			response.sendRedirect(request.getContextPath());
			System.out.println("���� �Ұ�");
			return false;
		}
	}
	
}