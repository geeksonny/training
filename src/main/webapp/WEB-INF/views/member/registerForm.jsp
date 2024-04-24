<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<html>
<head>
    <!-- 부트스트랩 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>
    <title>Training</title>
    <style>
        header {
            margin-bottom: 11rem;
        }
    </style>
    <!-- 아이디 중복검사 -->
    <script type="text/javascript">
        var checkIdResult = false;			// 아이디 중복확인 여부
        var checkPassResult = false;		// 패스워드 검사
        var checkRetypePassResult = false;	// 패스워드 확인 결과
        var checkNameResult = false;        // 이름 정규식 여부
        var checkEmailResult = false;       // Email 중복확인 여부

        function checkPass(pwd){
            // 패스워드 검사를 위한 정규표현식 패턴 작성 및 검사 결과에 따른 변수값 변경
            var spanElem = document.getElementById("checkPassResult");

            // 정규표현식 패턴 정의
            var lengthRegex = /^[A-Za-z0-9!@#$%]{8,16}$/; // 길이 및 사용 가능 문자 규칙
            var engLowerRegex = /[a-z]/;	// 소문자
            var numRegex = /[0-9]/;		// 숫자 규칙
            var specRegex = /[!@#$%]/;	// 특수문자 규칙

            var count = 0;	// 각 규칙별 검사 결과를 카운팅 할 변수

            if(lengthRegex.exec(pwd)){	// 패스워드 길이 및 사용 가능 문자 규칙 통과 시
                $('#pwd').removeClass("is-invalid");
                $('#pwd').addClass("is-valid");

                // 각 규칙별 검사 후 해당 항목이 포함되어 있을 경우 카운트 증가
                if(engLowerRegex.exec(pwd)) count++;
                if(numRegex.exec(pwd)) count++;
                if(specRegex.exec(pwd)) count++;

                switch(count){
                    case 3: // 특수문자, 대문자, 소문자, 숫자 중 3개를 만족
                        $('#pwd').removeClass("is-invalid");
                        $('#pwd').addClass("is-valid");
                        spanElem.innerHTML = '';
                        checkPassResult = true;
                        break;
                    case 2: // 특수문자, 대문자, 소문자, 숫자 중 2개를 만족
                        $('#pwd').removeClass("is-valid");
                        $('#pwd').addClass("is-invalid");
                        spanElem.innerHTML = '';
                        checkPassResult = true;
                        break;
                    default:
                        $('#pwd').removeClass("is-valid");
                        $('#pwd').addClass("is-invalid");
                        spanElem.innerHTML = '영문자, 숫자, 특수문자 중 2가지 이상 조합 필수!';
                        spanElem.style.color = "#dc3545";
                        checkPassResult = false;
                }
            } else {
                $('#pwd').removeClass("is-valid");
                $('#pwd').addClass("is-invalid");
                spanElem.innerHTML = '영문자, 숫자, 특수문자 조합 8 ~ 16자리 필수!';
                spanElem.style.color = "#dc3545";
                checkPassResult = false;
            }

        }

        function checkRetypePass(pwd2){
            var pass = document.userForm.pwd.value;
            var spanElem = document.getElementById("checkRetypePassResult");
            if(pass == pwd2){	// 패스워드 일치
                checkRetypePassResult = true;
                $('#pwd2').removeClass("is-invalid");
                $('#pwd2').addClass("is-valid");
            } else {	// 패스워드 불일치
                checkRetypePassResult = false;
                $('#pwd2').removeClass("is-valid");
                $('#pwd2').addClass("is-invalid");
            }

        }

        function checkName(name) {
            var spanElem = document.getElementById("checkNameResult");

            var lengthRegex = /^[가-힣]{2,5}$/;

            if(lengthRegex.exec(name)){
                $('#name').removeClass("is-invalid");
                $('#name').addClass("is-valid");
                checkNameResult = true;
            } else {
                $('#name').removeClass("is-valid");
                $('#name').addClass("is-invalid");
                checkNameResult = false;
            }

        }

        function checkSubmit(){
            if (document.userForm.id.value == "") {
                alert("아이디를 입력해 주세요!");
                document.userForm.id.focus();
                return checkIdResult = false;
            } else if(document.userForm.email.value==""){
                alert("Email을 입력해 주세요!");
                document.userForm.email.focus();
                return false;
            } else if(!checkPassResult){
                alert("올바른 패스워드 입력 필수!");
                document.userForm.pwd.focus();
                return false;
            } else if(!checkRetypePassResult){
                alert("패스워드 확인 필수!");
                document.userForm.pwd2.focus();
                return false;
            } else if (!checkNameResult) {
                alert("이름 입력 필수!");
                document.userForm.name.focus();
                return false;
            } else if(!checkIdResult){
                document.userForm.id.focus();
                return false;
            } else if(!checkEmailResult){
                document.userForm.email.focus();
                return false;
            } else{
                var name = document.userForm.name.value;
                alert("환영합니다. " + name +"님!");
                return true;
            }

        }

        // 아이디 중복 체크
        function idCheck(){
            var id = $('#id').val();
            var spanElem = document.getElementById("checkIdResult");
            $.ajax({
                url:'${pageContext.request.contextPath }/member/idDupCheck',
                data:{'id': id},
                type: 'POST',
                success:function(rdata){
                    if(rdata=='iddup'){	// 아이디가 중복이거나 글자 수 넘억
                        $('#id').addClass("is-invalid");
                        $('#id').removeClass("is-valid");
                        spanElem.innerHTML = '중복된 ID입니다.';
                        spanElem.style.color = "#dc3545";
                        checkIdResult = false;
                    }else{
                        $('#id').addClass("is-valid");
                        $('#id').removeClass("is-invalid");
                        spanElem.innerHTML = '';
                        checkIdResult = true;
                    }
                }
            });

        };

        // 이메일 중복 체크
        function emailCheck(){
            var spanElem = document.getElementById("checkEmailResult");
            var email = $('#email').val();
            $.ajax({
                url:'${pageContext.request.contextPath }/member/mailDupCheck',
                data:{'email': email},
                type: 'POST',
                success:function(rdata){
                    if(rdata=='emaildup'){
                        $('#email').addClass("is-invalid");
                        $('#email').removeClass("is-valid");
                        spanElem.innerHTML = '종복된 Email입니다.';
                        spanElem.style.color = "#dc3545";
                        checkEmailResult = false;
                    }else{
                        $('#email').addClass("is-valid");
                        $('#email').removeClass("is-invalid");
                        spanElem.innerHTML = '';
                        checkEmailResult = true;
                    }
                }
            });

        };


    </script>
</head>
<body class="bg-light">
<!-- 헤더 -->
<jsp:include page="../inc/header.jsp"/>

<!--  내용 -->
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-sm-8">
            <h2 class="fw-bold pb-3 text-center">회원가입</h2>  <!--style="padding-top: 11rem" -->
            <!-- 일반 회원 가입 -->
            <form class="form-signin" action="${pageContext.request.contextPath }/register/add" name="userForm" method="post" onsubmit="return checkSubmit()">
                <div class="bd-example">
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" name="id" id="id" placeholder="ID" onkeyup="idCheck(this.value)">
                        <span class="mt-1" id="checkIdResult"><!-- ID 중복 결과 여부 표시  --></span>
                        <label for="id">ID</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" name="name" id="name" placeholder="홍길동" onkeyup="checkName(this.value)">
                        <span class="mt-1" id="checkNameResult"><!-- 이름 형식 일치 여부 표시  --></span>
                        <label for="name">이름</label>
                    </div>

                    <div class="form-floating mb-3">
                        <input type="email" class="form-control" name="email" id="email" placeholder="name@example.com" onkeyup="emailCheck(this.value)">
                        <span class="mt-1" id="checkEmailResult"><!-- PWD 중복 결과 여부 표시  --></span>
                        <label for="email">이메일 주소</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="password" class="form-control" name="pwd" id="pwd" placeholder="Password" onkeyup="checkPass(this.value)">
                        <span id="checkPassResult"><!-- 패스워드 규칙 판별 결과 표시  --></span>
                        <label for="pwd">비밀번호</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="password" class="form-control" name="pwd2" id="pwd2" placeholder="Password" onkeyup="checkRetypePass(this.value)">
                        <span id="checkRetypePassResult"><!-- 패스워드 일치 여부 표시  --></span>
                        <label for="pwd2">비밀번호 확인</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="date" class="form-control" name="birth" id="birth" placeholder="Birth">
                        <label for="birth">생년월일</label>
                    </div>
                </div>
                <div class="mb-3 text-center">
                    <input class="form-check-input " type="checkbox" value="" id="invalidCheck3" required>
                    <label class="form-check-label" for="invalidCheck3">
                        개인정보 수집에 동의합니다.
                    </label>
                </div>
                <div class="mb-3">
                    <button class="site-btn w-100 btn-lg" type="submit">회원가입</button>
                </div>
            </form>
        </div>
    </div>
</div>



</body>
</html>
