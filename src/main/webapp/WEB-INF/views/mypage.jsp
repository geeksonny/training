<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<html>
<head>
    <title>My Page</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/resources/css/mypage.css'/>">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <style>
        /* 컨텐츠 영역 */
        .main-content {
            padding: 20px;
        }

        .content {
            display: none;
        }

        .content.active {
            display: block;
        }
    </style>
    <script>
        $(document).ready(function () {
            // 탭 클릭 시
            $(".sidebar a").click(function () {
                $(".content").removeClass("active");
                $("#" + $(this).attr("data-target")).addClass("active");
                // 현재 탭 정보를 hidden input에 설정
                $("#currentTab").val($(this).attr("data-target"));
            });

            // URL에서 탭 정보 확인 및 해당 탭 활성화
            let urlParams = new URLSearchParams(window.location.search);
            let activeTab = urlParams.get('tab');
            if (activeTab) {
                $(".content").removeClass("active");
                $("#" + activeTab).addClass("active");
                // 사이드바의 해당 링크도 활성화 상태로 설정
                $(".sidebar a[data-target='" + activeTab + "']").addClass("active");
            } else {
                // 기본 탭 활성화
                $(".sidebar a:first").click();
            }
        });
    </script>
</head>
<body>
<jsp:include page="inc/header.jsp"/>

