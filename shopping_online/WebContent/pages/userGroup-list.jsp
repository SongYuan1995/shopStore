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

    <title>用户组列表</title>

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
          <h1 class="page-header">用户组列表</h1>
          <div class="row placeholders">
          
           <!-- 模糊搜索 -->
          <div id="fuzzyQInfo">
          	<input id="fuzzyQInput" class="fuzzyQuery" type="text" name="userCode" placeholder="请输入用户组名"  value="${groupName}">
           	<select id="fuzzyQState" class="fuzzyQuery" name="userState" style="width:95px" >
               <option value="" ${empty groupState?'selected':'' } style="display:none">用户组状态</option>
               <option value="启用" ${groupState eq '1'?'selected':''}>启用</option>
               <option value="禁用" ${not empty groupState and groupState eq '0'?'selected':''}>禁用</option>
               <option value="全部">全部</option>
           	</select>
          	<button type="button" id="fuzzyQuery" class="btn btn-primary show-user-form">搜索</button>
          </div><br/>
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
                <!--  删除所选对话框 -->
                <div class="modal fade " id="delete-confirm-dialog" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >警告</h4>
                      </div>
                      <div class="modal-body">
                        	确认删除所选角色吗
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary delete-selected-confirm">确认</button>
                      </div>
                    </div>
                  </div>
                </div>
