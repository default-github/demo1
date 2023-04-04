<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.example.demo.Book" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.demo.BookDB" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>


<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/main.css">
    <title>海带买书</title>
</head>



<body>
<jsp:include page="header.jsp"/>

<div id="contain">




    <%--    获取商品    --%>
    <%
        List<Book> books = new ArrayList<>(BookDB.getAll());
        request.setAttribute("books",books);
        int count = 0;
    %>

    <%--    显示商品    --%>
    <c:forEach items="${books}" var="book" varStatus="n">
        <div class="shop_items" >
            <div onclick="checkDetail(${book.id})">
                <div class="c1">
                    <img src="${book.imgPath}" alt="图片">
                </div>
                <div class="c2">
                    <h3>${book.name}</h3>
                    <p>出版社：${book.publishers}</p>
                    <p>作者：${book.authors}</p>
                </div>
                <div class="c3">￥${book.price}</div>
            </div>
            <button onclick="addCart(${book.id})" class="c_btn">加入购物车</button>
        </div>
        <%
            count++;
            if (count%3 == 0){
                out.write("<div style='clear: left'></div>");
            }
        %>
    </c:forEach>







</div>

<jsp:include page="footer.jsp"/>

</body>




<script>
    //发送将商品放入购物车的请求
    function addCart(id) {
        const request = new XMLHttpRequest();
        request.open("POST", "HandleServlet?bookId="+id+"&num=1", true);
        request.send();
        alert("已添加到购物车")
    }
    //跳转到详情页
    function checkDetail(id){
        window.location.href = "detail.jsp?id="+id;
    }
</script>
</html>