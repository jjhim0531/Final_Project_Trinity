<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>개인정보 수정</title>
<link rel="stylesheet"
    href="${pageContext.request.contextPath}/resources/css/account/profile_edit.css">
<link
    href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap"
    rel="stylesheet">
<style>
    .hidden {
        display: none;
    }
</style>
</head>
<body>
    <!-- Header -->
    <%@ include file="../common/main_header.jsp"%>

    <!-- Flash 메시지가 있을 경우 alert 표시 -->
    <c:if test="${not empty errorMessage}">
        <script>
            alert("${errorMessage}");
        </script>
    </c:if>
    <c:if test="${not empty successMessage}">
        <script>
            alert("${successMessage}");
        </script>
    </c:if>

    <div class="layout-container">
        <!-- Sidebar -->
        <aside class="profile-sidemenu">
            <%@ include file="../account/mysidebar.jsp"%>
        </aside>

        <!-- Main Content -->
        <main class="profile-container">
            <h2>개인정보</h2>

            <form id="profile-form"
                action="${pageContext.request.contextPath}/member/update_profile"
                method="post" enctype="multipart/form-data">
                <div class="profile-picture">
                    <c:choose>
                        <c:when test="${not empty loginUser.userProfile}">
                            <img id="profile-preview"
                                src="${pageContext.servletContext.contextPath}${loginUser.userProfile}"
                                alt="프로필 사진">
                        </c:when>
                        <c:otherwise>
                            <img id="profile-preview"
                                src="${pageContext.servletContext.contextPath}/resources/img/default_profile.png"
                                alt="프로필 사진">
                        </c:otherwise>
                    </c:choose>
                    <label for="profile-upload" class="upload-button hidden">사진 변경</label>
                    <input type="file" id="profile-upload" name="profileImage"
                        accept="image/*" onchange="previewImage(event)" hidden>
                </div>

                <div class="input-group">
                    <label>이름</label> <input type="text" name="userName"
                        value="${loginUser.userName}" disabled>
                </div>
                <div class="input-group">
                    <label>생년월일</label> <input type="date" name="birthday"
                        value="${formattedBirthday}" disabled>
                </div>
                <div class="input-group">
                    <label>이메일</label> <input type="email" name="email"
                        value="${loginUser.email}" disabled>
                </div>
                <div class="input-group">
                    <label>성별</label> <input type="text" name="gender"
                        value="${loginUser.gender}" disabled>
                </div>
                <div class="input-group">
                    <label>주소</label> <input type="text" name="address"
                        value="${loginUser.address}" disabled>
                </div>

                <!-- 의사 약력 입력 필드 -->
                <c:if test="${loginUser.medKey != null}">
                    <div class="input-group">
                        <label>의사 약력</label>
                        <textarea name="biography" rows="5" disabled>${loginUser.biography}</textarea>
                    </div>
                </c:if>

                <!-- 수정 활성화/저장 버튼 -->
                <button type="button" id="edit-save-button" class="edit-button"
                    onclick="toggleEditSave()">수정 활성화</button>
            </form>

            <!-- 회원탈퇴 버튼 -->
            <button type="button" class="password-change"
                onclick="confirmWithdrawal()">회원탈퇴</button>
        </main>
    </div>

    <!-- Footer -->
    <%@ include file="../common/main_footer.jsp"%>

    <script>
        // 이미지 미리보기
        function previewImage(event) {
            const reader = new FileReader();
            reader.onload = function () {
                const preview = document.getElementById('profile-preview');
                preview.src = reader.result;
            };
            reader.readAsDataURL(event.target.files[0]);
        }

        let isEditing = false; // 수정 상태 변수

        function toggleEditSave() {
            const button = document.getElementById('edit-save-button');
            const form = document.getElementById('profile-form');
            const editableFields = document.querySelectorAll('input[name="userName"], input[name="email"], input[name="birthday"], input[name="address"], textarea[name="biography"]');
            const uploadButton = document.querySelector('.upload-button'); // 사진 변경 버튼

            if (!isEditing) {
                // 수정 활성화
                editableFields.forEach(input => {
                    input.disabled = false; // 필드 활성화
                    input.style.backgroundColor = '#fff'; // 수정 가능 상태 표시
                });
                uploadButton.classList.remove('hidden'); // 사진 변경 버튼 표시
                button.textContent = "저장하기";
            } else {
                // 저장하기: disabled 속성 제거 후 제출
                editableFields.forEach(input => {
                    input.disabled = false; // 반드시 제거
                });
                uploadButton.classList.add('hidden'); // 사진 변경 버튼 숨김
                form.submit(); // 폼 제출
            }

            isEditing = !isEditing;
        }

        // 회원탈퇴 확인 및 비밀번호 입력
        function confirmWithdrawal() {
            const password = prompt("정말로 탈퇴하시겠습니까?\n비밀번호를 입력해주세요.");
            if (password) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/member/withdraw';

                const passwordInput = document.createElement('input');
                passwordInput.type = 'hidden';
                passwordInput.name = 'password';
                passwordInput.value = password;

                const csrfToken = '${_csrf.token}';
                const csrfInput = document.createElement('input');
                csrfInput.type = 'hidden';
                csrfInput.name = '${_csrf.parameterName}';
                csrfInput.value = csrfToken;

                form.appendChild(passwordInput);
                form.appendChild(csrfInput);

                document.body.appendChild(form);
                form.submit();
            } else {
                alert("탈퇴가 취소되었습니다.");
            }
        }
    </script>
</body>
</html>
