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

    <title>用户管理 - 角色列表</title>

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
          <h1 class="page-header">角色列表</h1>
          <div class="row placeholders">
          
           <!-- 模糊搜索 -->
          <div id="fuzzyQInfo">
          	<input id="fuzzyQInput" class="fuzzyQuery" type="text" name="userCode" placeholder="请输入角色关键字"  value="${roleName}">
        	<!-- 角色状态 -->
           <select id="fuzzyQState" class="fuzzyQuery" name="" style="width:95px" >
               <option value="" ${empty roleState?'selected':'' } style="display:none">角色状态</option>
               <option value="启用" ${roleState eq '1'?'selected':''}>启用</option>
               <option value="禁用" ${not empty roleState and roleState eq '0'?'selected':''}>禁用</option>
               <option value="全部">全部</option>
           </select>
           
          	<button type="button" id="fuzzyQuery" class="btn btn-primary ">搜索</button>
          </div><br/>
          <script>
         	 $(".fuzzyQuery").css("display","inline").css("color","green");
         	 $(".fuzzyQuery").click(function(){
        	//点击之后颜色发生该变
        	$(".fuzzyQuery").css("color","green");
          });
          //点击搜按钮
	       	$("#fuzzyQuery").click(function(){
	       		//alert("**点击搜按钮**")
	       		//$(".fuzzyQuery").removeClass("color").css("color","darkgrey");
	       		//获取到文本框里的值
	       		var roleName = $("#fuzzyQInput").val();
	       		//获取下列框中的值
	       		var roleState1=$("#fuzzyQState option:selected").val(); 
	       		var roleState="";
	       		if(roleState1=="启用"){
	       			roleState ="1";
	       		}else if(roleState1=="禁用"){
	       			roleState ="0";
	       		}
	       		location.href="../role/list.action?roleName="+roleName+"&roleState="+roleState;
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
<!-- ***********************添加新角色*********************** -->                
            	<button type="button" class="btn btn-primary  show-add-form" data-toggle="modal" data-target="#role-form-div">添加新角色</button>
                <!--添加新角色表单-->
                <div class="modal fade " id="role-form-div" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-md" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                         <h4 class="modal-title" >添加新角色</h4>
                      </div>
                      <div class="modal-body">
                      <!--******** 添加新角色 -->
                      	<form class="role-form" action="${pageContext.request.contextPath}/role/addRoleInfo.action" method="post">
                          <input type="hidden" name="createBy" value="${USER_INFO.userId}"  class="form-control" id="roleIdInput">
                         <!-- 角色名称 -->
                          <div class="form-group">
                            <label for="roleNameInput">名称</label>
                            <input type="text" name="roleName" class="form-control" 
                            onblur="roleNameOnBlur()"  id="roleNameInput" placeholder="角色名">
                         	<label id="roleNameError"></label>
                          </div>
                         <!-- 角色描述 -->
                          <div class="form-group">
                            <label for="descInput">描述</label>
                            <input type="text" name="roleDesc" class="form-control" 
                            onblur="roleDescOnBlur()" id="roleDescInput" placeholder="角色描述">
                          	<label id="roleDescError"></label>
                          </div>
                          <!-- 角色代码 -->
                          <div class="form-group">
                            <label for="codeInput">代码</label>
                            <input type="text" name="roleCode" class="form-control"
                             onblur="roleCodeOnBlur()" id="roleCodeInput" placeholder="角色代码">
                          	<label id="roleCodeError"></label>
                          </div>
		                     <div class="modal-footer">
		                       <input type="reset" value="取消" class="btn btn-default" data-dismiss="modal">
		                       <input id="addRoleSubmit" type="submit" value="添加"  class="btn btn-primary role-submit">
		                     </div>
                        </form>
                      </div>
                    </div>
                  </div>
                </div>
      <!-- 添加角色结束 -->
      
       <!-- 修改角色开始 -->
                <div class="modal fade " id="change-role-info" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-md" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="role-form-title" ></h4>
                      </div>
                      <div class="modal-body">
                      <!--******** 修改角色 -->
                      	<form class="role-form" action="${pageContext.request.contextPath}/role/changeRoleInfo.action" method="post">
                          <input type="hidden" name="roleId" class="form-control" id="chageRoleId">
                         <!-- 角色名称 -->
                          <div class="form-group">
                            <label for="roleNameInput">名称</label>
                            <input type="text" name="roleName" class="form-control" 
                            onblur="changeRoleNameOnBlur()"  id="chageRoleName" placeholder="角色名">
                         	<label id="ChangeroleNameError"></label>
                          </div>
                         <!-- 角色描述 -->
                          <div class="form-group">
                            <label for="descInput">描述</label>
                            <input type="text" name="roleDesc" class="form-control" 
                            onblur="changeRoleDescOnBlur()" id="chageRoleDesc" placeholder="角色描述">
                          	<label id="ChangeroleDescError"></label>
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
            <table class="table table-hover table-bordered role-list">
            	<tr>
                	<td><input type="checkbox" class="select-all-btn"/></td>
                    <td>角色ID</td>
                    <td>角色名称</td>
                    <td>角色描述</td>
                    <td>角色代码</td>
                    <td>状态</td>
                    <td>创建人</td>
                    <td>操作</td>
                </tr>
                <!-- 遍历展示角色 -->
                <c:forEach items="${page.resultList}" var="role">
	                <tr>
	                	<td><input type="checkbox" name="roleIds" value="${role.roleId }"/></td>
	                    <td class="roleid">${role.roleId }</td>
	                    <td class="roleName">${role.roleName }</td>
	                    <td class="roleDesc">${role.roleDesc }</td>
	                    <td>${role.roleCode }</td>
	                    <td class="roleState" style="${role.roleState eq 0?'color:red;':'color:rgb(0, 180,0)' }">${role.roleState eq 0?"禁用":"启用" }</td>
	                    <td>${role.userInfo.userCode}</td>
	                    
	                    <td><a class="glyphicon glyphicon-pencil show-roleinfo-form" aria-hidden="true" title="修改角色信息" href="javascript:void(0);" data-toggle="modal" data-target="#change-role-info"></a>
	                    	<a class="glyphicon glyphicon-remove delete-this-role" aria-hidden="true" title="删除角色" href="javascript:void(0);"></a>
	                   		
	                   		<button type="button" class="btn btn-warning delete-query enableAndDisableRole" >
	                    	${role.roleState eq 1?"禁用":"启用" }
	                    	</button>
	                    	<c:if test="${role.roleState eq 0}" > 
	                    	</c:if>
	                    	<c:if test="${role.roleState eq 1}" > 
		                    	 <button type="button" class="btn btn-primary show-user-form changeRoleAuthority">更改权限</button>
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
    <!-- Bootstrap core JavaScript
    ================================================== -->

    <script>
    	/*  function showTips(contents){
    		$("#op-tips-content").html(contents);
			$("#op-tips-dialog").modal("show");
       	}
       	function resetRoleForm(title,button){
           	$(".role-form input[type='text']").val("");
			$(".role-form input[type='checkbox']").prop("checked",false);
       		$(".role-form-title").html(title);
			$(".role-submit").html(button);
      	}
       	function getAllPerms(obj){
        	obj.html("");
    		$.ajax({
				url:"listperms.html",
				type:"POST",
				dataType:"json",
				success:function(data){
					for(var i in data){
						obj.append('<input type="checkbox" name="permIds" value="'+
								data[i].permissionId+'"/>'+data[i].permissionDesc+':');
						if(data[i].isNavi===1){
							obj.append('<font color="red">导航结点</font>');
						}else{
							obj.append("非导航结点");
						}
							obj.append("<br/>");
					}
				}
			});
       	} 
    	$(".select-all-btn").change(function(){
			if($(this).is(":checked")){//$(this).prop("checked")
				$(".role-list input[type='checkbox']:gt(0)").prop("checked",true);
			}else{
				$(".role-list input[type='checkbox']:gt(0)").prop("checked",false);
			}
		});
		$(".delete-selected-confirm").click(function(){
			$("#delete-confirm-dialog").modal("hide");
			var cbs=$("input[name='roleIds']:checked")
			if(cbs.length===0){
				showTips("没有选中任意项！");
			}else{
				var roleIds='';
				$.each(cbs,function(i,perm){
					//roleIds+=perm.value;
				});
				//请求删除所选角色
				$.ajax({
					url:"deletemore.html",
					data:{roleIds:roleIds},
					type:"POST",
					traditional:true,
					success:function(){
						cbs.parent().parent().remove();
						showTips("删除所选成功！");
					}
				});
			}
		});
		
		 $(".show-add-form").click(function(){
			resetRoleForm("添加新角色","添加");
			getAllPerms($(".perm-inputs"));
		});
		function getPermsByRoleId(roleId,doSuccess){
			$.ajax({
				url:"showroleperms.html",
				data:{roleId:roleId},
				type:"POST",
				dataType:"json",
				success:function(data){
					doSuccess(data);
				}
			});
		} 
		
		$(".role-list").on("click",".show-role-perms",function(){
			var roleId=$(this).parents("tr").find(".roleid").html();
			var rlTd=$(this).parent();
			//请求查看用户角色
			getPermsByRoleId(roleId,function(data){
				rlTd.html("");
				for(var i in data){
					var role=data[i].permissionDesc+"<br/>";
					rlTd.append(role);
				}
			});
		});
		$(".role-list").on("click",".show-roleinfo-form",function(){
			getAllPerms($(".perm-inputs"));
			resetRoleForm("更新角色信息","更新");
			var roleId=$(this).parents("tr").find(".roleid").html();
			$("input[name='roleId']").val(roleId);
			$.ajax({
				url:"getrole.html",
				data:{roleId:roleId},
				type:"POST",
				dataType:"json",
				success:function(data){
					$("input[name='roleName']").val(data.roleName);
					$("input[name='roleDesc']").val(data.roleDesc);
					$("input[name='roleCode']").val(data.roleCode);
				}
			});
			getPermsByRoleId(roleId,function(data){
				for(var i in data){
					$('.role-form input[name="permIds"][value="'+data[i].permissionId+'"]').prop("checked",true);
				}
			});
		});
		$(".role-submit").click(function(){
			if($(this).html()==="添加"){
				//请求添加新角色
				$.ajax({
					url:"add.html",
					type:"POST",
					data:$(".role-form").serialize(),
					dataType:"json",
					success:function(data){
						$("#role-form-div").modal("hide");
						showTips("添加成功！");
						
						
					}
				});
			}else{
				//更新角色信息
				$.ajax({
					url:"updaterole.html",
					data:$(".role-form").serialize(),
					type:"POST",
					success:function(){
						$("#role-form-div").modal("hide");
						showTips("更新成功！");
					}
				});
			}
		}); */
/* *******************************删除角色的点击事件*********************************** */
		$(".role-list").on("click",".delete-this-role",function(){
			var roleTr=$(this).parents("tr");
			var roleId=roleTr.find(".roleid").html();
			if(confirm('确认删除ID为"'+roleId+'"的角色吗？')){
				//请求删除该用户
				location.href="${pageContext.request.contextPath}/role/delectRoleInfo.action?roleId="+roleId;
				/* $.ajax({
					url:"delete.html",
					data:{roleId:roleId},
					type:"POST",
					success:function(){
						roleTr.remove();
						showTips("删除成功！");
					}
				}); */
			}
		});
/* ******************************添加角色的点击事件******************************* */
/*  角色名的光标移除事件 */
	var roleNameFlag=false;
	var roleDescFlag=false;
	var roleCodeFlag=false;
	function roleNameOnBlur(){
		//alert("角色名的光标")
		var roleName = $("#roleNameInput").val();
		if(""==roleName){
			$("#roleNameError").css("color","red").text("角色名称不能为空！");
			roleNameFlag=false;
			return;
		}else{
			$.ajax({
				type:"POST",
				url:"${pageContext.request.contextPath}/role/roleNameIsExist.action",
				dataType:"json",
				data:{
					roleName:roleName
				},
				//请求成功
		        success:function(data){
		        	if(data.MSG=='1'){
		        		$("#roleNameError").removeClass("color").text("");
		        		roleNameFlag=true;
		        		//alert("请求成功！")
		        	}else if(data.MSG=='2'){
		        		 roleNameFlag=false;
		        		 //alert("成功返回2")
		        		//alert("角色名称："+roleNameFlag);
		        		$("#roleNameError").css("color","red").text("角色名称已经被占用，请重新输入！");
		        	}
		        },
				error:function (){
		           	alert("系统错误！");
		        }
			}); 
		}
	}
/*  角色描述的光标移除事件 */
 	function roleDescOnBlur(){
		//alert("角色描述的光标")
		var roleDesc = $("#roleDescInput").val();
		if(""==roleDesc){
			$("#roleDescError").css("color","red").text("角色描述不能为空！");
			roleDescFlag=false;
			return;
		}else{
			$("#roleDescError").removeClass("color").text("");
			 roleDescFlag=true;
			
		}
	}
/*  角色Code的光标移除事件 */	
 	function roleCodeOnBlur(){
 		//alert("角色Code的光标")
 		var roleCode = $("#roleCodeInput").val();
		if(""==roleCode){
			$("#roleCodeError").css("color","red").text("角色Code不能为空！");
			 roleCodeFlag=false;
			return;
		}else{
			$.ajax({
				type:"POST",
				url:"${pageContext.request.contextPath}/role/roleCodeIsExist.action",
				dataType:"json",
				data:{
					roleCode:roleCode
				},
				//请求成功
		        success:function(data){
		        	if(data.MSG=='1'){
		        		$("#roleCodeError").removeClass("color").text("");
		        		roleCodeFlag=true;
		        		//alert("请求成功Code！")
		        	}else if(data.MSG=='2'){
		        		roleCodeFlag=false;
		        		// alert("成功返回Code2")
		        		//alert("角色名称："+roleCodeFlag);
		        		$("#roleCodeError").css("color","red").text("角色Code名称已经被占用，请重新输入！");
		        	}
		        },
				error:function (){
		           	alert("系统错误！");
		        }
			}); 
		}
 	}
 /* 点击添加按钮时的点击事件 */
 	$("#addRoleSubmit").click(function(){
 		//alert("点击添加按钮时的点击事件 ");
 			roleNameOnBlur();
	 		roleDescOnBlur();
	 		roleCodeOnBlur();
	 		//alert("角色名称："+roleNameFlag);
	 		//alert("角色描述"+roleDescFlag);
	 		//alert("角色Code"+roleCodeFlag);
 		if(roleNameFlag && roleDescFlag && roleCodeFlag){
 			return true;
 		}else{
 			return false;
 		}
 	});
/* ******************************修改角色的点击事件******************************* */
 	/*  chageRoleId chageRoleName  chageRoleDesc  ChangeroleNameError   ChangeroleDescError */
 	$(".role-list").on("click",".show-roleinfo-form",function(){
		var roleId=$(this).parents("tr").find(".roleid").html();
		var roleName=$(this).parents("tr").find(".roleName").html();
		var roleDesc=$(this).parents("tr").find(".roleDesc").html();
		$("input[name='roleId']").val(roleId);
		$("input[id='chageRoleName']").val(roleName);
		$("input[id='chageRoleDesc']").val(roleDesc);
	});
/* 修改角色时，角色名框的光标移除事件 */
roleNameFlag=false;
roleDescFlag=false;
function changeRoleNameOnBlur(){
		//alert("角色名的光标");
		var roleName = $("#chageRoleName").val();
		if(""==roleName){
			$("#ChangeroleNameError").css("color","red").text("角色名称不能为空！");
			roleNameFlag=false;
			return;
		}else{
			$.ajax({
				type:"POST",
				url:"${pageContext.request.contextPath}/role/changeNameIsExist.action",
				dataType:"json",
				data:{
					roleName:roleName
				},
				//请求成功
		        success:function(data){
		        	if(data.MSG=='1'){
		        		$("#ChangeroleNameError").removeClass("color").text("");
		        		roleNameFlag=true;
		        		//alert("请求成功！")
		        	}else if(data.MSG=='2'){
		        		 roleNameFlag=false;
		        		// alert("成功返回2")
		        		//alert("角色名称："+roleNameFlag);
		        		$("#ChangeroleNameError").css("color","red").text("角色名称已经被占用，请重新输入！");
		        	}
		        },
				error:function (){
		           	alert("系统错误！");
		        }
			}); 
		}
	}
/* 修改角色时，角色描述desc框的光标移除事件 */
	function changeRoleDescOnBlur(){
	//alert("角色描述的光标")
	var roleDesc = $("#chageRoleDesc").val();
	if(""==roleDesc){
		$("#ChangeroleDescError").css("color","red").text("角色描述不能为空！");
		roleDescFlag=false;
		return;
	}else{
		$("#ChangeroleDescError").removeClass("color").text("");
		 roleDescFlag=true;
	}
}
/* 点击修改按钮后， */
	$("#changeRoleSubmit").click(function(){
		//alert("点击修改按钮后")
		changeRoleNameOnBlur()
		changeRoleDescOnBlur();
 		//alert("角色名称："+roleNameFlag);
 		//alert("角色描述"+roleDescFlag);
		if(roleNameFlag && roleDescFlag){
			return true;
		}else{
			return false;
		}
	});
 /* ##########################禁用角色#################华丽的分割线################## */ 
	$(".enableAndDisableRole").click(function(){
		var roleId=$(this).parents("tr").find(".roleid").html();
		//var roleState=$(this).parents("tr").find(".roleState").html();
		var roleState1 = $.trim($(this).parents("tr").find(".roleState").html());
		roleState = roleState1=='启用'?0:1;
		roleState2= roleState1='启用'?'禁用':'启用'
		//alert("roleId="+roleId);
		//alert("roleState="+roleState);
		if(confirm('您确认要'+roleState2+'角色ID为【'+roleId+'】的角色吗？')){
			$.ajax({
				type:"POST",
				url:"${pageContext.request.contextPath}/role/enableAndDisableRole.action",
				dataType:"json",
				data:{
					roleId:roleId,
					roleState:roleState
				},
				//请求成功
		        success:function(data){
		        	if(data.MSG=='1'){
		        		//alert("请求成功！")
		        		location.href="${pageContext.request.contextPath}/role/list.action"
		        	}else if(data.MSG=='2'){
		        		//alert("成功返回2")
		        		location.href="${pageContext.request.contextPath}/role/list.action"
		        	}
		        },
				error:function (){
		           	alert("系统错误！");
		        }
			}); 
		}
	});	
/**************************** 角色更改权限*************华丽的分割线******** */	
	$(".changeRoleAuthority").click(function(){
		//alert("角色更改权限");/* roleListChangeAuthority.action */
		//获取当前roleId
		var roleId=$(this).parents("tr").find(".roleid").html();
		location.href="${pageContext.request.contextPath}/role/roleListChangeAuthority.action?roleId="+roleId;
	});
		
		
		
		
		
    </script>
    
  </body>
</html>
