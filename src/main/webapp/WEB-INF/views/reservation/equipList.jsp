<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <title>Title</title>
    <script>
        let msg = "${msg}";
        if(msg=="RESERVE_OK")    alert("성공적으로 예약하셨습니다.");

        let selectedCategory = null;

        $(document).ready(function() {
            // 각 카테고리 버튼에 대한 클릭 이벤트 처리
            $('#upperBody, #lowerBody, #breath').click(function() {
                selectedCategory = $(this).val();
                loadEquipmentsByCategory(selectedCategory); // 해당 카테고리에 맞는 기구 목록을 불러오는 함수 호출
            });

            // 전체 버튼에 대한 클릭 이벤트 처리
            $('#all').click(function() {
                selectedCategory = null;
                loadAllEquipments();
            });

        });


        // 카테고리에 따른 기구 목록을 불러오는 함수
        function loadEquipmentsByCategory(eCategory) {
            let pageUrl = '${pageContext.request.contextPath}/reserve/equipments?eCategory=' + eCategory;
            // 페이지 이동
            window.location.href = pageUrl;
        }

        // 모든 기구 목록을 불러오는 함수
        function loadAllEquipments() {
            let pageUrl = '${pageContext.request.contextPath}/reserve/list';
            window.location.href = pageUrl;
        }

    </script>
    <style>
        .shop__sidebar__categories ul {
            padding: 0;
            list-style: none;
        }

        .shop__sidebar__categories li {
            margin-bottom: 10px;
        }

        .shop__sidebar__categories a {
            display: block;
            padding: 10px;
            border-radius: 5px;
            background-color: #f8f9fa;
            color: #333;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .shop__sidebar__categories a:hover {
            background-color: #e9ecef;
        }

        .card-heading a {
            display: block;
            padding: 10px 15px;
            color: #333;
            text-decoration: none;
            font-weight: bold;
        }
        .card-img-top {
            width: 100%;
            height: 400px;
            object-fit: contain;
        }

        .card-heading a:hover {
            background-color: #f8f9fa;
        }
        .card {
            display: flex;
            flex-direction: column;
            height: 100%;
        }

        .card-body {
            flex-grow: 1;
        }

        .card-footer {
            flex-shrink: 0;
        }

        .category-button {
            display: block;
            padding: 10px;
            border-radius: 5px;
            background-color: #f8f9fa;
            color: #333;
            text-decoration: none;
            transition: background-color 0.3s ease;
            border: none;
            cursor: pointer;
            width: 100%;
            text-align: left;
        }

        .category-button:hover {
            background-color: #e9ecef;
        }

        .fixed-sidebar {
            position: fixed;
            left: 3%;
            overflow-y: auto;
            z-index: 1000;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 300px;   /* 사이드바 최대 너비 조정 */
            width: 25%;         /* 사이드바 기본 너비 조정 */
        }

        .main-content {
            margin-left: 10%;
            padding: 20px;
            margin-bottom: 100px;
        }


    </style>
</head>
<body>
<jsp:include page="../inc/header.jsp"/>
<!-- Header-->
<header class="bg-dark py-5">
    <div class="container px-4 px-lg-5 my-5">
        <div class="text-center text-white">
            <h1 class="display-4 fw-bolder">Hello! Let's Training!!</h1>
            <p class="lead fw-normal text-white-50 mb-0">With our comfortable home gym</p>
        </div>
    </div>
</header>

<!-- Fixed sidebar -->
<aside class="fixed-sidebar">
    <div class="shop__sidebar">
        <div class="shop__sidebar__search">
            <form>
                <input type="text" id="keyword" name="keyword"  placeholder="검색어를 입력하세요.">
                <button type="submit" id="submit" class="search">
                    <span class="icon_search"></span>검색
                </button>
            </form>
        </div>
        <div class="shop__sidebar__accordion">
            <div class="accordion" id="accordionExample">
                <!-- 카테고리 시작 -->
                <div class="card">
                    <div class="card-heading">
                        <button id="all" class="category-button">전체</button>
                    </div>
                    <div id="collapseOne" class="collapse show" data-parent="#accordionExample">
                        <div class="card-body">
                            <div class="shop__sidebar__categories">
                                <ul class="nice-scroll">
                                    <li><button id="upperBody" value="0" class="category-button">상체</button></li>
                                    <li><button id="lowerBody" value="1" class="category-button">하체</button></li>
                                    <li><button id="breath" value="2" class="category-button">유산소</button></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</aside>
<!-- Fixed sidebar end -->

<!-- Main content -->
<!-- Main content -->
<div class="main-content py-5" >
    <section>
        <div class="container px-4 px-lg-5">
            <div class="row gx-5 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                <c:forEach var="list" items="${list}" >
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Product image-->
                            <img class="card-img-top" src="${pageContext.request.contextPath}/resources/img/equip/${list.eMainimg}" alt="..." />
                            <input type="hidden" name="eno" value="${list.eno}}">
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder"><c:out value="${list.eName}" /></h5>
                                    <!-- Product price-->
                                    <c:if test="${list.eState==0}">
                                        09:00 ~ 23:00 예약가능
                                    </c:if>
                                    <c:if test="${list.eState==1}">
                                        기구 점검 중
                                    </c:if>
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center">
                                    <a class="btn btn-outline-dark mt-auto" href="<c:url value='/reserve/select?&page=${ph.sc.page}&pageSize=${ph.sc.pageSize}&eno=${list.eno}' />">View Reservation</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </section>
    <!-- Paging container -->
    <div class="paging-container text-center">
        <div class="paging">
            <c:if test="${ph.totalCnt==null || ph.totalCnt==0}">
                <div> 운동기구가 없습니다. </div>
            </c:if>
            <c:if test="${ph.totalCnt!=null && ph.totalCnt!=0}">
                <c:if test="${ph.showPrev}">
                    <%--                <a class="page" href="<c:url value="/reserve/equipments${ph.sc.getQueryString(ph.beginPage-1)}"/>">&lt;</a>--%>
                    <a class="page" href="<c:url value="/reserve/equipments?page=${ph.sc.beginPage-1}&pageSize=${ph.sc.pageSize}&eCategory=${eCategory}"/>">&lt;</a>
                </c:if>
                <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
                    <a class="page ${i==ph.sc.page? "paging-active" : ""}" href="<c:url value="/reserve/equipments?page=${i}&pageSize=${ph.sc.pageSize}&eCategory=${eCategory}"/>">${i}</a>
                </c:forEach>
                <c:if test="${ph.showNext}">
                    <a class="page" href="<c:url value="/reserve/equipments?page=${ph.sc.ph.endPage+1}&pageSize=${ph.sc.pageSize}&eCategory=${eCategory}"/>">&gt;</a>
                </c:if>
            </c:if>
        </div>
    </div>
</div>

</body>
</html>
