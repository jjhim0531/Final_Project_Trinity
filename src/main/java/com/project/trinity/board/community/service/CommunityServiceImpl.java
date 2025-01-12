package com.project.trinity.board.community.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.trinity.board.common.model.vo.BoardFile;
import com.project.trinity.board.common.model.vo.PageInfo;
import com.project.trinity.board.community.dao.CommunityDao;
import com.project.trinity.board.community.model.vo.Community;
import com.project.trinity.board.community.model.vo.MedAnswer;
import com.project.trinity.board.common.dao.BoardCommonDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CommunityServiceImpl implements CommunityService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private final CommunityDao communityDao;
	
	@Autowired
	private final BoardCommonDao boardCommonDao;
	
	

	// 게시글 관련 메서드
	@Override
	public int selectListCount() {
		// 게시글 총 개수 조회
		return communityDao.selectListCount(sqlSession);
	}

	@Override
	public int selectCountCategoryList(String type) {
		// 특정 카테고리 게시글 개수 조회
		return communityDao.selectCountCategoryList(sqlSession, type);
	}

	@Override
	public Community viewDetailPage(String bno) {
		// 게시글 상세보기
		return communityDao.viewDetailPage(sqlSession, bno);
	}

	@Override
	public int insertBoard(Community b, String userNo) {
		// 게시글 작성
		b.setUserNo(userNo); // 작성자 설정
		return communityDao.insertBoard(sqlSession, b);
	}

	@Transactional(rollbackFor = { Exception.class })
	@Override
	public int updateBoard(Community b, ArrayList<BoardFile> newFiles) {
		// 게시글 수정 (첨부파일 포함)
		int boardUpdateResult = communityDao.updateBoard(sqlSession, b);
		if (boardUpdateResult <= 0) {
			throw new RuntimeException("게시글 수정에 실패했습니다.");
		}

		// 기존 파일 삭제 후 새 파일 등록
		if (newFiles != null && !newFiles.isEmpty()) {
			boardCommonDao.deleteAllFilesByBoardNo(sqlSession, b.getCommunityNo());
			for (BoardFile bf : newFiles) {
				int fileInsertResult = boardCommonDao.insertFile(sqlSession, bf);
				if (fileInsertResult < 0) {
					throw new RuntimeException("첨부파일 등록에 실패했습니다.");
				}
			}
		}
		return boardUpdateResult;
	}



	@Override
	public int getListCount(String categoryId) {
		// 카테고리별 게시글 개수 조회
		Integer count = sqlSession.selectOne("communityMapper.getListCount", categoryId);
		return count == null ? 0 : count;
	}

	@Override
	public List<Community> selectListByCategory(String categoryId, PageInfo pi, String sortType) {
		// 카테고리별 게시글 목록 조회
		return communityDao.selectListByCategory(sqlSession, categoryId, pi, sortType);
	}

	@Override
	public List<Community> getLatestBoardPosts(String ct) {
		// 최신 게시글 목록 조회
		return communityDao.getLatestBoardPosts(sqlSession, ct);
	}

	

	@Override
	public String getPreviousBoard(String bno) {
		// 이전 게시글 번호 조회
		return communityDao.getPreviousBoard(sqlSession, bno);
	}

	@Override
	public String getNextBoard(String bno) {
		// 다음 게시글 번호 조회
		return communityDao.getNextBoard(sqlSession, bno);
	}

	@Override
	public int restoreBoard(String bno) {
		// 삭제된 게시글 복구
		return communityDao.restoreBoard(sqlSession, bno);
	}

	@Override
	public List<Community> getPostsByUserNo(String userNo) {
		// 특정 사용자 작성 게시글 조회
		return communityDao.getPostsByUserNo(sqlSession, userNo);
	}

	@Override
	public List<MedAnswer> getAnswersByBoardNo(String bno) {
		// 게시글에 달린 의학적 답변 조회
		return communityDao.getAnswersByBoardNo(sqlSession, bno);
	}

	@Override
	public int saveAnswer(MedAnswer ans) {
		// 의학적 답변 저장
		return communityDao.insertAnswer(sqlSession, ans);
	}

	@Override
	public List<Community> getPostsByHosNo(String hosNo) {
		// 특정 병원 작성 게시글 조회
		return communityDao.getPostsByHosNo(sqlSession, hosNo);
	}

	@Override
	public int insertBoardAC(Community b) {
		// 게시글 AC(인증) 작성
		return communityDao.insertBoardAC(sqlSession, b);
	}

	@Override
	public Community selectBoardAC(String bno) {
		// 게시글 AC(인증) 상세 조회
		return communityDao.selectBoardAC(sqlSession, bno);
	}

	@Override
	public int increaseCount(String bno) {
		// TODO Auto-generated method stub
		return 0;
	}

	


	@Transactional(rollbackFor = { Exception.class })
	@Override
	public int adminDeleteBoard(String bno) {
		// 관리자 권한으로 게시글 삭제 (댓글 및 파일도 삭제)
		boardCommonDao.deleteAllFilesByBoardNo(sqlSession, bno);
		boardCommonDao.deleteCommentsByBoardNo(sqlSession, bno);
		int boardDeleteResult = communityDao.adminDeleteBoard(sqlSession, bno);
		if (boardDeleteResult <= 0) {
			throw new RuntimeException("게시글 삭제에 실패했습니다.");
		}
		return boardDeleteResult;
	}

	@Override
	public int deleteBoard(String bno) {
		// 게시글 삭제
		return communityDao.deleteBoard(sqlSession, bno);
	}

	@Override
	public String getCategoryNameById(String categoryId) {
		// TODO Auto-generated method stub
		return null;
	}


  
  
}
