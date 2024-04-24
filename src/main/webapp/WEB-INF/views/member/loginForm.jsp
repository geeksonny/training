<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page session="false" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/login.css">
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        a:link, a:visited  {
            text-decoration: none;
            color: #766C6C;
        }
    </style>
</head>
<body>
<header class="bg-dark py-5">
    <div class="container px-4 px-lg-5 my-5">
        <div class="text-center text-white">
            <h1 class="display-4 fw-bolder">
                <a href="${pageContext.request.contextPath}/" style="color: black"><img src="${pageContext.request.contextPath}/resources/img/person-arms-up.svg" alt="Logo" width="40" height="80">Hello! Let's Training!!</a>
            </h1>
            <p class="lead fw-normal text-white-50 mb-0">With our comfortable home gym</p>
        </div>
    </div>
</header>

    <div class="login-container">
        <div id="loginForm">
            <form id="frm" action="${pageContext.request.contextPath}/login/login" method="post" onsubmit="return formCheck(this);">
                <h1>Login</h1>
                    <input type="text" value="${cookie.id.value}" placeholder="아이디" class="in-1" name="id">
                    <input type="password" placeholder="비밀번호" class="in-2" name="pwd">
                <div class="checkbox-container">
                    <div id="checkbox-left">
                        <input type="checkbox" name="rememberId" id="rememberId"  ${empty cookie.id.value ? "":"checked"}>
                    </div>
                    <div id="checkbox-right">
                        <label for="rememberId">아이디 기억</label>
                    </div>
                </div>
                <div id="msg">
                        <c:if test="${not empty param.msg}">
                            <i class="fa fa-exclamation-circle"> ${URLDecoder.decode(param.msg, "UTF-8")}</i>
                        </c:if>
                </div>
                    <input type="submit" id="btn" value="로그인" ><br>
            </form>
            <div>
                <a href="<c:url value='/login/idSearch'/>">아이디 찾기</a> /
                <a href="<c:url value='/login/pwdSearch'/>">비밀번호 찾기</a> /
                <a href="<c:url value='/register/add'/>">회원 가입</a>
            </div>
        </div>
    </div>
</body>
<script>
    function formCheck(frm) {
        let msg ='';
        if(frm.id.value.length==0) {
            setMessage('아이디를 입력해주세요.', frm.id);
            return false;
        }
        if(frm.pwd.value.length==0) {
            setMessage('비밀번호를 입력해주세요.', frm.pwd);
            return false;
        }
        return true;
    }
    function setMessage(msg, element){
        document.getElementById("msg").innerHTML = ` ${'${msg}'}`;
        if(element) {
            element.select();
        }
    }
</script>
</html>
