<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/login.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ID 찾기</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script type="text/javascript">

        // 아이디 찾기
        $(document).ready(function(){
            $('#btn').click(function(){
                $.ajax({
                    url:'${pageContext.request.contextPath }/login/idSearchPro',
                    type:'POST',
                    data:{'name':$('#name').val(),'email':$('#email').val()},
                    success:function(rdata){
                        var result="";
                        if(rdata=="no"){	// 아이디 없음
                            result="아이디가 없습니다";
                            $('#msg').css('color', 'red');
                        }else{				// 아이디 있음
                            result="찾으시는 아이디는 "+ rdata +" 입니다";
                            $('#msg').css('color', 'green');
                        }
                        $('#msg').html(result);
                    }
                });
            });
        });

    </script>
    <style>
        a:link, a:visited  {
            text-decoration: none;
            color: #766C6C;
        }
        .site-btn {
            background-color: #007bff;
            border: none;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .site-btn:hover {
            background-color: #0056b3;
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

<div class="container" style="margin-top: 200px">
    <div class="row">
        <!-- 왼쪽 영역 -->
        <div class="col-lg-6 col-md-6 d-flex justify-content-center align-items-center">
            <div class="contact__text text-center">
                <div class="section-title">
                    <h2>ID 찾기</h2>
                    <h5>회원가입 시 기입했던 이름과 이메일을 적어주세요!</h5>
                </div>
                <hr>
                <ul>
                    <li>
                        <div class="row">
                            <div class="col-lg-6 col-md-6">
                                <button type="button" class="site-btn btn-lg w-100" onclick="location.href='${pageContext.request.contextPath}/login/login'">로그인 페이지로</button>
                            </div>
                            <div class="col-lg-6 col-md-6">
                                <button type="button" class="site-btn btn-lg w-100" onclick="location.href='${pageContext.request.contextPath}/login/pwdSearch'">비밀번호 찾기</button>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
        <!-- 오른쪽 영역 -->
        <div class="col-lg-4 col-md-4 pl-lg-3">
            <div class="container" id="loginForm">
                    <form id="frm" method="post" > <%-- onsubmit="return formCheck(this);" --%>
                    <h4>이름과 이메일을 입력하세요</h4>
                    <input type="text" placeholder="이름" class="in-1" name="name" id="name">
                    <input type="text" placeholder="Email" class="in-2" name="email" id="email">
                    <div id="msg">
                        <i class="fa fa-exclamation-circle"></i>
                    </div>
                    <input type="button" id="btn" value="아이디 찾기" ><br>
                </form>
                <div style="margin-top: 20px">
                    <a href="<c:url value='/register/add'/>" >회원 가입</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>