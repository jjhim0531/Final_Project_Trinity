package com.project.trinity.board.common.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.trinity.board.common.dao.BoardCommonDao;
import com.project.trinity.board.common.model.vo.BoardCategory;
import com.project.trinity.board.common.model.vo.BoardFile;
import com.project.trinity.board.common.model.vo.Comment;
import com.project.trinity.board.common.model.vo.Like;


import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class BoardCommonServiceImpl implements BoardCommonService {
	@Autowired
	 private final SqlSessionTemplate sqlSession;
	@Autowired
	  private final BoardCommonDao boardCommonDao;

	// 댓글 관련 메서드
	
	  @Override
	  public List<Comment> selectComments(String refNo, String boardType) {
	      return boardCommonDao.selectComments(sqlSession, refNo, boardType);
	  }

	  @Override
	  public int insertComment(Comment r) {
	      return boardCommonDao.insertComment(sqlSession, r);
	  }


    @Override
    public int deleteComment(String commentNo) {
        // 댓글 삭제
        return boardCommonDao.deleteComment(sqlSession, commentNo);
    }

    @Override
    public int getLikeCount(String commentNo) {
        // 댓글의 좋아요 개수 조회
        return boardCommonDao.getLikeCount(sqlSession, commentNo);
    }

    @Override
    public int getDislikeCount(String commentNo) {
        // 댓글의 싫어요 개수 조회
        return boardCommonDao.getDislikeCount(sqlSession, commentNo);
    }

    @Override
    public Like getCurrentLikeState(String commentNo, String userNo) {
        // 댓글에 대한 사용자의 좋아요/싫어요 상태 조회
        return boardCommonDao.getCurrentLikeState(sqlSession, commentNo, userNo);
    }

    @Override
    public void updateLikeDislike(String commentNo, String userNo, int isLike) {
        // 좋아요/싫어요 상태 업데이트
    	boardCommonDao.updateLikeDislike(sqlSession, commentNo, userNo, isLike);
    }

    @Override
    public void deleteLikeDislike(String commentNo, String userNo) {
        // 좋아요/싫어요 상태 삭제
    	boardCommonDao.deleteLikeDislike(sqlSession, commentNo, userNo);
    }

    @Override
    public void insertLikeDislike(String commentNo, String userNo, int isLike) {
        // 좋아요/싫어요 상태 삽입
    	boardCommonDao.insertLikeDislike(sqlSession, commentNo, userNo, isLike);
    }
    
    @Override
	public int insertFileAC(BoardFile bf) {
		// TODO Auto-generated method stub
		return 0;
	}


	// 첨부파일 관련 메서드
	@Override
	public int insertFile(BoardFile bf) {
		// 첨부파일 등록
		return boardCommonDao.insertFile(sqlSession, bf);
	}

	@Override
	public BoardFile getSingleFile(String fileNo) {
		// 특정 첨부파일 조회
		return boardCommonDao.getSingleFile(sqlSession, fileNo);
	}

	@Override
	public List<BoardFile> getFileList(String bno) {
		// 게시글에 첨부된 파일 목록 조회
		List<BoardFile> fileList = sqlSession.selectList("boardCommonMapper.getFileList", bno);
		return fileList;
	}

	@Override
	public int deleteFile(String fileNo) {
		// 첨부파일 삭제
		return boardCommonDao.deleteFile(sqlSession, fileNo);
	}

	@Override
	public int deleteAllFilesByBoardNo(String bno) {
		// 게시글에 첨부된 모든 파일 삭제
		return boardCommonDao.deleteAllFilesByBoardNo(sqlSession, bno);
	}

	@Override
	public int updateFileAllowDownload(BoardFile bf) {
		// 첨부파일 다운로드 허용 여부 수정
		return boardCommonDao.updateFileAllowDownload(sqlSession, bf);
	}
	@Override
	public List<BoardCategory> getCategories() {
		// 카테고리 목록 조회
		return boardCommonDao.selectList(sqlSession);
	}
}
