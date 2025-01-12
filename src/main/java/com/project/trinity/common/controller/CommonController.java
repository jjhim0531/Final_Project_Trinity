package com.project.trinity.common.controller;

import com.project.trinity.board.community.model.vo.Community;
import com.project.trinity.board.community.service.CommunityService;
import com.project.trinity.inquiry.model.service.InquiryService;
import com.project.trinity.member.service.MemberService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class CommonController {

	  private final CommunityService boardService;
	  private final InquiryService inquiryService;
	  private final MemberService memberService;
	 
	    @Autowired
	    public CommonController(CommunityService boardService, InquiryService inquiryService, MemberService memberService) {
	        this.boardService = boardService;
	        this.inquiryService = inquiryService;
	        this.memberService = memberService;
	    }

    @GetMapping("/main")
    public String main(Model m) {
    	 // �ֽ� �������� �Խñ� 3�� ��������
        List<Community> latestNoticePosts = inquiryService.getLatestInquiryPosts("CAT04"); // CAT04: �������� ID
        // �ֽ� �̺�Ʈ �Խñ� 3�� ��������
        List<Community> latestEventPosts = boardService.getLatestBoardPosts("CAT03"); // CAT03: �̺�Ʈ ID
        // ������ ���� ��, ȸ�� ��, �ǻ� �� ��������
        List<Integer> amountCount = memberService.selectCountList();
      
        System.out.println("Notice Posts: " + latestNoticePosts);
        System.out.println("Event Posts: " + latestEventPosts);
        // �𵨿� ������ �߰�
        m.addAttribute("latestNoticePosts", latestNoticePosts);
        m.addAttribute("latestEventPosts", latestEventPosts);
        m.addAttribute("amountCount", amountCount);
    
      
        // main.jsp�� �̵�
        return "main";
    }
}
