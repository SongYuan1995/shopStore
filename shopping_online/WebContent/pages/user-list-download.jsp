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
  
//response.setHeader("Content-disposition","inline; filename=MyExcel.xls");   
  
response.setHeader("Content-disposition","inline; filename=UserInfo.doc");   
%>  
<html>  
<head>  
<title>测试导出Excel和Word</title>  
</head>  
<body>  
<table border="1" align="center">  

<tr>
       <td >用户ID</td>
       <td >用户名</td>
       <td >昵称</td>
       <td >部门</td>
       <td >用户类型</td>
       <td >用户状态</td>
       <td >创建时间</td>
   </tr>
   <!-- 遍历列表数据 -->
    <c:forEach items="${export_userInfo}" var="role">
     <tr>
         <td class="userid">${role.userId }</td>
         <td class="userCode">${role.userCode}</td>
         <td class="nickName">${role.nickName}</td>
         <td class="groupName">${role.userGroup.groupName}</td>
         <td>${role.role.roleName}</td>
         
         <td style="${role.userState eq 0?'color:red;':'' }">${role.userState eq 0?"禁用":"启用" }</td>
         <!-- 时间格式的转化 -->
         <td><fmt:formatDate value="${role.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
      </tr>
    </c:forEach>
  
</table>  
</body>  
</html>  