<!-- ***********************添加新用户组*********************** --> 
		<button type="button" class="btn btn-primary show-user-form " data-toggle="modal" data-target="#add-user-form">添加用户组</button>               
     <!--添加新用户组表单-->
                <div class="modal fade " id="add-user-form" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >添加新用户组</h4>
                      </div>
                      <div class="modal-body">
                      	<form class="user-form" action="${pageContext.request.contextPath}/group/addGroupInfo.action" method="post">
                          <div class="form-group">
                            <label >用户组名称</label>
                            <input type="text" name="groupName" class="form-control" id="groupNameInput"  
                            onblur="groupNameOnBlur()" placeholder="请输入用户组名">
                         	 <label id="groupNameError"></label>
                          </div>
                          <div class="form-group">
                            <label >用户组代码</label>
                            <input type="text" name="groupCode" class="form-control" id="groupCodeInput"  
                            onblur="groupCodeOnBlur()" placeholder="请输入用户组代码">
                           <label id="groupCodeError"></label>
                          </div>
                         <!--  -->
                          <div class="form-group">
                            <label >用户组描述</label>
                           <input type="text" name="groupDesc" class="form-control" id="groupDescInput" 
                            onblur="groupDescOnBlur()" placeholder="请描述该用户组">
                           <label id="groupDescError"></label>
                         </div>
                          <div class="modal-footer">
	                       <input type="reset" onclick="location.href='userGroup-list.jsp'" value="取消" class="btn " />
	                       <input id="user_submit" type="submit" value="添加" class="btn btn-primary add-user-submit addOneUserGroup"/>
	                     </div>
                         </form>
                    </div>
                  </div>
                </div>
             </div>
      <!-- 添加新用户组结束 -->
      
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
                    <td >用户组ID</td>
                    <td >用户组名</td>
                    <td >代码</td>
                    <td >描述</td>
                    <td >状态</td>
                    <td >创建人</td>
                    <td >操作</td>
                </tr>
                <!-- 遍历列表数据 -->
                <c:forEach items="${page.resultList}" var="group">
	                <tr>
	                	<td><input type="checkbox" name="roleIds" value=""/></td>
	                    <td class="groupId">${group.groupId }</td>
	                    <td class="groupName">${group.groupName}</td>
	                    <td class="groupCode">${group.groupCode}</td>
	                    <td class="groupDesc">${group.groupDesc}</td>
	                    <td class="groupEnable"style="${group.groupState eq 0?'color:red;':'' }">${group.groupState eq 0?"禁用":"启用" }</td>
	                    <td class="groupCreateBy">${group.userInfo.userCode}</td>
	                    <td>
	                    	<a class="glyphicon glyphicon-wrench show-group-info" aria-hidden="true" title="修改用户组" href="javascript:void(0);" data-toggle="modal" data-target="#change-group-info"></a>
							<a id="delUserGroup" class="glyphicon glyphicon-remove delete-this-group" aria-hidden="true" title="删除用户组"  ></a>

	                    	<button type="button" class="btn btn-warning delete-query enabAndDisGroup" >
	                    	${group.groupState eq 1?"禁用":"启用" }
	                    	</button>
	                    	<c:if test="${group.groupState eq 0}" > 
	                    	</c:if>
	                    	<c:if test="${group.groupState eq 1}" > 
		                    	 <button type="button" class="btn btn-primary assGroupRoles" data-toggle="modal" data-target="#assign-userrole-dialog">分配角色</button>
	                    	</c:if>
	                	</td>
	                 </tr>
                </c:forEach>
            </table>
		    <!-- 引用分页的页面 -->
		     <jsp:include page="standard.jsp"/>
          </div>          
        </div>
      </div>
    </div>
    
    <!-- 分配角色的弹框 -->                   
           <div class="modal fade " id="assign-userrole-dialog" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >分配角色</h4>
                      </div>
                      <div class="modal-body">
                      	<form action="${pageContext.request.contextPath}/group/comfirmAssRoleSubmit.action"  method="post">
                        <div class="form-group">
                           <!--  <label >用户id</label> -->
                            <input id="assignUserId" type="hidden" name="userCode" readonly class="form-control" placeholder="用户id"/>
                          </div>
                        <div class="form-group">
                            <label >用户组名称</label>
                            <input id="assignUserCode" type="text" name="userCode" readonly class="form-control"  placeholder="用户名"/>
                          </div>
                          <div class="form-group">
                          	<label >用户角色</label><br>
                 			<c:forEach items="${assignUserRoles}" var="assignUserRole" >
	                 			<input class="assignSelectUserRole" name="groupRIds" type="checkbox" value="${assignUserRole.roleId}" /> ${assignUserRole.roleName}<br>
				            </c:forEach>
                         </div>
                          <div class="modal-footer">
	                       <input type="reset" value="取消分配" class="btn btn-default" data-dismiss="modal"/>
	                       <input type="submit" value="确认分配" class="btn btn-primary comfmAssRoleSubmit"/>
	                     </div>
                         </form>
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
/*  <!-- *******************添加用户时使用的规则验证********************* --> */
 //添加用户组时，用Ajax验证组名的唯一性  
    var groupNameFlag = false;
	function groupNameOnBlur(){
		var groupName = $("#groupNameInput").val();
		if(""==groupName){
			$("#groupNameError").css("color","red").text("用户组名称不能为空！");
			groupNameFlag = false;
			return;
		}else if(""!=groupName){
			$.ajax({
				type:"POST",
				url:"${pageContext.request.contextPath}/group/groupNameIsExist.action",
				dataType:"json",
				data:{
					groupName:groupName
				},
				//请求成功
		        success:function(data){
		        	if(data.MSG=='1'){
		        		$("#groupNameError").removeClass("color").text("");
		        		groupNameFlag=true;
		        		//alert("请求成功！")
		        	}else if(data.MSG=='2'){
		        		groupNameFlag = false;
		        		//alert("角色名称："+roleNameFlag);
		        		$("#groupNameError").css("color","red").text("用户组名称已经被占用，请重新输入！");
		        	}
		        },
				error:function (){
		           	alert("系统错误！");
		        }
			}); 
			
		}
	}
