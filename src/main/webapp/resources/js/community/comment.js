let data = {
    contextPath: "",
    fileList: [],
};

$(function () {
    const sendData = {
        bno: $("#bno").val() // bno 값을 숨겨진 input에서 가져옴
    };

    getReplyList(sendData, function (commnetList) {
        console.log("댓글 목록 요청 데이터:", data); // 요청 데이터 출력
        console.log("갱신된 댓글 목록:", commnetList);

        if (!Array.isArray(commnetList)) {
            console.error("replyList가 배열이 아닙니다. 서버 응답을 확인하세요.");
            return;
        }

        // 댓글 갯수 표시
        setReplyCount(commnetList.length);

        // 댓글 목록 렌더링
        const replyBody = document.querySelector("#commentList");

        if (!replyBody) {
            console.error("#commentList 요소를 찾을 수 없습니다.");
            return;
        }
        drawReplyList(replyBody, commnetList);
    });
});

function drawReplyList(tBody, commnetList) {
    console.log("갱신된 댓글 목록:", commnetList);

    // 기존 댓글 목록 초기화
    $(tBody).empty();

    // 댓글 목록 렌더링
    commnetList.forEach((comment) => {
        const commentWriter = comment.commentWriter || "알 수 없음";
        const commentContent = comment.commentContent || "내용 없음";
        const createDate = comment.createDate || "날짜 없음";
        const likeCount = comment.likeCount || 0;
        const dislikeCount = comment.dislikeCount || 0; // dislikeCount 추가
        const commentId = comment.commentNo;

        // 댓글 row 생성
        const replyRow = document.createElement("tr");
        replyRow.setAttribute("data-comment-no", commentId); // 댓글 ID를 저장

        // 댓글 내용을 설정
        replyRow.innerHTML = `
            <td>${commentWriter}</td>
            <td>${commentContent}</td>
            <td>${createDate}</td>
            <td>
                <!-- 좋아요 버튼 -->
                <button class="like-btn ${comment.isLiked ? 'liked' : ''}" onclick="handleLikeButtonClick(this)">
                    👍<span>${likeCount}</span>
                </button>
                <!-- 싫어요 버튼 -->
                <button class="dislike-btn ${comment.isDisliked ? 'liked' : ''}" onclick="handleDislikeButtonClick(this)">
                    👎<span>${dislikeCount}</span>
                </button>
            </td>
        `;

        // 댓글 row 추가
        $(tBody).append(replyRow);
    });
}



function setReplyCount(count) {
    $("#rcount").text(count);
}

function getReplyList(data, callback) {
    console.log("댓글 목록 요청 데이터:", data);
    $.ajax({
        url: "rlist.bo",
        data: data,
        success: function (res) {
            console.log("서버 응답 데이터:", res); // 서버에서 반환된 데이터 출력
            if (Array.isArray(res)) {
                callback(res);
            } else {
                console.error("댓글 목록이 배열이 아닙니다. 서버 응답을 확인하세요:", res);
                alert("댓글 목록을 불러오는 데 실패했습니다. 서버 응답을 확인하세요.");
            }
        },
        error: function () {
            console.error("댓글 목록을 가져오는 데 실패했습니다.");
            alert("댓글 목록을 가져오는 중 문제가 발생했습니다.");
        }
    });
}

function addReply() {

    const boardNo = $("#bno").val(); // bno 값을 숨겨진 input에서 가져옴
    const userId = $("#loginUserId").val(); // userId 값을 숨겨진 input에서 가져옴
    const userNo = $("#loginUserNo").val(); // 사용자 번호
    const content = $("#content").val();
    if (!content.trim()) {
        alert("댓글 내용을 입력해주세요.");
        return;
    }
    const button = $(".btn-secondary");
    button.css({ backgroundColor: "#265708", color: "#fff" }); // 클릭 시 강제로 스타일 유지
    addReplyAjax(
        {
            refBno: boardNo,
            userNo: userNo,
            commentWriter: userId,
            commentContent: content
        },

        function (res) {
            if (res === "success") {
                $("#content").val(""); // 댓글 입력창 초기화

                getReplyList({ bno: boardNo }, function (commnetList) {
                    setReplyCount(commnetList.length);
                    drawReplyList(document.querySelector("#commentList"), commnetList);
                });
            }
        }
    );
}

function addReplyAjax(data, callback) {
    console.log("서버로 전송할 데이터:", data); // 요청 데이터 확인
    $.ajax({// 페이지 로드 시 사용자 정보를 설정
        url: "rinsert.bo",
        type: "POST",
        data: data,
        success: function (res) {
            callback(res);
        },
        error: function () {
            console.error("댓글 등록 실패");
        }
    });
}


// 좋아요 상태 토글 처리
function handleLikeButtonClick(button) {
    const commentNo = button.closest("tr").getAttribute("data-comment-no");
    const isLiked = button.classList.contains("liked");

    toggleLikeDislike(button, commentNo, true, isLiked);
}

function handleDislikeButtonClick(button) {
    const commentNo = button.closest("tr").getAttribute("data-comment-no");
    const isDisliked = button.classList.contains("liked");

    toggleLikeDislike(button, commentNo, false, isDisliked);
}

function toggleLikeDislike(button, commentNo, isLike, currentState) {
    const userNo = $("#loginUserNo").val();

    if (!userNo) {
        alert("로그인이 필요합니다.");
        return;
    }

    if (currentState) {
        alert(isLike ? "이미 좋아요를 누르셨습니다." : "이미 싫어요를 누르셨습니다.");
        return;
    }

    $.ajax({
        url: "toggleLike.bo",
        
        type: "POST",
        data: {
            
            commentNo: commentNo,
            userNo: userNo,
            isLike: isLike ? 1 : 0 // boolean을 숫자로 변환
        },
        success: function (response) {
            console.log("AJAX 호출 URL:", "toggleLike.bo");

            if (response.success) {
                const likeButton = button.closest("tr").querySelector(".like-btn");
                const dislikeButton = button.closest("tr").querySelector(".dislike-btn");

                // 좋아요/싫어요 버튼 상태 업데이트
                if (isLike) {
                    likeButton.classList.add("liked");
                    dislikeButton.classList.remove("liked");
                } else {
                    dislikeButton.classList.add("liked");
                    likeButton.classList.remove("liked");
                }

          // 좋아요/싫어요 수 업데이트
          likeButton.querySelector("span").textContent = response.likeCount || 0;
          dislikeButton.querySelector("span").textContent = response.dislikeCount || 0;

          alert(response.message); // 서버 메시지 표시
      } else {
          alert(response.message || "처리 중 오류가 발생했습니다.");
      }
  },
  error: function () {
      alert("서버와의 통신 중 문제가 발생했습니다.");
  }
});
}





function toggleComments() {
    const commentSection = document.getElementById("comment-section");
    const toggleButton = document.getElementById("toggle-comments-button");
    const arrow = document.getElementById("arrow");

    if (commentSection.style.display === "none" || commentSection.style.display === "") {
        commentSection.style.display = "block";
        toggleButton.innerHTML = '댓글 닫기 <span id="arrow">&#9650;</span>'; // 위쪽 화살표
    } else {
        commentSection.style.display = "none";
        toggleButton.innerHTML = '댓글 열기 <span id="arrow">&#9660;</span>'; // 아래쪽 화살표
    }
}