package com.project.trinity.board.community.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.project.trinity.board.common.model.vo.BoardCategory;
import com.project.trinity.board.common.model.vo.BoardFile;
import com.project.trinity.board.common.model.vo.PageInfo;
import com.project.trinity.board.community.model.vo.Community;
import com.project.trinity.board.community.model.vo.MedAnswer;


@Repository
public class CommunityDao {

    // ========================= 게시글 관리 =========================

    /**
     * 전체 게시글 수를 조회합니다.
     */
    public int selectListCount(SqlSessionTemplate sqlSession) {
        return sqlSession.selectOne("communityMapper.selectListCount");
    }

    /**
     * 특정 카테고리에 해당하는 게시글 수를 조회합니다.
     */
    public int selectCountCategoryList(SqlSessionTemplate sqlSession, String categoryId) {
        return sqlSession.selectOne("communityMapper.selectCountCategoryList", categoryId);
    }

    public List<Community> getLatestBoardPosts(SqlSessionTemplate sqlSession, String ct) {
        return sqlSession.selectList("communityMapper.getLatestBoardPosts", ct);
    }


    /**
     * 특정 게시글의 상세 내용을 조회합니다.
     */
    public Community viewDetailPage(SqlSessionTemplate sqlSession, String bno) {
        return sqlSession.selectOne("communityMapper.viewDetailPage", bno);
    }
    
    public List<Community> getPostsByUserNo(SqlSessionTemplate sqlSession, String userNo) {
        return sqlSession.selectList("communityMapper.getPostsByUserNo", userNo);
    }
    public List<MedAnswer> getAnswersByBoardNo(SqlSessionTemplate sqlSession, String bno) {
        return sqlSession.selectList("communityMapper.getAnswersByBoardNo", bno);
    }
	public List<Community> getPostsByHosNo(SqlSessionTemplate sqlSession, String hosNo) {
		return sqlSession.selectList("communityMapper.getPostsByHosNo", hosNo);
	}
	public int insertBoardAC(SqlSessionTemplate sqlSession, Community b) {
		return sqlSession.insert("communityMapper.insertBoardAC", b);
	}




	public Community selectBoardAC(SqlSessionTemplate sqlSession, String bno) {
		return sqlSession.selectOne("communityMapper.selectBoardAC", bno);
	}




	public int insertFileAC(SqlSessionTemplate sqlSession, BoardFile bf) {
		return sqlSession.insert("communityMapper.insertFileAC", bf);
	}



    /**
     * 새 게시글을 추가합니다.
     */
    public int insertBoard(SqlSessionTemplate sqlSession, Community b) {
        return sqlSession.insert("communityMapper.insertBoard", b);
    }
  public int insertAnswer(SqlSessionTemplate sqlSession, MedAnswer ans) {
        
        return sqlSession.insert("communityMapper.insertAnswer", ans);
    }


    /**
     * 기존 게시글을 수정합니다.
     */
    public int updateBoard(SqlSessionTemplate sqlSession, Community b) {
        return sqlSession.update("communityMapper.updateBoard", b);
    }

    /**
     * 게시글을 삭제합니다. (논리 삭제)
     */
    public int deleteBoard(SqlSessionTemplate sqlSession, String bno) {
        return sqlSession.update("communityMapper.deleteBoard", bno);
    }

    /**
     * 관리자에 의한 게시글 삭제 (물리 삭제)
     */
    public int adminDeleteBoard(SqlSessionTemplate sqlSession, String bno) {
        return sqlSession.delete("communityMapper.adminDeleteBoard", bno);
    }

    /**
     * 게시글을 복원합니다.
     */
    public int restoreBoard(SqlSessionTemplate sqlSession, String bno) {
        return sqlSession.update("communityMapper.adminRestoreBoard", bno);
    }

   
    // ========================= 조회수 관리 =========================

    /**
     * 특정 게시글의 조회수를 증가시킵니다.
     */
    public int increaseCount(SqlSessionTemplate sqlSession, String bno) {
        return sqlSession.update("communityMapper.increaseCount", bno);
    }

    

    // ========================= 카테고리 관리 =========================


    /**
     * 카테고리별 게시글 목록을 페이징 처리하여 조회합니다.
     */
    public ArrayList<Community> selectListByCategory(SqlSessionTemplate sqlSession, String categoryId, PageInfo pi, String sortType) {
        int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        Map<String, Object> params = new HashMap<>();
        params.put("categoryId", categoryId);
        params.put("startRow", offset + 1);
        params.put("endRow", offset + pi.getBoardLimit());
        params.put("sortType", sortType);

        return (ArrayList) sqlSession.selectList("communityMapper.selectListByCategory", params);
    }

 

    // ========================= 기타 기능 =========================

    /**
     * 특정 게시글의 이전 게시글 번호를 조회합니다.
     */
    public String getPreviousBoard(SqlSessionTemplate sqlSession, String bno) {
        return sqlSession.selectOne("communityMapper.getPreviousBoard", bno);
    }

    /**
     * 특정 게시글의 다음 게시글 번호를 조회합니다.
     */
    public String getNextBoard(SqlSessionTemplate sqlSession, String bno) {
        return sqlSession.selectOne("communityMapper.getNextBoard", bno);
    }

    /**
     * 특정 사용자가 작성한 게시글 목록을 조회합니다.
     */
    public List<Community> selectUserBoards(SqlSessionTemplate sqlSession, String userNo) {
        return sqlSession.selectList("communityMapper.selectUserBoards", userNo);
    }

   
    /**
     * 질의응답 게시글에 대한 답변을 추가합니다.
     */
    public int insertMedAnswer(SqlSessionTemplate sqlSession, MedAnswer medAnswer) {
        return sqlSession.insert("communityMapper.insertMedAnswer", medAnswer);
    }

    /**
     * 질의응답 게시글에 대한 답변을 수정합니다.
     */
    public int updateMedAnswer(SqlSessionTemplate sqlSession, MedAnswer medAnswer) {
        return sqlSession.update("communityMapper.updateMedAnswer", medAnswer);
    }

    /**
     * 질의응답 게시글에 대한 답변을 삭제합니다.
     */
    public int deleteMedAnswer(SqlSessionTemplate sqlSession, String medAnswerId) {
        return sqlSession.delete("communityMapper.deleteMedAnswer", medAnswerId);
    }


}
