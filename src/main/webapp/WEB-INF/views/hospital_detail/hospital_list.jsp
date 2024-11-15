<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String contextPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>닥터링</title>

	<!-- searchBar icon -->
    <link rel="favicon" href="${ pageContext.servletContext.contextPath }/resources/img/favicon.ico" />
    <link rel="icon" href="${ pageContext.servletContext.contextPath }/resources/img/favicon.ico" type="image/x-icon" />

    <!-- font style -->
   <link rel="preconnect" href="https://fonts.googleapis.com">
   <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
   <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

    <!-- icon -->
    <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>

    <!-- css -->
    <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/common/default.css">
    <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/hospital_detail/hospital_list.css">

</head>
<body>
	<!-- Header -->
	<jsp:include page="/WEB-INF/views/common/main_header.jsp" />
	
    <br><br>

    <div class="list_wrapper">
        <!-- searchBar -->
        <div class="list_searchBar">
            <input type="text">
            <button>병원 검색</button>
        </div>

        <br><br>

        <!-- order by -->
        <div class="list_order">
            <select id="subject" name="subject" class="list_subject">
                <option value="listAll" selected>전체</option>
                <option value="listChild">소아과</option>
                <option value="listMother">산부인과</option>
            </select>
            <select id="order" name="order" class="list_orderBy">
                <option value="ASC">글자순</option>
                <option value="relevant">정확도순</option>
                <option value="popular">인기순</option>
            </select>
        </div>

        <script>
            $(document).ready(function() {
                const subject = $("#subject").val();
                const order = $("#order").val();
    
                $.ajax({
                    url: "${pageContext.request.contextPath}/hospital/list", // Controller 매핑된 URL
                    type: "GET",
                    data: { subject: subject, order: order },
                    success: function(response) {
                        console.log("서버 응답:", response);
                        // 성공 시 페이지 컨텐츠 로딩을 위한 코드 추가 가능
                    },
                    error: function(error) {
                        console.error("에러 발생:", error);
                    }
                });
            });
        </script>

        <hr>
        <br>
		
        <!-- list -->
        <div>
            <c:forEach var="h" items="${list}">
                <div class="list">
                    <div class="list_title"><a href="location.href='hospital/detail?hno=${h.hpId}'"><p>청담이든소아청소년과의원</p></a></div>
                    <div class="list_openTime">평일 ${h.startTime} ~ ${h.endTime} | <p>소아청소년과</p></div>
                    <div class="list_address"><p>${h.address}</p></div>
                    <div class="list_tag">
                        <button>어린이 국가예방접종</button>
                        <button>영유아 검진</button>
                        <button>주차장</button>
                    </div>
                </div>
            </c:forEach>
        </div>  
    </div>

	<br><br>
	<!-- Footer -->
	<jsp:include page="/WEB-INF/views/common/main_footer.jsp" />

	
</body>
</html>


<!-- <div class="list">
                <div class="list_title"><a href="hospital_detail"><p>청담이든소아청소년과의원</p></a></div>
                <div class="list_openTime">금요일 09:00 ~ 19:00 | <p>소아청소년과</p></div>
                <div class="list_address"><p>서울 강남구 테헤란로 226 (태왕빌딩) 1층</p></div>
                <div class="list_tag">
                    <button>어린이 국가예방접종</button>
                    <button>영유아 검진</button>
                    <button>주차장</button>
                </div>
            </div>
            <div class="list">
                <div class="list_title"><a href="hospital_detail"><p>청담이든소아청소년과의원</p></a></div>
                <div class="list_openTime">금요일 09:00 ~ 19:00 | <p>소아청소년과</p></div>
                <div class="list_address"><p>서울 강남구 테헤란로 226 (태왕빌딩) 1층</p></div>
                <div class="list_tag">
                    <button>어린이 국가예방접종</button>
                    <button>영유아 검진</button>
                    <button>주차장</button>
                </div>
            </div>
            <div class="list">
                <div class="list_title"><a href="hospital_detail"><p>청담이든소아청소년과의원</p></a></div>
                <div class="list_openTime">금요일 09:00 ~ 19:00 | <p>소아청소년과</p></div>
                <div class="list_address"><p>서울 강남구 테헤란로 226 (태왕빌딩) 1층</p></div>
                <div class="list_tag">
                    <button>어린이 국가예방접종</button>
                    <button>영유아 검진</button>
                    <button>주차장</button>
                </div>
            </div>
            <div class="list">
                <div class="list_title"><a href="hospital_detail"><p>청담이든소아청소년과의원</p></a></div>
                <div class="list_openTime">금요일 09:00 ~ 19:00 | <p>소아청소년과</p></div>
                <div class="list_address"><p>서울 강남구 테헤란로 226 (태왕빌딩) 1층</p></div>
                <div class="list_tag">
                    <button>어린이 국가예방접종</button>
                    <button>영유아 검진</button>
                    <button>주차장</button>
                </div>
            </div> -->