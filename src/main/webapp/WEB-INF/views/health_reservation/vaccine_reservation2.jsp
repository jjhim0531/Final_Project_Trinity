<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>백신 예약</title>

    <!-- jQuery 및 jQuery UI -->
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/common/default.css">
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/health_reservation/health_reservation2.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="../common/main_header.jsp" />

    <div class="health_reservation1_wrap">
        <div class="health_reservation1_container">
            <div class="health_reservation1_title">백신 예약</div>
            <form
                action="${pageContext.request.contextPath}/healthReservation/submitReservation"
                method="post">
                <!-- 숨겨진 데이터 -->
                <input type="hidden" name="patientName" value="${param.patientName}">
                <input type="hidden" name="patientBirthday" value="${param.patientBirthday}">
                <input type="hidden" name="phone" value="${param.phoneCode}-${param.phoneNumber}">
                <input type="hidden" name="email" value="${param.email}@${param.emailDomain}">
                <input type="hidden" name="address" value="${param.address}">

                <!-- 백신 종류 -->
                <div class="health_reservation2_content">
                    <div id="health_reservation1_content_title">3. 백신 종류</div>
                    <div class="health_reservation_normal_select">
                        <select name="vaccineCategory" required>
                            <option value="" disabled hidden selected>백신 종류</option>
                            <option value="1">백신 1</option>
                            <option value="2">백신 2</option>
                            <option value="3">백신 3</option>
                        </select>
                    </div>
                </div>

                <!-- 접종받을 기관 -->
                <div class="health_reservation2_content">
                    <div id="health_reservation1_content_title">4. 접종받을 기관</div>
                    <div class="health_reservation_normal_select">
                        <select name="hosNo" required>
                            <option value="" disabled hidden selected>기관 선택</option>
                            <option value="1">기관 1</option>
                            <option value="2">기관 2</option>
                            <option value="3">기관 3</option>
                        </select>
                    </div>
                </div>

                <!-- 특이사항 -->
                <div class="health_reservation2_content">
                    <div id="health_reservation1_content_title">5. 특이사항</div>
                    <div id="health_reservation_inputText">
                        <textarea name="specialNotes" placeholder="알레르기, 부작용 반응 등 작성"></textarea>
                    </div>
                </div>

                <!-- 날짜 및 시간 -->
                <div class="health_reservation2_content">
                    <div id="health_reservation1_content_title">6. 날짜 및 시간</div>
                    <div class="health_reservation_normal_date">
                    <div id="datepicker">
                        <input type="text" name="resDate" placeholder="예약 날짜를 선택하세요" readonly required>
                    </div>
                    </div>
                    <div class="health_reservation_normal_select">
                        <select name="timeOfDay" id="timeOfDaySelect" required>
                            <option value="" disabled hidden selected>시간 선택</option>
                            <option value="morning">오전</option>
                            <option value="afternoon">오후</option>
                        </select>
                    </div>
                    <div class="health_reservation_normal_select" id="specificTimeSelectContainer">
                        <select name="resTime" id="specificTimeSelect" required>
                            <option value="" disabled hidden selected>구체적인 시간 선택</option>
                        </select>
                    </div>
                </div>

                <!-- 예약 버튼 -->
                <div class="reservation_btn_area">
                    <button id="reservation_btn" type="submit">예약</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Script -->
    <script>
        $(function() {
            // 날짜 선택 달력 설정
            $("#datepicker").datepicker({
                dateFormat: "yy-mm-dd",
                minDate: 0, // 오늘 이후의 날짜만 선택 가능
                closeText: "닫기",
                currentText: "오늘",
                prevText: '이전 달',
                nextText: '다음 달',
                monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
                yearSuffix: '년'
            });

            // 오전/오후 선택에 따른 시간대 표시
            $('#timeOfDaySelect').on('change', function() {
                const timeOfDay = $(this).val();
                const specificTimeSelect = $('#specificTimeSelect');
                specificTimeSelect.empty(); // 기존 옵션 제거

                if (timeOfDay === 'morning') {
                    specificTimeSelect.append(new Option('09:00', '09:00'));
                    specificTimeSelect.append(new Option('09:30', '09:30'));
                    specificTimeSelect.append(new Option('10:00', '10:00'));
                    specificTimeSelect.append(new Option('10:30', '10:30'));
                    specificTimeSelect.append(new Option('11:00', '11:00'));
                } else if (timeOfDay === 'afternoon') {
                    specificTimeSelect.append(new Option('13:00', '13:00'));
                    specificTimeSelect.append(new Option('13:30', '13:30'));
                    specificTimeSelect.append(new Option('14:00', '14:00'));
                    specificTimeSelect.append(new Option('14:30', '14:30'));
                    specificTimeSelect.append(new Option('15:00', '15:00'));
                }

                $('#specificTimeSelectContainer').show();
            });
        });
    </script>

    <!-- Footer -->
    <jsp:include page="../common/main_footer.jsp" />
</body>
</html>
