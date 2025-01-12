package com.project.trinity.board.common.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.project.trinity.board.common.model.vo.BoardFile;
import com.project.trinity.board.common.model.vo.Comment;
import com.project.trinity.board.common.model.vo.Like;
import com.project.trinity.board.common.service.BoardCommonService;




@Controller
@RequestMapping("/boardCommon")
public class BoardCommonController {
	
	@Autowired
    private BoardCommonService boardCommonService;

    

	// 댓글을 DB에 저장
	@ResponseBody
	@RequestMapping("rinsert.bo")
	public String ajaxInsertReply(Comment r) {

		System.out.println("댓글 데이터: " + r); // 전달받은 댓글 데이터 확인
		// 성공했을 때 success, 실패했을 때 fail
		return boardCommonService.insertComment(r) > 0 ? "success" : "fail";
	}

	
	@ResponseBody
	@RequestMapping("rlist")
	public String ajaxSelectReplyList(@RequestParam("bno") String refNo, 
	                                  @RequestParam("boardType") String boardType) {
	    System.out.println("댓글 목록 요청 - 게시글 번호: " + refNo + ", 게시판 타입: " + boardType);

	    try {
	        // REF_NO와 BOARD_TYPE으로 댓글 조회
	        ArrayList<Comment> list = boardCommonService.selectComment(refNo, boardType);
	        System.out.println("댓글 목록: " + list);
	        return new Gson().toJson(list);
	    } catch (Exception e) {
	        System.err.println("댓글 목록 조회 중 오류 발생: " + e.getMessage());
	        e.printStackTrace();
	        return null;
	    }
	}


	@ResponseBody
	@RequestMapping("toggleLike.bo")
	public Map<String, Object> toggleLike(@RequestParam("commentNo") String commentNo,
			@RequestParam("userNo") String userNo, @RequestParam("isLike") int isLike) {
		Map<String, Object> response = new HashMap<>();
		try {
			// 파라미터 유효성 검사
			if (commentNo == null || userNo == null || (isLike != 0 && isLike != 1)) {
				response.put("success", false);
				response.put("message", "잘못된 요청 데이터입니다.");
				return response;
			}

			// 좋아요/싫어요 로우데이터 가져오기
			Like existingLike = boardCommonService.getCurrentLikeState(commentNo, userNo);

			if (existingLike == null) {
				// 데이터가 없으면 새로 추가
				boardCommonService.insertLikeDislike(commentNo, userNo, isLike);

				response.put("success", true);
				response.put("likeCount", boardCommonService.getLikeCount(commentNo));
				response.put("dislikeCount", boardCommonService.getDislikeCount(commentNo));
				response.put("message", isLike == 1 ? "좋아요가 추가되었습니다." : "싫어요가 추가되었습니다.");
				return response;
			}

			// 데이터가 있으면 현재 상태와 비교
			if (existingLike.getIsLike() == isLike) {
				response.put("success", false);
				response.put("message", isLike == 1 ? "이미 좋아요를 누르셨습니다." : "이미 싫어요를 누르셨습니다.");
				return response;
			}

			// 상태 업데이트
			boardCommonService.updateLikeDislike(commentNo, userNo, isLike);

			response.put("success", true);
			response.put("likeCount", boardCommonService.getLikeCount(commentNo));
			response.put("dislikeCount", boardCommonService.getDislikeCount(commentNo));
			response.put("message", isLike == 1 ? "좋아요로 변경되었습니다." : "싫어요로 변경되었습니다.");

		} catch (Exception e) {
			e.printStackTrace();
			response.put("success", false);
			response.put("message", "서버 오류가 발생했습니다.");
		}
		return response;
	}

	
	@ResponseBody
	@RequestMapping("rdelete.bo")
	public String deleteReply(String commentNo) {
		int result = boardCommonService.deleteComment(commentNo);

		return result > 0 ? "success" : "fail";
	}

	@GetMapping("/getFileList")
	@ResponseBody
	public List<BoardFile> getAttachedFiles(@RequestParam("bno") String bno) {
	    return boardCommonService.getFileList(bno);
	}
	@PostMapping("/deleteFile")
	public String deleteFile(@RequestBody Map<String, String> fileData) {
		String fileNo = fileData.get("fileNo");
		BoardFile file = boardCommonService.getSingleFile(fileNo);

		if (file == null) {
			return "파일이 존재하지 않습니다.";
		}

		// 실제 파일 삭제
		File targetFile = new File("파일 저장 경로/" + file.getChangeName());
		if (targetFile.exists() && targetFile.delete()) {
			boardCommonService.deleteFile(fileNo); // 데이터베이스에서도 삭제
			return "삭제 성공";
		} else {
			return "파일 삭제 실패";
		}
	}
	@GetMapping("/downloadFile")
	public ResponseEntity<Resource> downloadFile(@RequestParam("fileNo") String fileNo) {
		BoardFile file = boardCommonService.getSingleFile(fileNo);
		if (file == null || !"Y".equals(file.getAllowDownload())) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
		}

		// 파일 경로로 실제 파일 제공
		String filePath = "파일 저장 경로/" + file.getChangeName();
		Resource resource = new FileSystemResource(new File(filePath));
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + file.getOriginName() + "\"")
				.body(resource);
	}
}
