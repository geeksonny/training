<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/resources/css/board.css'/>">
    <script>
        let msg = "${msg}";
        if(msg=="Delete Error")    alert("삭제에 실패했습니다. 먼저 로그인 해주세요.");

        $(document).ready(function () {
            // 게시판 작성
            let writer = $("#writer").val();
            let id = '<%=(String)session.getAttribute("id")%>';
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

            loadComments();

            // 게시판 파일이름 분리
            let copyContentToTextarea = function() {
                $('#hiddenContent').val($('#content').html());
                let imgTag = $(content).find('img');
                let imgSrc = imgTag.attr('src');
                let imgFileName = imgSrc ? imgSrc.substring(imgSrc.lastIndexOf('/') + 1) : '';
                let textContent = $('#content').clone().children().remove().end().text().trim();

                $('#hiddenContent').val(textContent);
                $('#bfile').val(imgFileName);
            }

            // 게시판 작성
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

            // 목록 버튼
            $("#listBtn").on("click", function () {
                location.href = "<c:url value='/board/list?page=${page}&pageSize=${pageSize}'/>";
            });
            // 게시판 수정
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
            // 게시판 삭제
            $("#delBtn").on("click", function () {
                if(!confirm("정말로 삭제하시겠습니까?")) return;
                let form = $("#form");
                form.attr("action", "<c:url value='/board/delete'/>");
                form.attr("method", "post");
                form.submit();
            });


            // 댓글 작성
            $("#replyBtn").click(function(){
                let comment = $("textarea[name=comment]").val();
                let bno = $("#bno").val();
                if(comment.trim()==''){
                    alert("댓글을 입력해주세요.");
                    $("textarea[name=comment]").focus();
                    return;
                }

                $.ajax({
                    type:'POST',
                    url: '${pageContext.request.contextPath }/comments?bno='+bno,
                    headers : { "content-type": "application/json"},
                    data : JSON.stringify({bno: bno, comment: comment}),
                    success : function(result){
                        alert("댓글을 등록했습니다.")
                        $("textarea[name=comment]").val('');
                        loadComments();
                    },
                    error   : function(){ alert("댓글 등록에 실패했습니다.") }
                });
            });

            // 댓글 삭제
            $("#commentList").on("click", ".delete-btn", function() {
                let commentItem = $(this).closest("li");
                let cno = commentItem.attr("data-cno");
                let bno = commentItem.attr("data-bno");

                if (confirm("정말로 삭제하시겠습니까?")) {
                    $.ajax({
                        type: 'DELETE',
                        url: '${pageContext.request.contextPath}/comments/' + cno + '?bno=' + bno,
                        success: function(result) {
                            if (result === "DEL_OK") {
                                commentItem.remove();
                                alert("댓글이 삭제되었습니다.");
                                loadComments();
                            } else {
                                alert("댓글 삭제에 실패했습니다.");
                            }
                        },
                        error: function() {
                            alert("댓글 삭제 중 오류가 발생했습니다.");
                        }
                    });
                }
            });

            // 댓글 답글, 수정 모달
            let editModal = $("#editModal");
            let replyModal = $("#replyModal");
            let span = $(".close");

            span.click(function() {
                editModal.hide();
                replyModal.hide();
                $("#editCommentText").val("");
                $("#replyCommentText").val("")
            });

            $(window).click(function(event) {
                if ($(event.target).is(editModal)) {
                    editModal.hide();
                    $("#editCommentText").val("");
                }
                if ($(event.target).is(replyModal)) {
                    replyModal.hide();
                    $("#replyCommentText").val("");
                }
            });

            // 댓글 수정 구현
            $("#saveEditBtn").click(function() {
                let cno = editModal.data("cno");
                let comment = $("#editCommentText").val();
                let bno = $("#bno").val();
                if(comment.trim()==''){
                    alert("댓글을 입력해주세요.");
                    comment.focus();
                    return;
                }
                $.ajax({
                    type: 'PATCH',
                    url: '${pageContext.request.contextPath}/comments/' + cno,
                    headers: { "content-type": "application/json" },
                    data: JSON.stringify({ bno: bno, comment: comment }),
                    success: function(response) {
                        if(response === "MOD_OK") {
                            alert("댓글이 수정되었습니다.");
                            loadComments();
                            editModal.hide();
                            $("#editCommentText").val("");
                        } else {
                            alert("댓글 수정에 실패했습니다.");
                        }
                    },
                    error: function() {
                        alert("댓글 수정에 실패했습니다.");
                    }
                });
            });

            // 답글쓰기 구현
            $("#saveReplyBtn").click(function() {
                let pcno = replyModal.data("pcno");
                let comment = $("#replyCommentText").val();
                let bno = $("#bno").val();

                if(comment.trim()==''){
                    alert("댓글을 입력해주세요.");
                    comment.focus();
                    return;
                }

                $.ajax({
                    type: 'POST',
                    url: '${pageContext.request.contextPath }/comments?bno='+bno,
                    headers: { "content-type": "application/json" },
                    data: JSON.stringify({ bno: bno, pcno: pcno, comment: comment }),
                    success: function(response) {
                        if(response === "WRT_OK") {
                            alert("답글이 작성되었습니다.");
                            loadComments();
                            replyModal.hide();
                            $("#replyCommentText").val("");
                        } else {
                            alert("답글 작성에 실패했습니다.");
                        }
                    },
                    error: function() {
                        alert("답글 작성에 실패했습니다.");
                    }
                });
            });

            // 댓글 목록 가져오기
            function loadComments() {
                let bno = $("#bno").val();
                $.ajax({
                    type: 'GET',
                    url: '${pageContext.request.contextPath}/comments?bno=' + bno,
                    success: function (result) {
                        $("#commentList ul").empty();
                        if (result.length > 0) {
                            $("#commentList").show();
                        } else {
                            $("#commentList").hide();
                        }
                        $.each(result, function (index, comment) {
                            let up_date = new Date(comment.up_date).toISOString().replace('T', ' ').substr(0, 19);
                            let replyClass = comment.pcno == comment.cno ? '' : ' reply-item';

                            let commentHtml = '<li class="comment-item' + replyClass + '" data-cno="' + comment.cno + '" data-bno="' + bno + '" data-pcno="' + comment.pcno + '">' +

                                '<div class="comment-header">' +
                                '<span class="commenter">' + comment.commenter + '</span>' +
                                '<span class="up_date">' + up_date + '</span>' +
                                '</div>' +
                                '<div class="comment">' + comment.comment + '</div>' +
                                '<div class="comment-buttons">' +
                                '<button class="comment-btn reply-btn">답글쓰기</button>' +
                                '<button class="comment-btn edit-btn">수정</button>' +
                                '<button class="comment-btn delete-btn">삭제</button>' +
                                '</div></li>';
                            $("#commentList ul").append(commentHtml);
                        });

                        // 답글 쓰기 버튼 클릭 이벤트 등록
                        $(".reply-btn").click(function () {
                            let commentItem = $(this).closest("li");
                            let pcno = commentItem.data("pcno");
                            $("#replyModal").data("pcno", pcno).show();
                        });

                        // 댓글 수정 버튼 클릭 이벤트 등록
                        $(".edit-btn").click(function () {
                            let commentItem = $(this).closest("li");
                            let commentText = commentItem.find(".comment").text();
                            let cno = commentItem.data("cno");

                            $("#editCommentText").val(commentText);
                            $("#editModal").data("cno", cno).show();
                        });
                    },
                    error: function () {
                        alert("댓글을 불러오는 데 실패했습니다.");
                    }
                });
            }



        });
    </script>
    <title>게시판</title>
