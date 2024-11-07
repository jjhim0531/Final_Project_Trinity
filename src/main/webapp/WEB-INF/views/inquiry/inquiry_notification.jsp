<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/common/defalut.css">
            <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/inquiry/inquiry_notification.css">
            <title>Customer Center</title>
        </head>

        <body>
            <div>
                <!-- Header Section -->
                <header class="header">
                    <%@ include file="/WEB-INF/views/common/main_header.jsp" %>
                </header>

                <div class="container">
                    <!-- Main Content Section -->
                    <main class="main-content">
                        <!-- Sidebar Menu -->
                        <aside class="sidebar">

                            <ul class="menu">
                                <li><a href="#"class="active">공지사항<span class="arrow">›</span></a></li>
                                <li><a href="#">알림판<span class="arrow">›</span></a></li>
                                <li><a href="#">FAQ<span class="arrow">›</span></a></li>
                                <li><a href="#">Q&A<span class="arrow">›</span></a></li>
                            </ul>
                            <div class="support-box">
                                <p class="support-text">도움이 필요하신가요?</p>
                                <a href="#" class="support-link">1:1 문의하기</a>
                            </div>
                        </aside>


                        <!-- Content Section -->
                        <section class="notice-content">
                            <div class="content-header">
                                <h2 class="content-title">공지사항</h2>
                                <!-- 모바일 버전에서만 보이도록 설정할 셀렉트 박스 -->
                                <select class="sort-select mobile-only" onchange="sortPosts(this.value)">
                                    <option value="조회수">조회수</option>
                                    <option value="번호순">번호순</option>
                                </select>
                            </div>
                            <div class="content-controls">
                                <p class="content-description">닥터링 공지사항입니다.</p>
                                <!-- 웹 버전에서만 보이도록 설정할 셀렉트 박스 -->
                                <select class="sort-select web-only" onchange="sortPosts(this.value)">
                                    <option value="조회수">조회수</option>
                                    <option value="작성일">작성일</option>
                                    <option value="번호순">번호순</option>
                                </select>
                            </div>
                            <!-- Table for Posts -->
                            <table id="postsTable" class="notice-table">
                                <thead>
                                    <tr>
                                        <th class="category-header">번호</th>
                                        <th class="title-header">제목</th>
                                        <th class="author-header">작성자</th>
                                        <th class="date-header">작성일</th>
                                        <th class="comment-header">조회수</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Example Post Item -->
                                    <tr>
                                        <td>1</td>
                                        <td><a href="/post-detail.html?id=1">2023년 11월 병원 정보 업데이트</a></td>
                                        <td class="author">관리자</td>
                                        <td class="date">2023.11.01</td>
                                        <td class="comment-header">43</td>
                                    </tr>

                                    <tr>
                                        <td>2</td>
                                        <td><a href="/post-detail.html?id=1">2023년 12월 병원 정보 업데이트</a></td>
                                        <td class="author">관리자</td>
                                        <td class="date">2023.12.01</td>
                                        <td>42</td>
                                    </tr>
                                    
                                    <tr>
                                        <td>3</td>
                                        <td><a href="/post-detail.html?id=1">2024년 1월 병원 정보 업데이트</a></td>
                                        <td class="author">관리자</td>
                                        <td class="date">2024.01.01</td>
                                        <td class="comment-header">46</td>
                                    </tr>

                                    <tr>
                                        <td>4</td>
                                        <td><a href="/post-detail.html?id=1">2024년 2월 병원 정보 업데이트</a></td>
                                        <td class="author">관리자</td>
                                        <td class="date">2024.02.01</td>
                                        <td>65</td>
                                    </tr>
                                    
                                    <tr>
                                        <td>5</td>
                                        <td><a href="/post-detail.html?id=1">2024년 3월 병원 정보 업데이트</a></td>
                                        <td class="author">관리자</td>
                                        <td class="date">2024.03.01</td>
                                        <td class="comment-header">20</td>
                                    </tr>

                                    <tr>
                                        <td>6</td>
                                        <td><a href="/post-detail.html?id=1">2024년 4월 병원 정보 업데이트</a></td>
                                        <td class="author">관리자</td>
                                        <td class="date">2024.04.01</td>
                                        <td>40</td>
                                    </tr>
                                    
                                    <tr>
                                        <td>7</td>
                                        <td><a href="/post-detail.html?id=1">2024년 5월 병원 정보 업데이트</a></td>
                                        <td class="author">관리자</td>
                                        <td class="date">2024.05.01</td>
                                        <td class="comment-header">55</td>
                                    </tr>

                                    <tr>
                                        <td>8</td>
                                        <td><a href="/post-detail.html?id=1">2024년 6월 병원 정보 업데이트</a></td>
                                        <td class="author">관리자</td>
                                        <td class="date">2024.06.01</td>
                                        <td>34</td>
                                    </tr>
                                    
                                    <tr>
                                        <td>9</td>
                                        <td><a href="/post-detail.html?id=1">2024년 7월 병원 정보 업데이트</a></td>
                                        <td class="author">관리자</td>
                                        <td class="date">2024.07.01</td>
                                        <td class="comment-header">23</td>
                                    </tr>

                                    <tr>
                                        <td>10</td>
                                        <td><a href="/post-detail.html?id=1">2024년 8월 병원 정보 업데이트</a></td>
                                        <td class="author">관리자</td>
                                        <td class="date">2024.08.01</td>
                                        <td>45</td>
                                    </tr>
                                    
                                    <tr>
                                        <td>11</td>
                                        <td><a href="/post-detail.html?id=1">2024년 9월 병원 정보 업데이트</a></td>
                                        <td class="author">관리자</td>
                                        <td class="date">2024.09.01</td>
                                        <td class="comment-header">56</td>
                                    </tr>

                                    <tr>
                                        <td>12</td>
                                        <td><a href="/post-detail.html?id=1">2024년 10월 병원 정보 업데이트</a></td>
                                        <td class="author">관리자</td>
                                        <td class="date">2024.10.01</td>
                                        <td>61</td>
                                    </tr>
                                    
                                    <tr>
                                        <td>13</td>
                                        <td><a href="/post-detail.html?id=1">2024년 11월 병원 정보 업데이트</a></td>
                                        <td class="author">관리자</td>
                                        <td class="date">2024.11.01</td>
                                        <td class="comment-header">70</td>
                                    </tr>

                                    <tr>
                                        <td>14</td>
                                        <td><a href="/post-detail.html?id=1">2024년 12월 병원 정보 업데이트</a></td>
                                        <td class="author">관리자</td>
                                        <td class="date">2024.12.01</td>
                                        <td>80</td>
                                    </tr>
                                    

                                    <!-- Additional rows as needed -->
                                </tbody>
                            </table>
                            <!-- 페이지네이션과 검색 섹션을 포함하는 div -->
                            <div class="page-search-container">
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
                                <!-- 검색 필드 섹션 -->
                                <div class="search-section">
                                    <select class="search-type">
                                        <option value="title">제목만</option>
                                        <option value="author">글작성자</option>
                                        <option value="content">댓글내용</option>
                                    </select>
                                    <input type="text" class="search-input" placeholder="검색어를 입력해주세요" />
                                    <button class="search-button">검색</button>
                                </div>
                            </div>

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