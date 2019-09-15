<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <title>用户管理 - 用户列表</title>
    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/static/css/layout.css" rel="stylesheet">
  <style>
  	.fuzzyQuery{
  		display:block;
  		width:135px;
  		height:30px;
  	}
  	#fuzzyQInfo{
  	margin-bottom:-50px;
    text-align: right;
  	}
  </style>
  </head>
  
  <body>
    <!--==================================================加载库JQuery文件 -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
    <!-- 头部 -->
    <jsp:include page="header.jsp"/>
    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
        <jsp:include page="navibar.jsp"/>
         </div>
        </div>
        
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h1 class="page-header">订单列表</h1>
          <div class="row placeholders">
          <!-- 模糊搜索 -->
          <div>
       
          <div id="fuzzyQInfo">
      
          	<input id="fuzzyQInput" class="fuzzyQuery" type="text" name="userCode" placeholder="请输入店铺关键字"  value="${shopps}">
             <select id="userState" style="width:100px;height:30px;font-size=24px;">
            	   <option value="" ${shop.storeState == null?'selected':'' } disabled selected hidden>店铺状态</option>
            	   <option value="0" ${shop.storeState eq 0?'selected':''}>关闭</option>
            	   <option value="1" ${shop.storeState eq 1?'selected':''}>营业</option>
            	<option value="">全部</option>
            	</select>
          	<button type="button" id="fuzzyQuery" class="btn btn-primary show-user-form">搜索</button><br><br><br>
          </div><br/>
          <script>
          //
          $(".fuzzyQuery").css("display","inline").css("color","green");
          $(".fuzzyQuery").click(function(){
        	//点击之后颜色发生该变
        	$(".fuzzyQuery").css("color","green");
          });
          //点击搜按钮
	       	$("#fuzzyQuery").click(function(){
	       		//点击之后颜色发生该变
	       		//alert("**点击搜按钮**")
	       		$(".fuzzyQuery").css("color","grey");
	       		//获取到文本框里的值
	       		var orderNum =($("#fuzzyQInput").val());
	       		//获取下列框中的值
	       		var payWay=$("#userState option:selected").val(); 
	       		console.log(orderNum+"**"+payWay+"**");
	       		location.href="${pageContext.request.contextPath}/order/shoplist.action?storeName="+orderNum+"&storeState="+payWay;
          	});
          
          </script>
          
         	<div>
               <!--  <button type="button" class="btn btn-warning export-date-userInfo" >导出数据</button> -->
                <!-- data-toggle="modal" data-target="#delete-confirm-dialog" -->
                <!--  删除所选对话框 -->
                <div class="modal fade " id="delete-confirm-dialog" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
<!--**********************添加新用户表单***********************-->
            </div>
            </div>
            
            <div class="space-div"></div>
<!-- 用户列表数据展示区 -->
             <table class="table table-hover table-bordered role-list">
            	<tr>
            		<td>店铺id</td>
                    <td>店铺名称</td>
                    <td>店铺等级</td>
                    <td>店主</td>
                    <td>联系电话</td>
                    <td>关注度</td>
                    <td>店铺介绍</td>
                    <td>店铺状态</td>
                    <td>创建时间</td>
                    <td>操作</td>
                </tr>
                <!-- 遍历展示角色 -->
                <c:forEach items="${page.resultList}" var="shopp">
	                <tr>
	                 	<td class="storeId">${shopp.storeId }</td>
	                    <td class="storeName">${shopp.storeName }</td>
	                    <td class="storeLevel">${shopp.storeLevel }</td>
	                    <td class="storeHost">${shopp.storeHost }</td>
	                    <td class="storePhone">${shopp.storePhone }</td>
	                    <td class="storeAgree">${shopp.storeAgree }</td>
	                    <c:if test="${shopp.storeState eq 0 }">
	                     <td class="storeState">关闭</td>
	                    </c:if>
	                   <c:if test="${shopp.storeState eq 1 }">
	                     <td class="storeState">营业</td>
	                    </c:if>
	                    <td class="createTime">${shopp.createTime }</td>
	                    <td class="storeIntro">${shopp.storeIntro }</td>
		               <td > 
		               	<button type="button" class="btn btn-primary findOrder">店铺详情</button>
		               </td>
                </c:forEach>
            </table>
<!-- 用户列表数据展示区结束 -->            
              <jsp:include page="standard.jsp"/>  
        </div>
    </div>
    </div>
    <!-- 提示框 -->
	<div class="modal fade" id="op-tips-dialog" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
      <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
        	<div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >提示信息</h4>
          </div>
          <div class="modal-body" id="op-tips-content">
          </div>
        </div>
      </div>
    </div>
  <!-- Bootstrap core JavaScript-->
   <!-- ================================================== -->
    <script>


/* <!-- *****************导出数据点击事件*********************** -->  */	
	$(".export-date-userInfo").click(function(){
		//alert("导出数据");
		if(confirm('您确认要导出订单详情的数据吗？')){
			$.ajax({
				type:"POST",
				url:"${pageContext.request.contextPath}/order/exportUserInfo.action",
				dataType:"json",
				//请求成功
		        success:function(json){ 
		        	if(json.EXPORT_MSG==1){
		        	//alert("请求成功");
		        	location.href="${pageContext.request.contextPath}/pages/order-list-download.jsp";
		        	}else{
		        		alert("导出数据出现异常，请重新导出");
		        	}
		        },
				error:function (){
		           	alert("系统错误！");
		        }
			});
		} 
	});

    
    /* 跳转详情 */
   $(".findOrder").click(function(){
   	var cc=$(this).parents("tr");
   	var id = cc.find(".storeId").text();
	   console.log(id+"****************");
	   location.href="${pageContext.request.contextPath}/order/list.action?stid="+id;
   });
    
    
    
    
    
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
    
    
    
    
    
    
    
		
    </script>
  </body>
</html>
