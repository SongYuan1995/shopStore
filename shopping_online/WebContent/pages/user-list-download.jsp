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
  
//response.setHeader("Content-disposition","inline; filename=MyExcel.xls");   
  
response.setHeader("Content-disposition","inline; filename=UserInfo.doc");   
%>  
<html>  
<head>  
<title>���Ե���Excel��Word</title>  
</head>  
<body>  
<table border="1" align="center">  

<tr>
       <td >�û�ID</td>
       <td >�û���</td>
       <td >�ǳ�</td>
       <td >����</td>
       <td >�û�����</td>
       <td >�û�״̬</td>
       <td >����ʱ��</td>
   </tr>
   <!-- �����б����� -->
    <c:forEach items="${export_userInfo}" var="role">
     <tr>
         <td class="userid">${role.userId }</td>
         <td class="userCode">${role.userCode}</td>
         <td class="nickName">${role.nickName}</td>
         <td class="groupName">${role.userGroup.groupName}</td>
         <td>${role.role.roleName}</td>
         
         <td style="${role.userState eq 0?'color:red;':'' }">${role.userState eq 0?"����":"����" }</td>
         <!-- ʱ���ʽ��ת�� -->
         <td><fmt:formatDate value="${role.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
      </tr>
    </c:forEach>
  
</table>  
</body>  
</html>  
