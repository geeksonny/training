<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<head>
    <title>Training Jone</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.122.0">

    <link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/headers/">



    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">

<%--    <link href="/docs/5.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">--%>
    <link rel="apple-touch-icon" href="/docs/5.3/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
    <link rel="icon" href="/docs/5.3/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
    <link rel="icon" href="/docs/5.3/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
    <link rel="manifest" href="/docs/5.3/assets/img/favicons/manifest.json">
    <link rel="mask-icon" href="/docs/5.3/assets/img/favicons/safari-pinned-tab.svg" color="#712cf9">
    <link rel="icon" href="/docs/5.3/assets/img/favicons/favicon.ico">
    <meta name="theme-color" content="#712cf9">


    <style>
        .bd-placeholder-img {
            font-size: 1.125rem;
            text-anchor: middle;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
        }

        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }

        .b-example-divider {
            width: 100%;
            height: 3rem;
            background-color: rgba(0, 0, 0, .1);
            border: solid rgba(0, 0, 0, .15);
            border-width: 1px 0;
            box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
        }

        .b-example-vr {
            flex-shrink: 0;
            width: 1.5rem;
            height: 100vh;
        }

        .bi {
            vertical-align: -.125em;
            fill: currentColor;
        }

        .nav-scroller {
            position: relative;
            z-index: 2;
            height: 2.75rem;
            overflow-y: hidden;
        }

        .nav-scroller .nav {
            display: flex;
            flex-wrap: nowrap;
            padding-bottom: 1rem;
            margin-top: -1px;
            overflow-x: auto;
            text-align: center;
            white-space: nowrap;
            -webkit-overflow-scrolling: touch;
        }

        .btn-bd-primary {
            --bd-violet-bg: #712cf9;
            --bd-violet-rgb: 112.520718, 44.062154, 249.437846;

            --bs-btn-font-weight: 600;
            --bs-btn-color: var(--bs-white);
            --bs-btn-bg: var(--bd-violet-bg);
            --bs-btn-border-color: var(--bd-violet-bg);
            --bs-btn-hover-color: var(--bs-white);
            --bs-btn-hover-bg: #6528e0;
            --bs-btn-hover-border-color: #6528e0;
            --bs-btn-focus-shadow-rgb: var(--bd-violet-rgb);
            --bs-btn-active-color: var(--bs-btn-hover-color);
            --bs-btn-active-bg: #5a23c8;
            --bs-btn-active-border-color: #5a23c8;
        }

        .bd-mode-toggle {
            z-index: 1500;
        }

        .bd-mode-toggle .dropdown-menu .active .bi {
            display: block !important;
        }
    </style>
</head>

<header class="p-3 text-bg-dark">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <img src="${pageContext.request.contextPath}/resources/img/person-arms-up.svg" alt="Logo" width="30" height="24" class="d-inline-block align-text-top">
                Training
            </a>

            <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
                <li><a href="${pageContext.request.contextPath}/" class="nav-link px-2 text-secondary">Home</a></li>
                <li><a href="#" class="nav-link px-2 text-white">Reservation</a></li>
                <li><a href="${pageContext.request.contextPath}/board/list" class="nav-link px-2 text-white">Board</a></li>
                <li><a href="#" class="nav-link px-2 text-white">Q&A</a></li>
            </ul>

            <div class="d-grid gap-2 d-md-flex justify-content-md-end" >
<%--                <span>${sessionScope.} </span>--%>
                <a href="${pageContext.request.contextPath}/login/login"><button type="button" class="btn btn-outline-light me-2">Login</button></a>
                <a href="${pageContext.request.contextPath}/register/add"><button type="button" class="btn btn-warning">Sign-up</button></a>
            </div>
        </div>
    </div>
</header>
<%--<c:choose>--%>
<%--    <c:when test="${ !(empty sessionScope.userId) && sessionScope.userId ne 'admin'}">--%>
<%--        <!-- sessionScope 아이디가 userId에 admin이 아닐 경우 환영글 / 로그아웃 -->--%>
<%--        <a href="${pageContext.request.contextPath }/mypage">마이페이지</a>--%>
<%--        <a href="${pageContext.request.contextPath }/member/logout">로그아웃</a>--%>
<%--    </c:when>--%>
<%--    <c:when test="${ !(empty sessionScope.userId) && sessionScope.userId eq 'admin'}">--%>
<%--        <!-- sessionScope 아이디가 admin일 경우 관리자페이지 -->--%>
<%--        <a href="${pageContext.request.contextPath }/adminpage">관리자페이지</a>--%>
<%--        <a href="${pageContext.request.contextPath }/member/logout">로그아웃</a>--%>
<%--    </c:when>--%>
<%--    <c:otherwise>--%>
<%--        <!-- sessionScope 아이디가 비어있는 경우 로그인 / 회원가입 -->--%>
<%--        <a href="${pageContext.request.contextPath }/member/login">로그인</a>--%>
<%--        <a href="${pageContext.request.contextPath }/member/join">회원가입</a>--%>
<%--    </c:otherwise>--%>
<%--</c:choose>--%>