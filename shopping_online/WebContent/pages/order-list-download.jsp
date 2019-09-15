<%@ page language="java" pageEncoding="gbk"%>
<%@ page contentType="application/msword" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%-- 
Wordֻ��Ҫ��contentType="application/msexcel"��ΪcontentType="application/msword" 
--%>
<%   
  //������excel���   
  //response.setHeader("Content-disposition","attachment; filename=MyExcel.xls");   
  
//Ƕ����ie���excel   
  
response.setHeader("Content-disposition","inline; filename=MyExcel.xls");   
  
//response.setHeader("Content-disposition","inline; filename=UserInfo.doc");   
%>  
<html>  
<head>  
<title>���Ե���Excel��Word</title>  
</head>  
<body>  
<table border="1" align="center">  

<tr>
            		<td>����id</td>
                    <td>������</td>
                    <td>���</td>
                    <td>֧����ʽ</td>
                    <td>����״̬</td>
                    <td>����ʱ��</td>
                    <td>�µ��û�</td>
                    <td>����</td>
                </tr>
                <!-- ����չʾ��ɫ -->
                <c:forEach items="${page}" var="order">
	                <tr>
	                 	<td class="orderId">${order.orderId }</td>
	                    <td class="orderNum">${order.orderNum }</td>
	                    <td class="totalMoney">${order.totalMoney }</td>
	                    <c:if test="${order.payWay eq 1}" > 
		                  <td class="payWay">֧����</td>
	                    </c:if>
	                    <c:if test="${order.payWay eq 2}" > 
		                  <td class="payWay">΢��</td>
	                    </c:if>
	                    <c:if test="${order.payWay eq 3}" > 
		                  <td class="payWay">����</td>
	                    </c:if>
	                     
	                    <c:if test="${order.orderState eq 0}" > 
		                  <td class="orderState">������</td>
	                    </c:if>
	                     <c:if test="${order.orderState eq 1}" > 
		                  <td class="orderState">�Ѹ���</td>
	                    </c:if>
	                     <c:if test="${order.orderState eq 2}" > 
		                  <td class="orderState">�����</td>
	                    </c:if>
	                     <c:if test="${order.orderState eq -1}" > 
		                  <td class="orderState">��ȡ��</td>
	                    </c:if>
	                     <c:if test="${order.orderState eq -2}" > 
		                  <td class="orderState">��ɾ��</td>
	                    </c:if> 
	                    
	                    <td class="createTime">${order.createTime }</td>
	                    <td class="userId">${(order.memberInfo).nickName}</td>
		               <td > 
		               	<button type="button" class="btn btn-primary findOrder">��������</button>
		               </td>
                </c:forEach>
  
</table>  
</body>  
</html>  
