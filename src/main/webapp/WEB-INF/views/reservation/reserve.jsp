<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.2.1.js"></script>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" >
    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
    <script>
        let msg = "${msg}";
        if(msg=="RESERVE_ERR")  alert("예약에 실패했습니다. 다른 시간에 예약해 주세요.");
        if(msg=="ALREADY_RESERVED")  alert("선택하신 시간엔 예약이 있습니다. 다른 시간에 예약해 주세요.");
        if(msg=="OTHER_RESERVATION")  alert("선택하신 시간엔 다른 기구에 예약이 있습니다. 다른 시간에 예약해 주세요.");

        $(document).ready(function () {
            let form = $("#frm");
            // 시작 시간 선택 필드 설정
            $('#start_time').timepicker({
                timeFormat: 'HH:mm',
                interval: 10,
                minTime: '10',
                maxTime: '22:00',
                defaultTime: '09:00',
                startTime: '09:00',
                dynamic: false,
                dropdown: true,
                scrollbar: true
            });

            // 종료 시간 선택 필드 설정
            $('#end_time').timepicker({
                timeFormat: 'HH:mm',
                interval: 10,
                minTime: '10',
                maxTime: '23:00',
                defaultTime: '09:00',
                startTime: '09:00',
                dynamic: false,
                dropdown: true,
                scrollbar: true
            });

            $('#reserveBtn').click(function () {
                var start_time = $('#start_time').val();
                var end_time = $('#end_time').val();
                if (start_time && end_time) {
                    var today = new Date();
                    var todayFormatted = today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);

                    $('#start_time').val(todayFormatted + ' ' + start_time);
                    $('#end_time').val(todayFormatted + ' ' + end_time);

                    if (isBeforeToday(start_time, end_time)) {
                        alert('종료 시간은 시작 시간보다 이후여야 합니다.');
                        return; // 종료 시간이 시작 시간보다 이전이면 예약을 진행하지 않음
                    }
                    form.submit();
                } else {
                    alert('시작 시간과 종료 시간을 모두 입력하세요.');
                    return;
                }
            });

            function isBeforeToday(start_time, end_time) {
                var today = new Date();
                var startDateTime = new Date(today.toDateString() + ' ' + start_time);
                var endDateTime = new Date(today.toDateString() + ' ' + end_time);
                return startDateTime >= endDateTime;
            }
        });
    </script>

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

        .card-heading a:hover {
            background-color: #f8f9fa;
        }

        .main-content {
            margin-left: 250px; /* Adjust based on sidebar width */
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
<!-- Main content -->
<div class="main-content py-5">
    <section>
        <div class="container px-4 px-lg-5">
            <div class="row mb-4">
                <div class="col-md-4">
                    <img src="${pageContext.request.contextPath}/resources/img/equip/${equipmentDto.eMainimg}" alt="기구 사진" class="img-fluid">
                </div>
                <div class="col-md-8">
                    <h2><c:out value="${equipmentDto.eName}" /></h2>
                    <form id="frm" action="${pageContext.request.contextPath}/reserve/reserve" method="post">
                        <input type="hidden" name="page" value="${page}">
                        <input type="hidden" name="pageSize" value="${pageSize}">
                        <input type="hidden" name="eno" value="${equipmentDto.eno}">
                        <input type="hidden" name="type" value="${equipmentDto.eName}">
                        <input type="hidden" name="reserve_state" value="0">
                        <div class="form-group">
                            <label for="start_time">시작 시간:</label>
                            <input type="text" id="start_time" name="start_time" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="end_time">종료 시간:</label>
                            <input type="text" id="end_time" name="end_time" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <button type="button" class="btn btn-primary" id="reserveBtn">예약하기</button>
                            <a href="<c:url value="/reserve/list?page=${page}&pageSize=${pageSize}" />" class="btn btn-secondary">목록으로 돌아가기</a>
                        </div>
                    </form>
                </div>
            </div>

            <!-- 기구 설명 -->
            <div class="row">
                <div class="col">
                    <h3>기구 설명</h3>
                    <p>${equipmentDto.eSubimg}</p>
                </div>
            </div>
        </div>
    </section>
</div>
<!-- Main content end -->

<!-- Fixed footer -->
<footer class="fixed-footer">
    <jsp:include page="../inc/footer.jsp"/>
</footer>
<!-- Fixed footer end -->


</body>
</html>