</head>
<body>
<jsp:include page="inc/header.jsp"/>

<header>
    <h1>게시판</h1>
</header>

<form id="form" action="" method="post" enctype="multipart/form-data">
    <input type="hidden" id="bno" name="bno" value="${boardDto.bno}">
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

<div id="commentList" style="display: none;">
    <ul>
        <li>
            <div class="commenter"></div>
            <div class="comment"></div>
        </li>
    </ul>
</div>
<c:if test="${sessionScope.id != null}">
    <div id="reply-writebox">
        <strong>${sessionScope.id}</strong>
        <div class="textarea-container">
            <textarea name="comment" rows="5" cols="80" placeholder="댓글을 작성해주세요"></textarea>
            <button type="button" id="replyBtn">댓글 등록</button>
        </div>
    </div>
</c:if>

<div id="replyModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>답글 작성</h2>
        <textarea id="replyCommentText" rows="5" cols="80" placeholder="답글을 작성해주세요"></textarea>
        <button id="saveReplyBtn">저장</button>
    </div>
</div>

<div id="editModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>댓글 수정</h2>
        <textarea id="editCommentText" rows="5" cols="80"></textarea>
        <button id="saveEditBtn">저장</button>
    </div>
</div>

<jsp:include page="inc/footer.jsp"/>
</body>
</html>
