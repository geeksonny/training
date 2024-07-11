<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>My Page</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/resources/css/mypage.css'/>">
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
            $(".sidebar a").click(function () {
                $(".content").removeClass("active");
                $("#" + $(this).attr("data-target")).addClass("active");
            });

            $(".sidebar a:first").click();
        });
    </script>
</head>
<body>
<jsp:include page="inc/header.jsp"/>

<div class="wrapper">
    <div class="sidebar">
        <h2>관리자 페이지</h2>
        <a href="#" data-target="reservation">전체 운동 예약 내역</a>
        <a href="#" data-target="equipment">운동기구 관리</a>
        <a href="#" data-target="my-posts">회원 게시판 관리</a>
        <a href="#" data-target="my-comments">댓글 관리</a>
        <a href="#" data-target="my-info">회원 정보 관리</a>
    </div>
    <div class="main-content">
        <!-- 운동 예약 내역 -->
        <div class="content" id="reservation">
            <div class="container-xxl flex-grow-1 container-p-y">
                <div class="row">
                    <div class="col-12 col-md-8 col-lg-12">
                        <div class="row">
                            <div class="col-4 mb-4">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="card-title d-flex align-items-start justify-content-between">
                                            <div class="avatar flex-shrink-0">
                                                <img src="${pageContext.request.contextPath}/resources/assets/img/icons/unicons/chart.png" alt="Credit Card" class="rounded"/>
                                            </div>
                                        </div>
                                        <span class="fw-semibold d-block mb-1">운동 예약 내역</span>
                                        <h3 class="card-title mb-2">${mypageDTO2.productLike}개</h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 운동 기구 관리 -->
        <div class="content" id="equipment">
            <div class="container-xxl flex-grow-1 container-p-y">
                <div class="row">
                    <div class="col-12 col-md-8 col-lg-12">
                        <div class="row">
                            <div class="col-4 mb-4">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="card-title d-flex align-items-start justify-content-between">
                                            <div class="avatar flex-shrink-0">
                                                <img src="${pageContext.request.contextPath}/resources/assets/img/icons/unicons/chart.png" alt="Credit Card" class="rounded"/>
                                            </div>
                                        </div>
                                        <span class="fw-semibold d-block mb-1">운동기구 관리</span>
                                        <h3 class="card-title mb-2">${mypageDTO2.productLike}개</h3>
                                    </div>
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
                                                <img src="${pageContext.request.contextPath}/resources/assets/img/icons/unicons/chart-success.png" alt="Credit Card" class="rounded"/>
                                            </div>
                                        </div>
                                        <span class="fw-semibold d-block mb-1">나의 글</span>
                                        <h3 class="card-title text-nowrap mb-2">${mypageDTO2.boardCount}개</h3>
                                    </div>
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
                                                <img src="${pageContext.request.contextPath}/resources/assets/img/icons/unicons/chart.png" alt="Credit Card" class="rounded"/>
                                            </div>
                                        </div>
                                        <span class="fw-semibold d-block mb-1">나의 댓글</span>
                                        <h3 class="card-title mb-2">${mypageDTO2.replyCount}개</h3>
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
                                                <td><span class="d-block">${memberDTO.userId}</span></td>
                                            </tr>
                                            <tr>
                                                <th><span class="d-block">이름</span></th>
                                                <td><span class="d-block">${memberDTO.userNm}</span></td>
                                            </tr>
                                            <tr>
                                                <th><span class="d-block">메일</span></th>
                                                <td><span class="d-block">${memberDTO.userEmail}</span></td>
                                            </tr>
                                            <tr>
                                                <th><span class="d-block">연락처</span></th>
                                                <td><span class="d-block">${memberDTO.userPhone}</span></td>
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
