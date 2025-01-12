package com.project.trinity.board.common.service;

import java.util.ArrayList;
import java.util.List;

import com.project.trinity.board.common.model.vo.BoardCategory;
import com.project.trinity.board.common.model.vo.BoardFile;
import com.project.trinity.board.common.model.vo.Comment;
import com.project.trinity.board.common.model.vo.Like;



public interface BoardCommonService {
	 // 1. 댓글 관련 메서드
	List<Comment> selectComments(String refNo, String boardType);
    int insertComment(Comment r); // 댓글 추가
    int deleteComment(String commentNo); // 댓글 삭제

    // 2. 좋아요/싫어요 관련 메서드
    int getLikeCount(String commentNo); // 댓글의 좋아요 수 조회
    int getDislikeCount(String commentNo); // 댓글의 싫어요 수 조회
    Like getCurrentLikeState(String commentNo, String userNo); // 특정 사용자의 좋아요/싫어요 상태 조회
    void deleteLikeDislike(String commentNo, String userNo); // 좋아요/싫어요 기록 삭제
    void insertLikeDislike(String commentNo, String userNo, int isLike); // 좋아요/싫어요 추가
    void updateLikeDislike(String commentNo, String userNo, int isLike); // 좋아요/싫어요 상태 업데이트
	
    
 // 2. 파일 관련 메서드
    int insertFile(BoardFile bf); // 첨부파일 추가
    BoardFile getSingleFile(String fileNo); // 특정 파일 정보 조회
    List<BoardFile> getFileList(String bno); // 특정 게시글의 모든 첨부파일 조회
    int deleteAllFilesByBoardNo(String bno); // 특정 게시글의 모든 첨부파일 삭제
    int deleteFile(String fileNo); // 특정 파일 삭제
    int updateFileAllowDownload(BoardFile bf); // 파일 다운로드 허용 여부 수정

   

    // 5. 카테고리 관련 메서드
    List<BoardCategory> getCategories(); // 카테고리 목록 조회
	int insertFileAC(BoardFile bf);

}
