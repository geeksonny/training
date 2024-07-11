<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="loginId" value="${sessionScope.id==null ? '' : pageContext.request.session.getAttribute('id')}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'Logout'}"/>
<head>
    <title>Training Jone</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <meta charset="utf-8">
    <link rel="stylesheet" href="<c:url value='/resources/css/header.css'/>">
</head>

<header class="p-3 text-bg-dark">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <img src="${pageContext.request.contextPath}/resources/img/person-arms-up.svg" alt="Logo" width="30" height="24" class="d-inline-block align-text-top">
                Training
            </a>

            <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
                <li><a href="<c:url value='/'/>" class="nav-link px-2 text-secondary">Home</a></li>
                <li><a href="<c:url value='/reserve/list'/>" class="nav-link px-2 text-secondary">Reservation</a></li>
                <li><a href="<c:url value='/board/list'/>" class="nav-link px-2 text-white">Board</a></li>
                <li><a href="#" class="nav-link px-2 text-white">Q&A</a></li>
            </ul>

            <div class="d-grid gap-2 d-md-flex justify-content-md-end" >
                <div class="loginIdCheck" style="font-weight: bold; font-size: 18px; padding-right: 10px; padding-top: 5px;">
                   <c:choose>
                       <c:when test="${sessionScope.id eq 'admin'}">
                           <a href="<c:url value='/mypage/admin'/>">${loginId}</a>
                       </c:when>
                       <c:otherwise>
                           <a href="<c:url value='/mypage/'/>">${loginId}</a>
                       </c:otherwise>
                   </c:choose>
                </div>
                <a href="<c:url value='${loginOutLink}'/>"><button type="button" class="btn btn-outline-light me-2">${loginOut}</button></a>
                <a href="<c:url value='/register/add'/>"><button type="button" class="btn btn-warning">Sign-up</button></a>
            </div>
        </div>
    </div>
</header>



