<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/login.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기</title>
    <script type="text/javascript">
        // 비밀번호 찾기 및 재설정
        $(document).ready(function(){
            $('#btn').click(function(){
                // 입력 필드에서 ID와 이메일 가져오기
                var id = $('#id').val();
                var email = $('#email').val();
                // ID나 이메일이 비어 있는지 확인
                if (id === "" || email === "") {
                    $('#msg').html('ID와 이메일을 모두 입력하세요.');
                    return; // ID나 이메일이 비어 있으면 함수 종료
                }

                // 비밀번호 찾기 AJAX 요청
                $.ajax({
                    url: '${pageContext.request.contextPath}/login/pwdSearchPro',
                    type: 'POST',
                    data: {'id': id, 'email': email},
                    success: function(rdata) {
                        if (rdata === "no") { // 아이디 없음
                            $('#msg').html('일치하는 계정이 없습니다.');
                        } else { // 아이디 있음
                            // 모달 폼에 값 채워넣기
                            $('#currentPwd').val(rdata); // 현재 비밀번호 설정
                            $('#userId').val(id); // ID 설정
                            $('#userEmail').val(email); // 이메일 설정
                            // 모달 열기
                            $('#resetPwdModal').modal('show');
                        }
                    },
                    error: function() {
                        $('#msg').html('비밀번호 찾기 중 오류가 발생했습니다.');
                    }
                });

                // 모달창 닫힐때 처리
                $('#resetPwdModal').on('hidden.bs.modal', function () {
                    // 새 비밀번호 입력 필드 초기화
                    $('#newPwd, #confirmPassword').val('');
                    // 비밀번호 일치 메시지 제거
                    $('#resetPwdMsg').html('');
                });

                $('#newPwd, #confirmPassword').keyup(function() {
                    var newPwd = $('#newPwd').val();
                    var confirmPassword = $('#confirmPassword').val();
                    if (newPwd == "" && confirmPassword == "") {
                        $('#resetPwdMsg').html('새 비밀번호를 입력하세요.');
                        return; // 새 비밀번호가 공백으로 넘어가면 함수 종료
                    }
                    if (newPwd == confirmPassword) {
                        // 비밀번호가 일치할 때, 초록색으로 메시지 표시
                        $('#resetPwdMsg').html('<div class="alert alert-success" role="alert">비밀번호가 일치합니다.</div>');
                    } else {
                        // 비밀번호가 일치하지 않을 때, 메시지 제거
                        $('#resetPwdMsg').html('<div class="alert alert-danger" role="alert">비밀번호가 일치하지 않습니다.</div>');
                    }
                });

            // 비밀번호 재설정 처리
            $('#resetPwdBtn').click(function(){
                var newPwd = $('#newPwd').val();
                var confirmPassword = $('#confirmPassword').val();

                // 새 비밀번호 공백 리턴
                if (newPwd == "" || confirmPassword == "") {
                    $('#resetPwdMsg').html('<div class="alert alert-danger" role="alert">새 비밀번호를 입력하세요.</div>');
                    return; // 새 비밀번호가 공백으로 넘어가면 함수 종료
                }

                $.ajax({
                    url: '${pageContext.request.contextPath}/login/pwdModifyPro',
                    type: 'POST',
                    data: {'id' : id, 'email' : email, 'pwd' : newPwd},
                    success: function(response){
                        $('#resetPwdMsg').html(response);
                        // 선택적으로, 비밀번호 재설정 후 모달을 닫을 수 있습니다.
                        $('#resetPwdModal').modal('hide');
                        window.location.href = '${pageContext.request.contextPath}/login/login';
                    }, error : function () {
                        $('#newPwd, #confirmPassword').val('');
                        $('#resetPwdMsg').html('<div class="alert alert-danger" role="alert">새 비밀번호를 입력하세요.</div>');
                    }
                });
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

        <div class="col-lg-6 col-md-6 d-flex justify-content-center align-items-center">
            <div class="contact__text text-center">
                <div class="section-title">
                    <h2>비밀번호 재설정</h2>
                    <h5>회원가입 시 기입했던 ID과 이메일을 적어주세요!</h5>
                </div>
                <hr>
                <ul>
                    <li>
                        <div class="row">
                            <div class="col-lg-6 col-md-6">
                                <button type="button" class="site-btn btn-lg w-100" onclick="location.href='${pageContext.request.contextPath}/login/login'">로그인 페이지로</button>
                            </div>
                            <div class="col-lg-6 col-md-6">
                                <button type="button" class="site-btn btn-lg w-100" onclick="location.href='${pageContext.request.contextPath}/login/idSearch'">ID 찾기</button>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
        </div>

        <div class="col-lg-4 col-md-4 pl-lg-3">
            <div class="container" id="loginForm">
                <form id="frm"  method="post" >
                    <h4>ID와 이메일을 입력해주세요</h4>
                    <input type="text"  placeholder="ID" class="in-1" name="id" id="id">
                    <input type="text" placeholder="Email" class="in-2" name="email" id="email">
                    <div id="msg">
                        <i class="fa fa-exclamation-circle"></i>
                    </div>
                    <input type="button" id="btn" value="비밀번호 찾기"><br>
                </form>
                <div style="margin-top: 20px">
                    <a href="<c:url value='/register/add'/>" >회원 가입</a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- HTML 코드에 다음 모달 섹션을 추가합니다 -->
<div class="modal fade" id="resetPwdModal" tabindex="-1" aria-labelledby="resetPwdModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="resetPwdModalLabel">비밀번호 재설정</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="resetPwdForm">
                <div class="modal-body">
                    <!-- 비밀번호 재설정 폼 -->
                    <div class="mb-3">
                        <label for="currentPwd" class="form-label">현재 비밀번호</label>
                        <input type="password" class="form-control" id="currentPwd" name="currentPwd" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="newPwd" class="form-label">새 비밀번호</label>
                        <input type="password" class="form-control" id="newPwd" name="newPwd" required>
                    </div>
                    <div class="mb-3">
                        <label for="confirmPassword" class="form-label">새 비밀번호 확인</label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                    </div>
                    <!-- 필요한 경우 추가 필드를 입력합니다 -->
                    <input type="hidden" id="userId" name="userId">
                    <input type="hidden" id="userEmail" name="userEmail">
                    <div id="resetPwdMsg"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="button" class="btn btn-primary" id="resetPwdBtn">비밀번호 재설정</button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>