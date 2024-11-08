<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
<<<<<<< HEAD
            <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/common/default.css">
            <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/community/community_medical.css">
            <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/common/custom_public.css">
=======
            <link rel="stylesheet" href="/css/default.css">
            <link rel="stylesheet" href="/css/community_medical.css">
>>>>>>> 290805b1e68b8e982924f5d67fedb2444073e01e
            <title>Customer Center</title>
        </head>

        <body>
            <div>
                <!-- Header Section -->
<<<<<<< HEAD
                <header>
=======
                <header class="header">
<<<<<<< HEAD
>>>>>>> 290805b1e68b8e982924f5d67fedb2444073e01e
                    <%@ include file="/WEB-INF/views/common/main_header.jsp" %>
                </header>
=======
                   <%@ include file="/WEB-INF/views/common/main_header.jsp" %>
>>>>>>> parent of 72fd086 (custom_public.css파일 생성)

                <div class="container">
                    <!-- Main Content Section -->
                    <main class="main-content">
                        <!-- Sidebar Menu -->
                        <aside class="sidebar">

                            <ul class="menu">
                                <li><a href="#">실시간 인기글<span class="arrow">›</span></a></li>
                                <li><a href="#" >자유게시판<span class="arrow">›</span></a></li>
                                <li><a href="#" class="active">메디톡<span class="arrow">›</span></a></li>
                                <li><a href="#">이벤트<span class="arrow">›</span></a></li>
                            </ul>
                            <div class="support-box">
                                <p class="support-text">도움이 필요하신가요?</p>
                                <a href="#" class="support-link">1:1 문의하기</a>
                            </div>
                        </aside>


                        <!-- Content Section -->
                        <section class="notice-content">
                            <div class="content-header">
                                <h2 class="content-title">메디톡</h2>
                                <!-- 모바일 버전에서만 보이도록 설정할 셀렉트 박스 -->
                                <select class="sort-select mobile-only" onchange="sortPosts(this.value)">
                                    <option value="조회수">추천수</option>
                                    <option value="작성일">작성일</option>
                                    <option value="카테고리">카테고리</option>
                                </select>
                            </div>
                            <div class="content-controls">
                                <p class="content-description">닥터링의 새로운 소식들과 유용한 정보들을 한곳에서 확인하세요.</p>
                                <!-- 웹 버전에서만 보이도록 설정할 셀렉트 박스 -->
                                <select class="sort-select web-only" onchange="sortPosts(this.value)">
                                    <option value="조회수">조회수</option>
                                    <option value="작성일">작성일</option>
                                    <option value="카테고리">카테고리</option>
                                </select>
                            </div>
                            <!-- Table for Posts -->
                            <table id="postsTable" class="notice-table">
                                <thead>
                                    <tr>
                                        <th class="category-header">카테고리</th>
                                        <th class="title-header">제목</th>
                                        <th class="author-header">작성자</th>
                                        <th class="date-header">작성일</th>
                                        <th class="comment-header">조회수</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Example Post Item -->
                                    <tr>
                                        <td class="category-header">이벤트</td>
                                        <td><a href="/post-detail.html?id=1">2024 수능 기념 스마일 라식 할인!</a></td>
                                        <td class="author">관리자1</td>
                                        <td class="date">2022.07.27</td>
                                        <td class="comment-header">[45]</td>
                                    </tr>
                                    <tr>
                                        <td>의료소통</td>
                                        <td><a href="/post-detail.html?id=784">상처에 된장 바르면 치료가 되나요?</a></td>
                                        <td class="author">paris3131</td>
                                        <td class="date">2024.11.01</td>
                                        <td>[45]</td>
                                    </tr>
                                    <tr>
                                        <td>의료소통</td>
                                        <td><a href="/post-detail.html?id=784">상처에 된장 바르면 치료가 되나요?</a></td>
                                        <td class="author">paris3131</td>
                                        <td class="date">2024.11.01</td>
                                        <td>[45]</td>
                                    </tr>
                                    <tr>
                                        <td>의료소통</td>
                                        <td><a href="/post-detail.html?id=784">상처에 된장 바르면 치료가 되나요?</a></td>
                                        <td class="author">paris3131</td>
                                        <td class="date">2024.11.01</td>
                                        <td>[45]</td>
                                    </tr>
                                    <tr>
                                        <td>의료소통</td>
                                        <td><a href="/post-detail.html?id=784">상처에 된장 바르면 치료가 되나요?</a></td>
                                        <td class="author">paris3131</td>
                                        <td class="date">2024.11.01</td>
                                        <td>[45]</td>
                                    </tr>
                                    <tr>
                                        <td>의료소통</td>
                                        <td><a href="/post-detail.html?id=784">상처에 된장 바르면 치료가 되나요?</a></td>
                                        <td class="author">paris3131</td>
                                        <td class="date">2024.11.01</td>
                                        <td>[45]</td>
                                    </tr>
                                    <tr>
                                        <td>의료소통</td>
                                        <td><a href="/post-detail.html?id=784">상처에 된장 바르면 치료가 되나요?</a></td>
                                        <td class="author">paris3131</td>
                                        <td class="date">2024.11.01</td>
                                        <td>[45]</td>
                                    </tr>
                                    <tr>
                                        <td>의료소통</td>
                                        <td><a href="/post-detail.html?id=784">상처에 된장 바르면 치료가 되나요?</a></td>
                                        <td class="author">paris3131</td>
                                        <td class="date">2024.11.01</td>
                                        <td>[45]</td>
                                    </tr>
                                    <tr>
                                        <td>의료소통</td>
                                        <td><a href="/post-detail.html?id=784">상처에 된장 바르면 치료가 되나요?</a></td>
                                        <td class="author">paris3131</td>
                                        <td class="date">2024.11.01</td>
                                        <td>[45]</td>
                                    </tr>
                                    <tr>
                                        <td>의료소통</td>
                                        <td><a href="/post-detail.html?id=784">상처에 된장 바르면 치료가 되나요?</a></td>
                                        <td class="author">paris3131</td>
                                        <td class="date">2024.11.01</td>
                                        <td>[45]</td>
                                    </tr>
                                    <tr>
                                        <td>일반</td>
                                        <td><a href="/post-detail.html?id=784">점심 메뉴 추천 해주세요 맛있는거</a></td>
                                        <td class="author">jjhim531</td>
                                        <td class="date">2024.11.01</td>
                                        <td>[45]</td>
                                    </tr>
                                    <tr>
                                        <td>이벤트</td>
                                        <td><a href="/post-detail.html?id=1">2024 수능 기념 스마일 라식 할인!</a></td>
                                        <td class="author">관리자1</td>
                                        <td class="date">2022.07.27</td>
                                        <td>[45]</td>
                                    </tr>
                                    <tr>
                                        <td>일반</td>
                                        <td><a href="/post-detail.html?id=784">길에서 눕고 싶어요</a></td>
                                        <td class="author">mingdi0824</td>
                                        <td class="date">2024.10.02</td>
                                        <td>[45]</td>
                                    </tr>
                                    <tr>
                                        <td>의료소통</td>
                                        <td><a href="/post-detail.html?id=784">상처에 된장 바르면 치료가 되나요?</a></td>
                                        <td class="author">paris3131</td>
                                        <td class="date">2024.11.01</td>
                                        <td>[45]</td>
                                    </tr>
                                    <tr>
                                        <td>의료소통</td>
                                        <td><a href="/post-detail.html?id=784">상처에 된장 바르면 치료가 되나요?</a></td>
                                        <td class="author">paris3131</td>
                                        <td class="date">2024.11.01</td>
                                        <td>[45]</td>
                                    </tr>

                                    <tr>
                                        <td>일반</td>
                                        <td><a href="/post-detail.html?id=784">길에서 눕고 싶어요</a></td>
                                        <td class="author">mingdi0824</td>
                                        <td class="date">2024.10.02</td>
                                        <td>[45]</td>
                                    </tr>
                                    <tr>
                                        <td>일반</td>
                                        <td><a href="/post-detail.html?id=784">길에서 눕고 싶어요</a></td>
                                        <td class="author">mingdi0824</td>
                                        <td class="date">2024.10.02</td>
                                        <td>[45]</td>
                                    </tr>
                                    <tr>
                                        <td>의료소통</td>
                                        <td><a href="/post-detail.html?id=784">상처에 된장 바르면 치료가 되나요?</a></td>
                                        <td class="author">paris3131</td>
                                        <td class="date">2024.11.01</td>
                                        <td>[45]</td>
                                    </tr>
                                    <tr>
                                        <td>의료소통</td>
                                        <td><a href="/post-detail.html?id=784">상처에 된장 바르면 치료가 되나요?</a></td>
                                        <td class="author">paris3131</td>
                                        <td class="date">2024.11.01</td>
                                        <td>[45]</td>
                                    </tr>
                                    <tr>
                                        <td>의료소통</td>
                                        <td><a href="/post-detail.html?id=784">상처에 된장 바르면 치료가 되나요?</a></td>
                                        <td class="author">paris3131</td>
                                        <td class="date">2024.11.01</td>
                                        <td>[45]</td>
                                    </tr>

                                    <!-- Additional rows as needed -->
                                </tbody>
                            </table>
                            <!-- Pagination Footer -->
                            <footer class="pagination-footer">
                                <div class="pagination">
                                    <a href="?page=1">1</a>
                                    <a href="?page=2">2</a>
                                    <a href="?page=3">3</a>
                                    <a href="?page=4">4</a>
                                    <a href="?page=5">5</a>
                                </div>
                                <button class="write-button">글쓰기</button>
                            </footer>
                        </section>
                        <div class="empty-space"></div> <!-- 오른쪽 빈 공간 -->
                    </main>
                    <!-- JavaScript 코드 추가 -->
                    <script>
                        function parseDate(dateStr) {
                            const [year, month, day] = dateStr.split(".");
                            return new Date(year, month - 1, day);
                        }

                        function extractNumber(text) {
                            return parseInt(text.replace(/[^0-9]/g, ''), 10);
                        }

                        function sortPosts(sortBy) {
                            const table = document.getElementById("postsTable");
                            const rows = Array.from(table.getElementsByTagName("tr")).slice(1);

                            rows.sort((a, b) => {
                                let tdA, tdB;

                                if (sortBy === "조회수") {
                                    tdA = extractNumber(a.getElementsByTagName("td")[4].innerText);
                                    tdB = extractNumber(b.getElementsByTagName("td")[4].innerText);
                                    return tdB - tdA; // 내림차순
                                } else if (sortBy === "작성일") {
                                    tdA = parseDate(a.getElementsByTagName("td")[3].innerText);
                                    tdB = parseDate(b.getElementsByTagName("td")[3].innerText);
                                    return tdB - tdA; // 내림차순
                                } else {
                                    tdA = a.getElementsByTagName("td")[0].innerText;
                                    tdB = b.getElementsByTagName("td")[0].innerText;
                                    return tdA.localeCompare(tdB, 'ko'); // 가나다순
                                }
                            });

                            rows.forEach(row => table.getElementsByTagName("tbody")[0].appendChild(row));
                        }
                    </script>