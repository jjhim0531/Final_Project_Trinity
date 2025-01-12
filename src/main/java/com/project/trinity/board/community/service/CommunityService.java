package com.project.trinity.board.community.service;

import java.util.ArrayList;
import java.util.List;

import com.project.trinity.board.common.model.vo.BoardCategory;
import com.project.trinity.board.common.model.vo.BoardFile;
import com.project.trinity.board.common.model.vo.PageInfo;
import com.project.trinity.board.community.model.vo.Community;
import com.project.trinity.board.community.model.vo.MedAnswer;


public interface CommunityService {

    // 1. 게시글 관련 메서드
    int selectListCount(); // 전체 게시글 수 조회
    int getListCount(String categoryId); // 특정 카테고리 게시글 수 조회
    List<Community> selectListByCategory(String categoryId, PageInfo pi, String sortType); // 카테고리별 게시글 목록 조회
	int selectCountCategoryList(String type);
    Community viewDetailPage(String bno); // 특정 게시글 상세 조회
    int increaseCount(String bno); // 게시글 조회수 증가
    int insertBoard(Community b, String userNo); // 새 게시글 추가
    int updateBoard(Community b, ArrayList<BoardFile> fileList); // 게시글 수정
    int deleteBoard(String bno); // 게시글 삭제
    int adminDeleteBoard(String bno); // 관리자에 의한 게시글 삭제
    int restoreBoard(String bno); // 삭제된 게시글 복구
    String getCategoryNameById(String categoryId); // 카테고리 ID로 카테고리 이름 조회
    String getPreviousBoard(String bno); // 이전 게시글 조회
    String getNextBoard(String bno); // 다음 게시글 조회
    List<Community> getPostsByUserNo(String userNo); // 특정 사용자의 게시글 조회
    List<Community> getLatestBoardPosts(String ct); // 최신 게시글 목록 조회
    List<Community> getPostsByHosNo(String hosNo); // 특정 병원의 게시글 조회

    
    // 6. 답변 관련 메서드
    List<MedAnswer> getAnswersByBoardNo(String bno); // 특정 게시글의 답변 조회
    int saveAnswer(MedAnswer ans); // 답변 저장
    

	int insertBoardAC(Community b);

	Community selectBoardAC(String bno);

	



}


	

	
	
	
	

 