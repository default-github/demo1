<%@ page import="com.example.demo.Book" %>
<%@ page import="com.example.demo.BookDB" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <link rel="stylesheet" href="css/detail.css">
    <title>商品详情</title>
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="detail">

<%--  通过传入的ID获取书本信息  --%>
    <%
        int id = Integer.parseInt(request.getParameter("id") == null ? "1" : request.getParameter("id"));
        Book book = BookDB.getBook(id);
        String imgPath = book == null ? "" : book.getImgPath();
        String name = book == null ? "" : book.getName();
        String price = book == null ? "" : book.getPrice() + "";
        String publishers = book == null ? "" : book.getPublishers();
        String author = book == null ? "" : book.getAuthors();
    %>

    <div class="detail_left">
        <img src="<%=imgPath%>" alt="加载失败">
    </div>
    <div class="detail_right">
        <p class="name"><%=name%></p>
        <p class="publishers">出版社：<%=publishers%></p>
        <p class="author">作者：<%=author%></p>
        <p class="comment">评价：114514条</p>
        <p class="price">惊喜价：<%=price%>元</p>
        <div class="count">
            <div class="count_c">
                <div class="count_btn" onclick="minus()">-</div>
                <input id="count_num" type="text" maxlength="2" oninput = "value=value.replace(/[^\d]/g,'')" onblur = "checkNum()" value="1">
                <div class="count_btn" onclick="add()">+</div>
            </div>
            <div class="count_add" onclick="addCart(<%=id%>)">加入购物车</div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>

</body>

<script>
    function add() {
        var input = document.getElementById("count_num");
        if (input.value < 99) {
            input.value = parseInt(input.value) + 1;
        }
    }

    function minus(){
        var input = document.getElementById("count_num");
        if (input.value > 1) {
            input.value = parseInt(input.value) - 1;
        }
    }

    function checkNum(){
        var input = document.getElementById("count_num");
        if (input.value === '' ){
            input.value = 1;
        }
    }

    //发送将商品放入购物车的请求
    function addCart(id) {
        var input = document.getElementById("count_num");
        const request = new XMLHttpRequest();
        request.open("POST", "HandleServlet?bookId="+id+"&num="+input.value, true);
        request.send();
        alert("已添加到购物车")
    }
</script>



</html>
