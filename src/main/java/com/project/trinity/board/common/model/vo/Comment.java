package com.project.trinity.board.common.model.vo;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Comment {
    private String commentNo;      // 댓글 번호
    private String refNo;          // 참조 게시글 번호 (COMMUNITY_NO 또는 INQUIRY_NO)
    private String boardType;      // 게시판 타입 (COMMUNITY, INQUIRY)
    private String userNo;         // 사용자 번호
    private String commentWriter;  // 작성자 이름
    private String commentContent; // 댓글 내용
    private String enrollDate;     // 작성 날짜
    private int likeCount;         // 좋아요 개수
    private int dislikeCount;      // 싫어요 개수
    private boolean isLiked;       // 사용자가 좋아요를 눌렀는지 여부
    private boolean isDisliked;    // 사용자가 싫어요를 눌렀는지 여부
}


