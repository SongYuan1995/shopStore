<%@ page language="java" pageEncoding="gbk"%>
<%@ page contentType="application/msword" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%-- 
Word只需要把contentType="application/msexcel"改为contentType="application/msword" 
--%>
<%   
  //独立打开excel软件   
  //response.setHeader("Content-disposition","attachment; filename=MyExcel.xls");   
  
//嵌套在ie里打开excel   
  
response.setHeader("Content-disposition","inline; filename=MyExcel.xls");   
  
//response.setHeader("Content-disposition","inline; filename=UserInfo.doc");   
%>  
<html>  
<head>  
<title>测试导出Excel和Word</title>  
</head>  
<body>  
<table border="1" align="center">  

<tr>
            		<td>订单id</td>
                    <td>订单号</td>
                    <td>金额</td>
                    <td>支付方式</td>
                    <td>订单状态</td>
                    <td>创建时间</td>
                    <td>下单用户</td>
                    <td>操作</td>
                </tr>
                <!-- 遍历展示角色 -->
                <c:forEach items="${page}" var="order">
	                <tr>
	                 	<td class="orderId">${order.orderId }</td>
	                    <td class="orderNum">${order.orderNum }</td>
	                    <td class="totalMoney">${order.totalMoney }</td>
	                    <c:if test="${order.payWay eq 1}" > 
		                  <td class="payWay">支付宝</td>
	                    </c:if>
	                    <c:if test="${order.payWay eq 2}" > 
		                  <td class="payWay">微信</td>
	                    </c:if>
	                    <c:if test="${order.payWay eq 3}" > 
		                  <td class="payWay">银联</td>
	                    </c:if>
	                     
	                    <c:if test="${order.orderState eq 0}" > 
		                  <td class="orderState">待付款</td>
	                    </c:if>
	                     <c:if test="${order.orderState eq 1}" > 
		                  <td class="orderState">已付款</td>
	                    </c:if>
	                     <c:if test="${order.orderState eq 2}" > 
		                  <td class="orderState">已完成</td>
	                    </c:if>
	                     <c:if test="${order.orderState eq -1}" > 
		                  <td class="orderState">已取消</td>
	                    </c:if>
	                     <c:if test="${order.orderState eq -2}" > 
		                  <td class="orderState">已删除</td>
	                    </c:if> 
	                    
	                    <td class="createTime">${order.createTime }</td>
	                    <td class="userId">${(order.memberInfo).nickName}</td>
		               <td > 
		               	<button type="button" class="btn btn-primary findOrder">订单详情</button>
		               </td>
                </c:forEach>
  
</table>  
</body>  
</html>  
