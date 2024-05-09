<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <title>Title</title>
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
            height: 400px; /* 이미지 높이를 조절할 수 있습니다. 필요에 따라 변경할 수 있습니다. */
            object-fit: contain; /* 이미지를 카드 영역에 꽉 차도록 채웁니다. */
        }

        .card-heading a:hover {
            background-color: #f8f9fa;
        }
        .card {
            display: flex;
            flex-direction: column;
            height: 100%;
            /*width: 250px;*/
        }

        .card-body {
            flex-grow: 1;
        }

        .card-footer {
            flex-shrink: 0;
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


        .fixed-footer {
            position: relative;
            bottom: 0;
            left: 0;
            width: 100%;
            background-color: #f8f9fa;
            padding: 20px;
            box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.1);
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
                <span class="icon_search"></span>Search</button>
            </form>
        </div>
        <div class="shop__sidebar__accordion">
            <div class="accordion" id="accordionExample">
                <!-- 카테고리 시작 -->
                <div class="card">
                    <div class="card-heading">
                        <a data-toggle="collapse" data-target="#collapseOne">전체</a>
                    </div>
                    <div id="collapseOne" class="collapse show" data-parent="#accordionExample">
                        <div class="card-body">
                            <div class="shop__sidebar__categories">
                                <ul class="nice-scroll">
                                    <li><a href="#" id="upperBody" >상체</a></li>
                                    <li><a href="#" id="lowerBody" >하체</a></li>
                                    <li><a href="#" id="breath" >유산소</a></li>
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
                <%--   운동기구 목록 리스트  --%>
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
    <!-- Section end -->

    <!-- Paging container -->
    <div class="paging-container text-center">
        <div class="paging">
            <c:if test="${ph.totalCnt==null || ph.totalCnt==0}">
                <div> 운동기구가 없습니다. </div>
            </c:if>
            <c:if test="${ph.totalCnt!=null && ph.totalCnt!=0}">
                <c:if test="${ph.showPrev}">
                    <a class="page" href="<c:url value="/reserve/list${ph.sc.getQueryString(ph.beginPage-1)}"/>">&lt;</a>
                </c:if>
                <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
                    <a class="page ${i==ph.sc.page? "paging-active" : ""}" href="<c:url value="/reserve/list${ph.sc.getQueryString(i)}"/>">${i}</a>
                </c:forEach>
                <c:if test="${ph.showNext}">
                    <a class="page" href="<c:url value="/reserve/list${ph.sc.getQueryString(ph.endPage+1)}"/>">&gt;</a>
                </c:if>
            </c:if>
        </div>
    </div>
    <!-- Paging container end -->
</div>
<!-- Main content end -->

<!-- Fixed footer -->
<footer class="fixed-footer">
    <jsp:include page="../inc/footer.jsp"/>
</footer>
<!-- Fixed footer end -->


</body>
</html>
