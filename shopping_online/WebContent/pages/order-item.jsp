<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <title>订单详情</title>

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
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h1 class="page-header">订单详情</h1>
          <div class="row placeholders">
          
           <!-- 模糊搜索 -->
       <%--    <div id="fuzzyQInfo">
          	<input id="fuzzyQInput" class="fuzzyQuery" type="text" name="userCode" placeholder="请输入用户组名"  value="${groupName}">
           	<select id="fuzzyQState" class="fuzzyQuery" name="userState" style="width:95px" >
               <option value="" ${empty groupState?'selected':'' } style="display:none">用户组状态</option>
               <option value="启用" ${groupState eq '1'?'selected':''}>启用</option>
               <option value="禁用" ${not empty groupState and groupState eq '0'?'selected':''}>禁用</option>
               <option value="全部">全部</option>
           	</select>
          	<button type="button" id="fuzzyQuery" class="btn btn-primary show-user-form">搜索</button>
          </div><br/> --%>
          	<script>
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
			       		var groupName = $("#fuzzyQInput").val();
				       	//获取下列框中的值
			       		var groupState1=$("#fuzzyQState option:selected").val(); 
			       		var groupState="";
			       		if(groupState1=="启用"){
			       			groupState ="1";
			       		}else if(groupState1=="禁用"){
			       			groupState ="0";
			       		}
			       		location.href="../group/list.action?groupName="+ groupName + "&groupState="+groupState;
		          	});
		          </script>
          	<div>
            	<!-- <button type="button" class="btn btn-warning delete-query" data-toggle="modal" 
            	data-target="#delete-confirm-dialog">删除所选</button> -->
<!-- 		<button type="button" class="btn btn-primary show-user-form" data-toggle="modal" data-target="#add-user-form">添加新用户</button>
 -->				
       <!-- 修改角色开始 -->
                <div class="modal fade " id="change-group-info" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-md" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >修改用户组</h4>
                      </div>
                      <div class="modal-body">
                      <!--********修改用户组 -->
                      	<form class="role-form" action="${pageContext.request.contextPath}/group/changeGroupInfo.action" method="post">
                          <input type="hidden" name="groupId" class="form-control" id="changeRoleId">
                         <!-- 修改用户组名称 -->
                          <div class="form-group">
                            <label for="groupNameInput">用户组名称</label>
                            <input type="text" name="GroupName" class="form-control" 
                            onblur="changeGroupNameOnBlur()"  id="changeGroupName" placeholder="用户组名">
                         	<label id="changeGroupNameError"></label>
                          </div>
                         <!-- 修改用户组描述 -->
                          <div class="form-group">
                            <label for="groupDescInput">用户组描述</label>
                            <input type="text" name="groupDesc" class="form-control" 
                            onblur="changeGroupDescOnBlur()" id="changeGroupDesc" placeholder="用户组描述">
                          	<label id="changeGroupDescError"></label>
                          </div>
		                     <div class="modal-footer">
		                       <input type="reset" value="取消" class="btn btn-default" data-dismiss="modal">
		                       <input id="changeRoleSubmit" type="submit" value="修改"  class="btn btn-primary role-submit">
		                     </div>
                        </form>
                      </div>
                    </div>
                  </div>
                </div>
           <!-- 修改角色结束  -->
            </div>
            
            
            <div class="space-div"></div>
            <!-- 用户列表数据展示区 -->
             <table class="table table-hover table-bordered role-list">
            	<tr>
                	<td ><input type="checkbox" class="select-all-btn"/></td>
                    <td >明细ID</td>
                    <td >sku_id</td>
                    <td >商品名称</td>
                    <td >商品价格</td>
                    <td >商品数量</td>
                    <td >商品小计</td>
                    <td >创建时间</td>
                    <td >备注</td>
                    <td >操作</td>
                </tr>
                <!-- 遍历列表数据 -->
                <c:forEach items="${page.resultList}" var="group">
	                <tr>
	                	<td><input type="checkbox" name="roleIds" value=""/></td>
	                    <td class="itemId">${group.itemId }</td>
	                    <td class="skuId">${group.skuId}</td>
	                    <td class="proName">${group.proName}</td>
	                    <td class="proPrice">${group.proPrice}</td>
	                    <td class="proCount">${group.proCount}</td>
	                    <td class="proTotal">${group.proTotal}</td>
	                    <td class="createTime">${group.createTime}</td>
	                    <td class="remark">${group.remark}</td>
	                    <td></td>
	                 </tr>
                </c:forEach>
            </table>
             <button type="button" class="btn btn-primary show-user-form" data-toggle="modal" data-target="#add-user-form">查看地址</button><br><br>
               	          
               				
                <!--添加新用户表单-->
                
                <div class="modal fade " id="add-user-form" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >收货地址</h4>
                      </div>
                     <div class="modal-body">
                      	<form class="user-form" action="###" method="post">
                          <div class="form-group">
                            <label >地址</label>
                            <input type="text"  readonly="readonly" name="addrInfo" value="${Address.addrInfo}" class="form-control" placeholder="地址">
                          </div>
                          <div class="form-group">
                            <label >邮编</label>
                            <input type="text"  readonly="readonly" name="postCode"  value="${Address.postCode}"  class="form-control"  placeholder="邮编">
                          </div>
                          <div class="form-group">
                            <label >收货人</label>
                            <input type="text"  readonly="readonly" name="reapPerson"  value="${Address.reapPerson}"   class="form-control" placeholder="收货人">
                          </div>
                          <div class="form-group">
                            <label>收货人电话</label>
                            <input type="text"  readonly="readonly" name="phone"  value="${Address.phone}"   class="form-control" placeholder="收货人电话">
                          </div>
     
                         </form>

                      </div>
                   
                    </div>
                  </div>
                </div>
      
		    <!-- 引用分页的页面 -->
		     <jsp:include page="standard.jsp"/>
          </div>          
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
    <script>
    </script>
  
		
		
    
  </body>
</html>