//用户组code的唯一性验证
    // id为      groupNameInput  groupCodeInput  groupDescInput  
   //错误提示  groupNameError groupCodeError groupDescError   
   var groupCodeFlag = false;
   function groupCodeOnBlur(){
	//alert("用户组code的唯一性验证")
		var groupCode = $("#groupCodeInput").val();
		if(""==groupCode){
			$("#groupCodeError").css("color","red").text("用户组代码(Code)不能为空！");
			groupCodeFlag = false;
			return;
		}else if(""!=groupCode){
			$.ajax({
				type:"POST",
				url:"${pageContext.request.contextPath}/group/groupCodeIsExist.action",
				dataType:"json",
				data:{
					groupCode:groupCode
				},
				//请求成功
		        success:function(data){
		        	if(data.MSG=='1'){
		        		$("#groupCodeError").removeClass("color").text("");
		        		groupCodeFlag=true;
		        		//alert("请求成功！")
		        	}else if(data.MSG=='2'){
		        		groupCodeFlag = false;
		        		//alert("角色名称："+roleNameFlag);
		        		$("#groupCodeError").css("color","red").text("用户组代码已经被占用，请重新输入！");
		        	}
		        },
				error:function (){
		           	alert("系统错误！");
		        }
			}); 
		}
	}
 //用户组描述的非空验证   
  var groupDescFlag = false;
  function groupDescOnBlur(){
	 //alert("//用户组描述的非空验证 ");
	  var groupDesc = $("#groupDescInput").val();
	  //alert("{groupDesc}"+groupDesc);
	  if(""==groupDesc){
			$("#groupDescError").css("color","red").text("用户组的描述不能为空！");
			groupDescFlag = false;
			return;
		}else  if(""!=groupDesc){
			$("#groupDescError").removeClass("color").text("");
			groupDescFlag = true;
		}
 }
  //点击了添加按钮的点击事件   
	  $(".addOneUserGroup").click(function(){
		  groupNameOnBlur();
		  groupCodeOnBlur();
		  groupDescOnBlur();
		  if(groupNameFlag && groupCodeFlag && groupDescFlag){
			  return true;
		  }else{
			  return false;
		  }
	  });
	    
/* #####################修改用户组#################### */  
 //1)点击了小扳手后回显信息 
	$(".show-group-info").click(function(){
		var groupId=$(this).parents("tr").find(".groupId").html();
		var groupName=$(this).parents("tr").find(".groupName").html();
		var groupDesc=$(this).parents("tr").find(".groupDesc").html();
		//alert("当前Id为="+groupId)
		//alert("name="+groupName)
		$("input[name='groupId']").val(groupId);
		$("input[id='changeGroupName']").val(groupName);
		$("input[id='changeGroupDesc']").val(groupDesc);
	});
//2)给用户组名称做唯一性验证，光标移除事件
	 groupNameFlag = false;
	 function changeGroupNameOnBlur(){
		// alert("给用户组名称做唯一性验证，光标移除事件");
		 var groupName =$("#changeGroupName").val();
		 //alert("groupName="+groupName);
			if(""==groupName){
				$("#changeGroupNameError").css("color","red").text("用户组名称不能为空！");
				groupNameFlag = false;
				return;
			}else if(""!=groupName){
				$.ajax({
					type:"POST",
					url:"${pageContext.request.contextPath}/group/groupNameIsExist.action",
					dataType:"json",
					data:{
						groupName:groupName
					},
					//请求成功
			        success:function(data){
			        	if(data.MSG=='1'){
			        		$("#changeGroupNameError").removeClass("color").text("");
			        		groupNameFlag=true;
			        		//alert("请求成功！")
			        	}else if(data.MSG=='2'){
			        		groupNameFlag = false;
			        		//alert("角色名称："+roleNameFlag);
			        		$("#changeGroupNameError").css("color","red").text("用户组名称已经被占用，请重新输入！");
			        	}
			        },
					error:function (){
			           	alert("系统错误！");
			        }
				}); 
			}
	 }									
 
 
	 //3)给用户组描述做非空验证，光标移除事件
	 groupDescFlag = false;
	 function changeGroupDescOnBlur(){
		// alert("给用户组描述做非空验证，光标移除事件");
		 var groupDesc = $("#changeGroupDesc").val();
		 //alert("{groupDesc}"+groupDesc);
		  if(""==groupDesc){
				$("#changeGroupDescError").css("color","red").text("用户组的描述不能为空！");
				groupDescFlag = false;
				return;
			}else  if(""!=groupDesc){
				$("#changeGroupDescError").removeClass("color").text("");
				groupDescFlag = true;
			}
	 }
 	//4)点击了修改按钮后跳转时的点击事件
	 $("#changeRoleSubmit").click(function(){
		// alert("点击了修改按钮后跳转时的点击事件");
		 changeGroupNameOnBlur();
		 changeGroupDescOnBlur();
		 if(groupNameFlag && groupDescFlag ){
			 return true;
		 }else{
			 return false;
		 }
	 });
