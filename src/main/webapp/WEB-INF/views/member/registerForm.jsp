<%@ page contentType="text/html;charset=utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>

<html>
<head>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <title>Title</title>
</head>
<body>
<jsp:include page="../inc/header.jsp"/>
<h2>회원가입</h2>
<form action="${pageContext.request.contextPath}/register/add" method="post">
    <label for="">아이디</label>
    <input class="input-field" type="text" name="id" placeholder="8~12자리의 영대소문자와 숫자 조합"><br>
    <label for="">비밀번호</label>
    <input class="input-field" type="text" name="pwd" placeholder="8~12자리의 영대소문자와 숫자 조합"><br>
    <label for="">이름</label>
    <input class="input-field" type="text" name="name" placeholder="홍길동"><br>
    <label for="">이메일</label>
    <input class="input-field" type="text" name="email" placeholder="example@fastcampus.co.kr"><br>
    <label for="">생일</label>
    <input class="input-field" type="text" name="birth" placeholder="2020/12/31"><br>
    <button>회원 가입</button>
</form>
<jsp:include page="../inc/footer.jsp"/>
</body>
</html>
