package com.project.trinity.community.summernote.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Page_controller {

	@RequestMapping("createPost")
	public String movePage(String page) {
	    if ("summernote".equals(page)) {
	        return "community/summernote";
	    }
	    return "community/summernote";
	}

	
}