/* ##############删除用户组的点击事件############### */
		$(".delete-this-group").click(function(){
			//alert("删除用户组的点击事件");
			var groupId=$(this).parents("tr").find(".groupId").html();
			//alert("groupId"+groupId)
				if(confirm('您确认删除用户组ID为【'+groupId+'】的用户组吗？')){
					location.href="${pageContext.request.contextPath}/group/deleteOneUserGroup.action?groupId="+groupId;
				}
		});
/* ##############启用/禁用用户组的点击事件############### */
		$(".enabAndDisGroup").click(function(){
			//alert("启用/禁用用户组的点击事件");
			var groupId=$(this).parents("tr").find(".groupId").html();
			var groupState1= $.trim($(this).parents("tr").find(".groupEnable").html());
			groupState = groupState1=='启用'?'0':'1';
			groupState2 = groupState1=='启用'?'禁用':'启用';
			//alert("状态="+groupState)
			if(confirm('您确认要'+groupState2+'用户组ID为【'+groupId+'】的用户组吗？')){
				location.href="${pageContext.request.contextPath}/group/enabAndDisOneGroup.action?groupId="+groupId+"&groupState="+groupState;
			}
		});
		
/* ##############为用户组分配角色的点击事件############### */	
/* 华丽的分割线***********************分配角色的点击事件*******************************  */
	var groupId
	 $(".assGroupRoles").click(function(){
			var userTr=$(this).parents("tr");
			//获取id
			 groupId=userTr.find(".groupId").html();
			//获取用户名userCode
			var groupName = userTr.find(".groupName").html();
			//alert("给id为"+userId+"的用户分配角色的点击事件，用户名为"+userCode);
			//给分配角色的form表单中的userId设置值
			$("#assignUserId").val(groupId);
			//给分配角色的form表单中的userCode设置值
			$("#assignUserCode").val(groupName);
			//alert("组名字"+groupName)
			 $.ajax({
				type:"POST",
				url:"${pageContext.request.contextPath}/group/assignUserGroupRoles.action",
				dataType:"json",
				data:{
					groupId:groupId,
	            }, 
				//请求成功
		        success:function(jsonArray){ 
		        	//alert("请求成功");
		        	//alert(jsonArray)
		        	//先全部取消打钩
		        	$("[name=groupRIds]:checkbox").attr("checked",false);
		        	//遍历传过来的当前groupId的数组
		        	for(var i=0;i<jsonArray.length;i++){
		        		var assignedgroupId = jsonArray[i];
		        		//alert("单个的RoleId="+assignedgroupId);
		        		//页面遍历出来的获取复选框,让匹配的复选框被选中
		        		$("input[name='groupRIds']").each(function(){
		        			//console.log("***"+$(this).val()+"***")
		        			if($(this).val()==assignedgroupId){
		        				$(this).prop("checked",true);
		        				//window.location.reload();
		        			}
		        		}); 
		        	}
		        },
				error:function (){
		           	alert("系统错误！");
		        }
			}); 
	 });
/* 华丽的分割线2**********************点击确认分配的点击事件***************************** */ 	 
 /*  $(".comfmAssRoleSubmit").click(function(){
	 //id是在上面获取到的
	//alert("点击确认分配进入的");
	var selectedAssignIds="";
	var i=0;
	 $("input[name='groupIds']").each(function(){
		 //判断复选框是否被选中
		 if($(this).prop("checked")==true){
			 if(i==0){
				 selectedAssignIds = $(this).val();
				 i++;
			 }else{
			 selectedAssignIds = selectedAssignIds+","+$(this).val();
			 alert("是否为空："+selectedAssignIds);
			 }
			//将给用户的角色id存在数组中
		 }
		 if(selectedAssignIds==""){
			return false;
		 }
		 //alert(selectedAssignIds)
	 });
	 $.ajax({
		 type:"POST",
		 url:"${pageContext.request.contextPath}/group/comfirmAssRoleSubmit.action",
		 data:{
			selectedAssignIds:selectedAssignIds
      		},
      	dataType:"json",
      	//async: false,
    	success:function(data){ 
    		alert("请求成功！")
        },
        error:function (){
           	alert("系统错误！");
        },
	 });
 });    */
    



     
    </script>
  
		
		
    
  </body>
</html>
