<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
<html>
<head>
    <style>
        table, th, td {
            border: 1px solid black;
        }
    </style>
    <title>Title</title>
</head>
<body>
<jsp:include page="inc/header.jsp"/>
<h2>게시판</h2>

<form id="form" action="${pageContext.request.contextPath}/board/write" method="post">
    <input type="hidden" name="bno" value="${boardDto.bno}">
    <table>
        <tr>
            <th>제목</th>
            <td><input type="text" name="title" value="<c:out value='${boardDto.title}'/>"></td>
        </tr>
        <tr>
            <th>내용</th>
            <td><textarea name="content" rows="20" placeholder="내용을 입력해주세요"><c:out value='${boardDto.content}'/></textarea></td>
        </tr>
    </table>
    <button>등록</button>
</form>
<button id="listBtn">목록</button>
<button id="modBtn">수정</button>
<button id="delBtn">삭제</button>

<jsp:include page="inc/footer.jsp"/>
</body>
<script>
    $(document).ready(function () {
        let formCheck = function() {
            let form = document.getElementById("form");
            if(form.title.value=="") {
                alert("제목을 입력해 주세요.");
                form.title.focus();
                return false;
            }

            if(form.content.value=="") {
                alert("내용을 입력해 주세요.");
                form.content.focus();
                return false;
            }
            return true;
        }

       $("#listBtn").on("click", function () {
           location.href="<c:url value='/board/list'/>"
       });

       $("#modBtn").on("click", function () {
           let form = $("#form");
           form.attr("action", "<c:url value='/board/modify'/>");
           form.attr("method", "post");
           if(formCheck())
               form.submit();
       });

       $("#delBtn").on("click", function () {
           let form = $("#form");
           form.attr("action", "<c:url value='/board/delete'/>");
           form.attr("method", "post");
           if(formCheck())
               form.submit();
       });

    });

</script>
</html>
