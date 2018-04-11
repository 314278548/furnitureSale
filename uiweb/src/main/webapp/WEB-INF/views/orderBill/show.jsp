<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="club.ming19.furnitureSales.util.UserContext" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>订单详情-MingMini家具销售</title>
    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="shortcut icon"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/plugin/bootstrap/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugin/layer/layer.js"></script>
</head>

<style>

    a {
        color: #0f0f0f;
        text-decoration-line: none;
    }

    a:hover {
        color: red;
        text-decoration-line: none;
    }
</style>

<script>

    function logout() {
        $.ajax({
            type: 'get',
            dataType: 'json',
            url: '${pageContext.request.contextPath}/logout',
            success: function (data) {
                if (data.success) {
                    window.location.reload();
                }
            }
        });
    }

    // function chooseTr(that) {
    //     $(that).closest("table").find("tr").removeClass("active");
    //     $(".myicon").hide();
    //     $(that).closest("tr").find(".myicon").show();
    //     $(that).closest("tr").addClass("active");
    //
    //     var tr = $(that).closest("tr");
    //     showShipping(tr.find(".address").html(), tr.find(".people").html(), tr.find(".phone").html());
    // }

    function showShipping(address, people, phone) {
        $("#showAddress").html(address);
        $("#showPeople").html(people);
        $("#showPhone").html(phone);
    }

    $(function () {
        var totalAmount = 0;
        $.each($(".amount"), function (index, item) {
            totalAmount += parseFloat($(item).html());
        });
        $("#totalAmount").html('￥' + totalAmount.toFixed(2));

        var tr = $("[name='shipping']:checked").closest("tr");
        showShipping(tr.find(".address").html(), tr.find(".people").html(), tr.find(".phone").html());
    });
</script>

<body>
<div style="padding: 10px 0;background-color: rgb(0,0,0,.1);">
    <div class="container" style="padding: 0 8%;font-size: 12px;">
        <a href="${pageContext.request.contextPath}/index">首页</a>&ensp;
        <a href="${pageContext.request.contextPath}/user/indexOfUserInfo" target="_blank">个人中心</a>
        <div class="pull-right" style="font-size: 12px;">
            <span>亲爱的用户&ensp;<b>[ ${sessionScope[UserContext.USER_IN_SESSION].username} ]</b>&ensp;请仔细确认订单哦！</span>&ensp;&ensp;
            <a href="javascript:logout()" style="color: #419641;">安全退出</a>
        </div>
    </div>
</div>
<div class="container" style="padding: 0 8%;font-size: 12px;">
    <div style="padding: 20px 0;min-height: 200px;">
        <table class="table" style="font-size: 12px;">
            <c:forEach items="${bills}" var="bill">
                <fmt:formatDate value="${bill.createTime}" var="createTime" scope="page" timeZone="GMT+8"
                                pattern="yyyy-MM-dd HH:mm:ss"/>
                <table class="table table-bordered" style="font-size: 12px;">
                    <tr>
                        <td>
                            订单编号：${bill.sn}
                            &ensp;&ensp;
                            创建时间：${createTime}
                            &ensp;&ensp;
                            <c:if test="${bill.state == 3 || bill.state == 4}">
                                <fmt:formatDate value="${bill.takeTime}" var="takeTime" scope="page" timeZone="GMT+8"
                                                pattern="yyyy-MM-dd HH:mm:ss"/>
                                交易完成时间：${takeTime}
                            </c:if>
                            <div class="pull-right" style="padding-right: 20px;">
                                订单状态：
                                <c:choose>
                                    <c:when test="${bill.state == -1}">
                                        <b>订单取消</b>
                                    </c:when>
                                    <c:when test="${bill.state == 0}">
                                        <b class="text-danger">待付款</b>
                                    </c:when>
                                    <c:when test="${bill.state == 1}">
                                        <b class="text-success">待发货</b>
                                    </c:when>
                                    <c:when test="${bill.state == 2}">
                                        <b class="text-success">待收货</b>
                                    </c:when>
                                    <c:when test="${bill.state == 3}">
                                        <b class="text-success">待评价</b>
                                    </c:when>
                                    <c:otherwise>
                                        <b class="text-primary">交易完成</b>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            寄送至:${bill.shipping.address}
                            &ensp;&ensp;
                            联系人:${bill.shipping.name}
                            &ensp;&ensp;
                            联系电话:${bill.shipping.phone}
                            &ensp;&ensp;
                        </td>
                    </tr>
                    <tr align="center">
                        <td>
                            <ul class="list-inline" style="margin-bottom: 0;">
                                <li style="width: 50%;"><i>商品信息</i></li>
                                <li style="width: 15%;"><i>单价</i></li>
                                <li style="width: 18%;"><i>数量</i></li>
                                <li style="width: 15%;"><i>总价</i></li>
                            </ul>
                        </td>
                    </tr>
                    <c:forEach items="${bill.items}" var="item">
                        <tr align="center">
                            <td>
                                <ul class="list-inline" style="margin-bottom: 0;">
                                    <li style="width: 50%;">
                                        <div class="pull-left">
                                            <img src="${item.goods.imgs.split(',')[0]}" width="50" height="50">
                                        </div>
                                        <div class="pull-left" style="width: 300px;padding-left: 10px;">
                                            <a href="${pageContext.request.contextPath}/getAllById?id=${item.goods.id}"
                                               target="_blank">${item.goods.name}</a>
                                        </div>
                                    </li>
                                    <li style="width: 15%;">${item.salePrice}</li>
                                    <li style="width: 18%;">${item.num}</li>
                                    <li style="width: 15%;color: red;">${item.amount}</li>
                                </ul>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </c:forEach>
        </table>
    </div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<%@ include file="/WEB-INF/views/common/fixed.jsp" %>
</body>
</html>