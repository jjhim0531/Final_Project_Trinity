package com.project.trinity.board.common.model.vo;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.project.trinity.board.common.model.vo.PageInfo;

public class Template {

	/**
	 * 
	 * @param listCount : 총 게시글 수
	 * @param currentPage : 현재페이지
	 * @param pageLimit : 하단에 보여질 페이징바의 수
	 * @param boardLimit : 한 페이지에 보여질 게시글 최대 수
	 * @return PageInfo
	 */
	public static PageInfo getPageInfo(int listCount, int currentPage, int pageLimit, int boardLimit) {
	    int maxPage = (int)Math.ceil((double)listCount / boardLimit); // 가장 마지막 페이지
	    int startPage = ((currentPage - 1) / pageLimit) * pageLimit + 1; // 페이징바의 시작
	    int endPage = startPage + pageLimit - 1; // 페이징바의 마지막

	    endPage = endPage > maxPage ? maxPage : endPage;

	    // startRow와 endRow 계산
	    int startRow = (currentPage - 1) * boardLimit + 1;
	    int endRow = startRow + boardLimit - 1;

	    // 생성자 호출 (startRow와 endRow를 포함하여 전달)
	    PageInfo pi = new PageInfo(listCount, currentPage, pageLimit, boardLimit, maxPage, startPage, endPage, startRow, endRow);

	    return pi;
	}

	public static String saveFile(MultipartFile upfile, HttpSession session, String path) {
		//파일원본명
		String originName = upfile.getOriginalFilename(); 
		
		//확장자
		String ext = originName.substring(originName.lastIndexOf("."));
		 
		//년월일시분초
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		
		//5자리 랜덤값
		int randNum = (int)(Math.random() * 90000) + 10000;
		
		String changeName = currentTime + "_" + randNum + ext;
		
		//첨부파일 저장할 폴더의 물리적 경로
		String savePath = session.getServletContext().getRealPath(path);
		
		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		return changeName;
	}
}