<div class="wrapper">
    <div class="sidebar">
        <h2>My Page</h2>
        <a href="#" data-target="reservation">운동 예약 내역</a>
        <a href="#" data-target="my-posts">나의 글</a>
        <a href="#" data-target="my-comments">나의 댓글</a>
        <a href="#" data-target="my-info">나의 정보</a>
    </div>
    <div class="main-content">
        <!-- 운동 예약 내역 -->
        <div class="content" id="reservation">
            <h3>운동 예약 내역</h3>
            <ul class="nav nav-tabs" id="reservationTabs" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="current-reservation-tab" data-toggle="tab" href="#current-reservation" role="tab" aria-controls="current-reservation" aria-selected="true">현재 예약</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="cancelled-reservation-tab" data-toggle="tab" href="#cancelled-reservation" role="tab" aria-controls="cancelled-reservation" aria-selected="false">예약 취소</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="completed-reservation-tab" data-toggle="tab" href="#completed-reservation" role="tab" aria-controls="completed-reservation" aria-selected="false">사용 완료</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="total-reservation-tab" data-toggle="tab" href="#total-reservation" role="tab" aria-controls="total-reservation" aria-selected="false">총 예약</a>
                </li>
            </ul>
            <div class="tab-content" id="reservationTabContent">
                <!-- 현재 예약 -->
                <div class="tab-pane fade show active" id="current-reservation" role="tabpanel" aria-labelledby="current-reservation-tab">
                    <div class="container-xxl flex-grow-1 container-p-y">
                        <div class="row">
                            <div class="col-12 col-md-8 col-lg-12">
                                <div class="row">
                                    <div class="col-4 mb-4">
                                        <div class="card">
                                            <div class="card-body">
                                                <div class="card-title d-flex align-items-start justify-content-between">
                                                    <div class="avatar flex-shrink-0">
                                                    </div>
                                                </div>
                                                <span class="fw-semibold d-block mb-1">현재 예약 내역</span>
                                                <h3 class="card-title mb-2">${countReserve}개</h3>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 현재 예약 목록 -->
                                    <c:forEach var="reserveDto" items="${curReserveList}">
                                        <div class="col-12 mb-4">
                                            <div class="card">
                                                <div class="card-body">
                                                    <h5 class="card-title">${reserveDto.type}</h5>
                                                    <p class="card-text">예약 시간: <fmt:formatDate value="${reserveDto.start_time}" pattern="yyyy-MM-dd HH:mm" type="date"/> ~ <fmt:formatDate value="${reserveDto.end_time}" pattern="yyyy-MM-dd HH:mm" type="date"/></p>
                                                    <c:if test="${reserveDto.reserve_state eq 0}">
                                                    <p class="card-text">상태: 예약 완료</p> <input type="button" value="사용 완료" id="completeBtn"> <input type="button" value="예약 취소" id="canceledBtn">
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 예약 취소 -->
                <div class="tab-pane fade" id="cancelled-reservation" role="tabpanel" aria-labelledby="cancelled-reservation-tab">
                    <div class="container-xxl flex-grow-1 container-p-y">
                        <div class="row">
                            <div class="col-12 col-md-8 col-lg-12">
                                <div class="row">
                                    <div class="col-4 mb-4">
                                        <div class="card">
                                            <div class="card-body">
                                                <div class="card-title d-flex align-items-start justify-content-between">
                                                    <div class="avatar flex-shrink-0">
                                                    </div>
                                                </div>
                                                <span class="fw-semibold d-block mb-1">예약 취소 내역</span>
                                                <h3 class="card-title mb-2">${countCanceled}개</h3>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 예약 취소 목록 -->
                                    <c:forEach var="reserveDto" items="${canceledReserveList}">
                                        <div class="col-12 mb-4">
                                            <div class="card">
                                                <div class="card-body">
                                                    <h5 class="card-title">${reserveDto.type}</h5>
                                                    <p class="card-text">예약 시간: <fmt:formatDate value="${reserveDto.start_time}" pattern="yyyy-MM-dd HH:mm" type="date"/> ~ <fmt:formatDate value="${reserveDto.end_time}" pattern="yyyy-MM-dd HH:mm" type="date"/></p>
                                                    <c:if test="${reserveDto.reserve_state eq 1}">
                                                    <p class="card-text">상태: 예약 취소 </p>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 사용 완료 -->
                <div class="tab-pane fade" id="completed-reservation" role="tabpanel" aria-labelledby="completed-reservation-tab">
                    <div class="container-xxl flex-grow-1 container-p-y">
                        <div class="row">
                            <div class="col-12 col-md-8 col-lg-12">
                                <div class="row">
                                    <div class="col-4 mb-4">
                                        <div class="card">
                                            <div class="card-body">
                                                <div class="card-title d-flex align-items-start justify-content-between">
                                                    <div class="avatar flex-shrink-0">
                                                    </div>
                                                </div>
                                                <span class="fw-semibold d-block mb-1">사용 완료 내역</span>
                                                <h3 class="card-title mb-2">${countCompleted}개</h3>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 사용 완료 목록 -->
                                    <c:forEach var="reserveDto" items="${comReserveList}">
                                        <div class="col-12 mb-4">
                                            <div class="card">
                                                <div class="card-body">
                                                    <h5 class="card-title">${reserveDto.type}</h5>
                                                    <p class="card-text">예약 시간: <fmt:formatDate value="${reserveDto.start_time}" pattern="yyyy-MM-dd HH:mm" type="date"/> ~ <fmt:formatDate value="${reserveDto.end_time}" pattern="yyyy-MM-dd HH:mm" type="date"/></p>
                                                    <c:if test="${reserveDto.reserve_state eq 2}">
                                                    <p class="card-text">상태: 사용 완료</p>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 총 예약 -->
                <div class="tab-pane fade" id="total-reservation" role="tabpanel" aria-labelledby="total-reservation-tab">
                    <div class="container-xxl flex-grow-1 container-p-y">
                        <div class="row">
                            <div class="col-12 col-md-8 col-lg-12">
                                <div class="row">
                                    <div class="col-4 mb-4">
                                        <div class="card">
                                            <div class="card-body">
                                                <div class="card-title d-flex align-items-start justify-content-between">
                                                    <div class="avatar flex-shrink-0">
                                                    </div>
                                                </div>
                                                <span class="fw-semibold d-block mb-1">총 예약 내역</span>
                                                <h3 class="card-title mb-2">${countReservation}개</h3>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 총 예약 목록 -->
                                    <c:forEach var="reserveDto" items="${reserveList}">
                                        <div class="col-12 mb-4">
                                            <div class="card">
                                                <div class="card-body">
                                                    <h5 class="card-title">${reserveDto.type}</h5>
                                                    <p class="card-text">예약 시간: <fmt:formatDate value="${reserveDto.start_time}" pattern="yyyy-MM-dd HH:mm" type="date"/> ~ <fmt:formatDate value="${reserveDto.end_time}" pattern="yyyy-MM-dd HH:mm" type="date"/></p>
                                                    <c:choose>
                                                        <c:when test="${reserveDto.reserve_state eq 0}">
                                                        <p class="card-text">상태: 예약 완료</p> <input type="button" value="사용 완료" id="completeBtn"> <input type="button" value="예약 취소" id="canceledBtn">
                                                        </c:when>
                                                        <c:when test="${reserveDto.reserve_state eq 1}">
                                                            <p class="card-text">상태: 예약 취소</p>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <p class="card-text">상태: 사용 완료</p>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 나의 글 -->
        <div class="content" id="my-posts">
            <div class="container-xxl flex-grow-1 container-p-y">
                <div class="row">
                    <div class="col-12 col-md-8 col-lg-12">
                        <div class="row">
                            <div class="col-4 mb-4">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="card-title d-flex align-items-start justify-content-between">
                                            <div class="avatar flex-shrink-0">
                                            </div>
                                        </div>
                                        <span class="fw-semibold d-block mb-1">나의 글</span>
                                        <h3 class="card-title text-nowrap mb-2">${countWrite}개</h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- 나의 글 목록 -->
                        <div class="board-container">
                            <table>
                                <tr>
                                    <th><a href="${pageContext.request.contextPath}/board/board"><input type="button" class="btn-write" value="글쓰기"></a></th>
                                </tr>
                                <tr>
                                    <th>번호</th>
                                    <th>제목</th>
                                    <th>글쓴이</th>
                                    <th>작성일</th>
                                    <th>조회수</th>
                                </tr>
                                <c:forEach var="boardDto" items="${boardList}">
                                    <tr>
                                        <td>${boardDto.bno}</td>
                                        <td><a href="<c:url value="/board/read${ph.sc.queryString}&bno=${boardDto.bno}"/>"><c:out value='${boardDto.title}'/></a></td>
                                        <td>${boardDto.writer}</td>
                                        <c:choose>
                                            <c:when test="${boardDto.reg_date.time >= startOfToday}">
                                                <td><fmt:formatDate value="${boardDto.reg_date}" pattern="HH:mm" type="time"/></td>
                                            </c:when>
                                            <c:otherwise>
                                                <td><fmt:formatDate value="${boardDto.reg_date}" pattern="yyyy-MM-dd" type="date"/></td>
                                            </c:otherwise>
                                        </c:choose>
                                        <td>${boardDto.view_cnt}</td>
                                    </tr>
                                </c:forEach>
                            </table>
                            <br>
                            <div class="search-form text-center">
                                <form action="<c:url value="/mypage/"/>" method="get">
                                    <select name="option" class="search-option">
                                        <option value="A" ${ph.sc.option=='A' || ph.sc.option=='' ? "selected" : ""}>제목+내용</option>
                                        <option value="T" ${ph.sc.option=='T' ? "selected" : ""}>제목만</option>
                                        <option value="W" ${ph.sc.option=='W' ? "selected" : ""}>작성자</option>
                                    </select>
                                    <input type="hidden" name="tab" id="currentTab" value="my-posts">
                                    <input type="text" name="keyword"  class="search-input" value="${ph.sc.keyword}" placeholder="검색어를 입력해주세요">
                                    <input type="submit" class="search-button" value="검색">
                                </form>
                                <br>
                            </div>
                            <div class="paging-container text-center">
                                <div class="paging">
                                    <c:if test="${ph.totalCnt==null || ph.totalCnt==0}">
                                        <div> 게시물이 없습니다. </div>
                                    </c:if>
                                    <c:if test="${ph.totalCnt!=null && ph.totalCnt!=0}">
                                        <c:if test="${ph.showPrev}">
                                            <a class="page" href="<c:url value="/mypage${ph.sc.getQueryString(ph.beginPage-1)}&tab=my-posts"/>">&lt;</a>
                                        </c:if>
                                        <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
                                            <a class="page ${i==ph.sc.page? "paging-active" : ""}" href="<c:url value="/mypage${ph.sc.getQueryString(i)}&tab=my-posts"/>">${i}</a>
                                        </c:forEach>
                                        <c:if test="${ph.showNext}">
                                            <a class="page" href="<c:url value="/mypage${ph.sc.getQueryString(ph.endPage+1)}&tab=my-posts"/>">&gt;</a>
                                        </c:if>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 나의 댓글 -->
        <div class="content" id="my-comments">
            <div class="container-xxl flex-grow-1 container-p-y">
                <div class="row">
                    <div class="col-12 col-md-8 col-lg-12">
                        <div class="row">
                            <div class="col-4 mb-4">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="card-title d-flex align-items-start justify-content-between">
                                            <div class="avatar flex-shrink-0">
                                            </div>
                                        </div>
                                        <span class="fw-semibold d-block mb-1">나의 댓글</span>
                                        <h3 class="card-title mb-2">${countComment}개</h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 나의 정보 -->
        <div class="content" id="my-info">
            <div class="container-xxl flex-grow-1 container-p-y">
                <div class="row">
                    <div class="col-12 col-lg-12">
                        <div class="card">
                            <div class="row row-bordered g-0">
                                <div class="col-md-12">
                                    <h5 class="card-body m-0 me-2 pb-3">나의 정보</h5>
                                    <div class="card-body">
                                        <table class="table table">
                                            <tr>
                                                <th><span class="d-block">ID</span></th>
                                                <td><span class="d-block">${user.id}</span></td>
                                            </tr>
                                            <tr>
                                                <th><span class="d-block">이름</span></th>
                                                <td><span class="d-block">${user.name}</span></td>
                                            </tr>
                                            <tr>
                                                <th><span class="d-block">메일</span></th>
                                                <td><span class="d-block">${user.email}</span></td>
                                            </tr>
                                            <tr>
                                                <th><span class="d-block">생년월일</span></th>
                                                <td><span class="d-block"><fmt:formatDate value="${user.birth}" pattern="yyyy-MM-dd" type="date"/></span></td>
                                            </tr>
                                            <tr>
                                                <th><span class="d-block">가입일</span></th>
                                                <td><span class="d-block"><fmt:formatDate value="${user.reg_date}" pattern="yyyy-MM-dd HH:mm" type="date"/></span></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="inc/footer.jsp"/>
</body>
</html>
