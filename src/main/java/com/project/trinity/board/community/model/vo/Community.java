package com.project.trinity.board.community.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;

import com.project.trinity.board.common.model.vo.BoardFile;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class Community {

    private String communityNo;               // 게시글 번호
    private String communityTitle;            // 게시글 제목
    private String tag;                   // 태그
    private String userNo;                // 작성자의 고유 번호
    private String communityWriter;           // 작성자의 ID
    private String communityContent;          // 게시글 내용
    private String enrollDate;            // 등록일
    private String modifiedDate;          // 수정일
    private int communityViews;               // 조회수
    private String status;                // 상태 (Y/N)
    private String categoryId;  // 카테고리 ID만 필요
    private String categoryName;
    private String hosAcNo;
    private String hosName;
    
    // 첨부파일 목록
    private ArrayList<BoardFile> fileList; // 특정 게시글의 첨부파일 정보
}
