<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">
    <script>
        let msg = "${msg}";
        if(msg=="Delete Error")    alert("삭제에 실패했습니다. 먼저 로그인 해주세요.");

        $(document).ready(function () {
            var writer = $("#writer").val();
            var id = '<%=(String)session.getAttribute("id")%>';
            if (writer == id) {
                $('#modBtn, #delBtn').show();
            } else {
                $('#modBtn, #delBtn').hide();
            }

            let formCheck = function() {
                let form = document.getElementById("form");
                if(form.title.value == "") {
                    alert("제목을 입력해 주세요.");
                    form.title.focus();
                    return false;
                }

                if($('#content').text().trim() == "") {
                    alert("내용을 입력해 주세요.");
                    $('#content').focus();
                    return false;
                }
                return true;
            }

            let copyContentToTextarea = function() {
                $('#hiddenContent').val($('#content').html());

                let imgTag = $(content).find('img');
                let imgSrc = imgTag.attr('src');
                let imgFileName = imgSrc ? imgSrc.substring(imgSrc.lastIndexOf('/') + 1) : '';
                let textContent = $('#content').clone().children().remove().end().text().trim();

                $('#hiddenContent').val(textContent);
                $('#bfile').val(imgFileName);
            }

            $("#wrtBtn").on("click", function () {
                let form = $("#form");
                form.attr("action", "<c:url value='/board/write'/>");
                form.attr("method", "post");
                if(!formCheck()) {
                    return false;
                } else {
                    copyContentToTextarea();
                    form.submit();
                }
            });

            $("#listBtn").on("click", function () {
                location.href = "<c:url value='/board/list?page=${page}&pageSize=${pageSize}'/>";
            });

            $("#modBtn").on("click", function () {
                let form = $("#form");
                let isReadonly = $("input[name=title]").attr('readonly');

                // 1. 읽기 상태이면, 수정 상태로 변경
                if(isReadonly == 'readonly') {
                    $("input[name=title]").attr('readonly', false);
                    $("#content").attr('contenteditable', true);
                    $("#modBtn").html("등록");
                    return;
                }

                // 2. 수정 상태이면, 수정된 내용을 서버로 전송
                form.attr("action", "<c:url value='/board/modify'/>");
                form.attr("method", "post");
                if(formCheck()) {
                    copyContentToTextarea();
                    form.submit();
                }
            });

            $("#delBtn").on("click", function () {
                if(!confirm("정말로 삭제하시겠습니까?")) return;
                let form = $("#form");
                form.attr("action", "<c:url value='/board/delete'/>");
                form.attr("method", "post");
                form.submit();
            });

        });
    </script>
    <style>
        body {
            font-family: 'Open Sans', Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #333;
            color: #fff;
            padding: 20px;
            text-align: center;
            margin-bottom: 20px;
        }

        h1 {
            text-align: center;
            margin-top: 30px;
        }

        table {
            border-collapse: collapse;
            width: 50%;
            margin: auto;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        th {
            background-color: #333;
            color: #fff;
            width: 25%;
            text-align: center;
            font-weight: 700;
        }

        td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
            width: 75%;
            font-family: 'Open Sans', Arial, sans-serif;
            font-weight: 400;
        }

        input[type="text"], div[contenteditable] {
            width: calc(100% - 24px);
            padding: 12px;
            margin: 8px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            resize: none;
            font-family: 'Open Sans', Arial, sans-serif;
            font-size: 16px;
        }

        div[contenteditable] {
            height: 600px;
            overflow-y: auto;
        }

        button {
            background-color: #555;
            color: #fff;
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin: 10px;
            transition: background-color 0.3s ease;
            font-family: 'Open Sans', Arial, sans-serif;
            font-size: 16px;
        }

        button:hover {
            background-color: #333;
        }

        footer {
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 10px;
            position: relative;
            bottom: 0;
            width: 100%;
            margin-top: 70px;
        }
    </style>
    <title>게시판</title>
</head>
<body>
<jsp:include page="inc/header.jsp"/>

<header>
    <h1>게시판</h1>
</header>

<form id="form" action="" method="post" enctype="multipart/form-data">
    <input type="hidden" name="bno" value="${boardDto.bno}">
    <input type="hidden" id="writer" name="writer" value="${boardDto.writer}">
    <input type="hidden" name="bfile" id="bfile">
    <table>
        <tr>
            <th style="text-align: center">제목</th>
            <td>
                <input type="text" name="title" value="<c:out value='${boardDto.title}'/>" ${mode == 'new' ? "" : "readonly='readonly'"} placeholder="  제목을 입력해 주세요.">
            </td>
        </tr>
        <tr>
            <th style="text-align: center">내용</th>
            <td>
                <div id="content" contenteditable="${mode == 'new'}">
                    <c:if test="${not empty boardDto.bfile}">
                        <img src="${pageContext.request.contextPath }/resources/upload/${boardDto.bfile}" style="max-width: 100%;"><br>
                    </c:if>
                    ${boardDto.content}
                </div>
                <textarea name="content" id="hiddenContent" style="display: none"></textarea>
            </td>
        </tr>
        <tr>
            <th></th>
            <td>
                <input type="${mode == 'new' ? "file" : "hidden"}" name="file">
            </td>
        </tr>
        <tr>
            <th></th>
            <td style="text-align: right;">
                <c:if test="${mode eq 'new'}">
                    <button type="button" id="wrtBtn">등록</button>
                </c:if>
            </td>
        </tr>
        <tr>
            <th></th>
            <td style="text-align: right;">
                <button type="button" id="listBtn">목록</button>
                <button type="button" id="modBtn">수정</button>
                <button type="button" id="delBtn">삭제</button>
            </td>
        </tr>
    </table>
</form>
<c:if test="${mode ne 'new'}">
    <jsp:include page="comment.jsp"/>
</c:if>
<jsp:include page="inc/footer.jsp"/>
</body>
</html>
