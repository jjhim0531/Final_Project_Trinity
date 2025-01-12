package com.project.trinity.board.common.dao;

import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.project.trinity.board.common.model.vo.BoardCategory;
import com.project.trinity.board.common.model.vo.BoardFile;
import com.project.trinity.board.common.model.vo.Comment;
import com.project.trinity.board.common.model.vo.Like;





@Repository
public class BoardCommonDao { 
	// ========================= 댓글 관리 =========================

    /**
     * 특정 게시글에 달린 댓글 목록을 조회합니다.
     */
	public ArrayList<Comment> selectComments(SqlSessionTemplate sqlSession, String refNo, String boardType) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("refNo", refNo);
	    params.put("boardType", boardType);

	    return (ArrayList) sqlSession.selectList("boardCommonMapper.selectComments", params);
	}

  
    /**
     * 새 댓글을 추가합니다.
     */
    public int insertComment(SqlSessionTemplate sqlSession, Comment r) {
        return sqlSession.insert("boardCommonMapper.insertComment", r);
    }

    /**
     * 특정 댓글을 삭제합니다.
     */
    public int deleteComment(SqlSessionTemplate sqlSession, String commentNo) {
        return sqlSession.delete("boardCommonMapper.deleteReply", commentNo);
    }

    public int deleteCommentsByBoardNo(SqlSessionTemplate sqlSession, String bno) {
        return sqlSession.delete("boardCommonMapper.deleteCommentsByBoardNo", bno);
    }
    
    /**
     * 특정 사용자가 작성한 댓글 목록을 조회합니다.
     */
    public List<Comment> selectUserComments(SqlSessionTemplate sqlSession, String userNo) {
        return sqlSession.selectList("boardMapper.selectUserComments", userNo);
    }

 // ========================= 좋아요/싫어요 관리 =========================

    /**
     * 현재 사용자의 특정 댓글에 대한 좋아요/싫어요 상태를 조회합니다.
     */
    public Like getCurrentLikeState(SqlSessionTemplate sqlSession, String commentNo, String userNo) {
        Map<String, Object> params = new HashMap<>();
        params.put("commentNo", commentNo);
        params.put("userNo", userNo);
        return sqlSession.selectOne("boardCommonMapper.getCurrentLikeState", params);
    }

    /**
     * 특정 댓글에 좋아요 또는 싫어요를 추가합니다.
     */
    public void insertLikeDislike(SqlSessionTemplate sqlSession, String commentNo, String userNo, int isLike) {
        Map<String, Object> params = new HashMap<>();
        params.put("commentNo", commentNo);
        params.put("userNo", userNo);
        params.put("isLike", isLike); 
        sqlSession.insert("boardCommonMapper.insertLikeDislike", params);
    }

    /**
     * 특정 댓글의 좋아요/싫어요를 삭제합니다.
     */
    public void deleteLikeDislike(SqlSessionTemplate sqlSession, String commentNo, String userNo) {
        Map<String, Object> params = new HashMap<>();
        params.put("commentNo", commentNo);
        params.put("userNo", userNo);
        sqlSession.delete("boardCommonMapper.deleteLikeDislike", params);
    }

    /**
     * 특정 댓글에 대한 좋아요 수를 조회합니다.
     */
    public int getLikeCount(SqlSessionTemplate sqlSession, String commentNo) {
        return sqlSession.selectOne("boardCommonMapper.getLikeCount", commentNo);
    }

    /**
     * 특정 댓글에 대한 싫어요 수를 조회합니다.
     */
    public int getDislikeCount(SqlSessionTemplate sqlSession, String commentNo) {
        return sqlSession.selectOne("boardCommonMapper.getDislikeCount", commentNo);
    }

    /**
     * 특정 댓글의 좋아요/싫어요를 업데이트합니다.
     */
    public void updateLikeDislike(SqlSessionTemplate sqlSession, String commentNo, String userNo, int isLike) {
        Map<String, Object> params = new HashMap<>();
        params.put("commentNo", commentNo);
        params.put("userNo", userNo);
        params.put("isLike", isLike);
        sqlSession.update("boardCommonMapper.updateLikeDislike", params);
    }

    // ========================= 첨부파일 관리 =========================

    /**
     * 첨부파일 정보를 추가합니다.
     */
    public int insertFile(SqlSessionTemplate sqlSession, BoardFile bf) {
        return sqlSession.insert("boardCommonMapper.insertFile", bf);
    }

    /**
     * 특정 게시글에 첨부된 파일 목록을 조회합니다.
     */
    public List<BoardFile> getFilesList(SqlSessionTemplate sqlSession, String bno) {
        return sqlSession.selectList("boardCommonMapper.getFilesList", bno);
    }

    /**
     * 특정 첨부파일 정보를 조회합니다.
     */
    public BoardFile getSingleFile(SqlSessionTemplate sqlSession, String fileNo) {
        return sqlSession.selectOne("boardCommonMapper.getSingleFile", fileNo);
    }

    /**
     * 특정 게시글의 첨부파일을 모두 삭제합니다.
     */
    public int deleteFilesByBoardNo(SqlSessionTemplate sqlSession, String bno) {
        return sqlSession.delete("boardCommonMapper.deleteFilesByBoardNo", bno);
    }

    /**
     * 특정 첨부파일을 삭제합니다.
     */
    public int deleteFile(SqlSessionTemplate sqlSession, String fileNo) {
        return sqlSession.delete("boardCommonMapper.deleteFile", fileNo);
    }

    /**
     * 첨부파일의 다운로드 가능 여부를 업데이트합니다.
     */
    public int updateFileAllowDownload(SqlSessionTemplate sqlSession, BoardFile bf) {
        return sqlSession.update("boardCommonMapper.updateFileAllowDownload", bf);
    }

       /**
     * 특정 게시글의 첨부파일을 모두 삭제합니다.
     */
    public int deleteAllFilesByBoardNo(SqlSessionTemplate sqlSession, String bno) {
        return sqlSession.delete("boardCommonMapper.deleteAllFilesByBoardNo", bno);
    }
    
    /**
     * 전체 카테고리 목록을 조회합니다.
     */
    public List<BoardCategory> selectList(SqlSessionTemplate sqlSession) {
        return sqlSession.selectList("boardCommonMapper.selectAllCategories");  
    }

    /**
     * 카테고리 이름을 조회합니다.
     */
    public String getCategoryNameById(SqlSessionTemplate sqlSession, String categoryId) {
        return sqlSession.selectOne("boardCommonMapper.getCategoryNameById", categoryId);
    }

	
}
