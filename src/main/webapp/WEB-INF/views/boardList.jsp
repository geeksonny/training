<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: "Noto Sans KR", sans-serif;
        }

        a {
            text-decoration: none;
            color: black;
        }
        .board-heading{
            margin-top: 80px;
            margin-left: 230px;
            /*margin-bottom: 35px;*/
        }
        button,
        input {
            border: none;
            outline: none;
        }

        .board-container {
            position: relative;
            width: 80%;
            margin: 0 auto;
        }

        .search-form {
            display: flex;
            align-items: center;
            display: flex;
            justify-content: center;
            margin-top: 30px;
            margin-bottom: 20px;
        }

        .search-option,
        .search-input,
        .search-button {
            height: 37px;
            border-radius: 5px;
        }

        .search-option {
            width: 120px;
            margin-right: 10px;
        }

        .search-input {
            width: 300px;
            padding: 5px 10px;
            font-size: 15px;
        }

        .search-button {
            background-color: rgb(22, 22, 22);
            color: #fff;
            padding: 0 20px;
            font-size: 15px;
            cursor: pointer;
        }

        .search-button:hover {
            background-color: rgb(42, 42, 42);
        }

        table {
            border-collapse: collapse;
            width: 100%;
        }

        th,
        td {
            text-align: center !important;
            padding: 15px 10px;
        }

        th {
            background-color: #f8f9fa;
            border-bottom: 2px solid rgb(39, 39, 39);
        }

        tr:nth-child(even) {
            background-color: #f0f0f0;
        }

        .paging-container {
            margin-top: 30px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .btn-write {
            background-color: rgb(236, 236, 236);
            border: none;
            color: black;
            padding: 6px 12px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
        }

        table {
            border-collapse: collapse;
            width: 80%;
            margin: 0 auto;
        }

        .page {
            color: black;
            padding: 6px 12px;
            margin: 0 5px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .page:hover,
        .paging-active {
            background-color: rgb(216, 216, 216);
        }

        .fixed-footer {
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            background-color: #f8f9fa;
            box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.1);
        }
    </style>
    <title>Title</title>
</head>
<body>
<jsp:include page="inc/header.jsp"/>
<div class="container">
    <div class="board-heading">
        <h2>게시판</h2>
    </div>
    <div class="board-container">
        <table>
            <tr>
                <th><a href="${pageContext.request.contextPath}/board/board"><input type="button" class="btn-write" value="글쓰기"></a></th>
            </tr>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>글쓴이</th>
                <th>작성일</th>
                <th>조회수</th>
            </tr>
            <c:forEach var="boardDto" items="${list}">
                <tr>
                    <td>${boardDto.bno}</td>
                    <td><a href="<c:url value="/board/read${ph.sc.queryString}&bno=${boardDto.bno}"/>"><c:out value='${boardDto.title}'/></a></td>
                    <td>${boardDto.writer}</td>
                    <c:choose>
                        <c:when test="${boardDto.reg_date.time >= startOfToday}">
                            <td><fmt:formatDate value="${boardDto.reg_date}" pattern="HH:mm" type="time"/></td>
                        </c:when>
                        <c:otherwise>
                            <td><fmt:formatDate value="${boardDto.reg_date}" pattern="yyyy-MM-dd" type="date"/></td>
                        </c:otherwise>
                    </c:choose>
                    <td>${boardDto.view_cnt}</td>
                </tr>
            </c:forEach>
        </table>
        <br>
        <div class="search-form text-center">
            <form action="<c:url value="/board/list"/>" method="get">
                <select name="option" class="search-option">
                    <option value="A" ${ph.sc.option=='A' || ph.sc.option=='' ? "selected" : ""}>제목+내용</option>
                    <option value="T" ${ph.sc.option=='T' ? "selected" : ""}>제목만</option>
                    <option value="W" ${ph.sc.option=='W' ? "selected" : ""}>작성자</option>
                </select>

                <input type="text" name="keyword"  class="search-input" value="${ph.sc.keyword}" placeholder="검색어를 입력해주세요">
                <input type="submit" class="search-button" value="검색">
            </form>
            <br>
        </div>
        <div class="paging-container text-center">
            <div class="paging">
                <c:if test="${ph.totalCnt==null || ph.totalCnt==0}">
                    <div> 게시물이 없습니다. </div>
                </c:if>
                <c:if test="${ph.totalCnt!=null && ph.totalCnt!=0}">
                    <c:if test="${ph.showPrev}">
                        <a class="page" href="<c:url value="/board/list${ph.sc.getQueryString(ph.beginPage-1)}"/>">&lt;</a>
                    </c:if>
                    <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
                        <a class="page ${i==ph.sc.page? "paging-active" : ""}" href="<c:url value="/board/list${ph.sc.getQueryString(i)}"/>">${i}</a>
                    </c:forEach>
                    <c:if test="${ph.showNext}">
                        <a class="page" href="<c:url value="/board/list${ph.sc.getQueryString(ph.endPage+1)}"/>">&gt;</a>
                    </c:if>
                </c:if>
            </div>
        </div>
    </div>
</div>

<!-- Fixed footer -->
<footer class="fixed-footer">
    <jsp:include page="inc/footer.jsp"/>
</footer>
<!-- Fixed footer end -->
</body>
</html>