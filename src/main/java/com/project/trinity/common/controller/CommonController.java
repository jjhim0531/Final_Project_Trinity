package com.project.trinity.common.controller;

import com.project.trinity.community.board.service.BoardService;
import com.project.trinity.community.board.model.vo.Board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class CommonController {

	  private final BoardService boardService;
	 

	    @Autowired
	    public CommonController(BoardService boardService) {
	        this.boardService = boardService;
	      
	    }

    @GetMapping("/main")
    public String main(Model m) {
    	 // 최신 공지사항 게시글 3개 가져오기
        List<Board> latestNoticePosts = boardService.getLatestPosts("CAT04"); // CAT01: 공지사항 ID
        // 최신 이벤트 게시글 3개 가져오기
        List<Board> latestEventPosts = boardService.getLatestPosts("CAT03"); // CAT03: 이벤트 ID

        // 모델에 데이터 추가
        m.addAttribute("latestNoticePosts", latestNoticePosts);
        m.addAttribute("latestEventPosts", latestEventPosts);
        System.out.println("Latest Notice Posts: " + latestNoticePosts);
        System.out.println("Latest Event Posts: " + latestEventPosts);

        // main.jsp로 이동
        return "main";
    }
}
