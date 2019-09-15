 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->


	<style>

			.fuzzyQuery{
		width:130px;
		height:27px;
		}
		#lkk{
			margin-bottom:-50px;
			text-align:right;
		}

	</style> 
	
	
	     
    <title>用户组管理 - 用户组列表</title>
    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/static/css/layout.css" rel="stylesheet">
  </head>
  <body>
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
          <h1 class="page-header">用户组列表</h1>
          <div class="row placeholders">

  
         <div id="lkk">
          
          <input type="text" id="roleName"  placeholder="请输入用户名" value="${USERS.nickName }">

                 <select id="roleState" style="width:100px;height:30px;font-size=24px;">
            	<option value="" ${USERS.userState == null?'selected':'' }disabled selected hidden>角色状态</option>         
                <option value="1" ${USERS.userState eq 1 ?'selected':''}>启用</option>
                <option value="0" ${USERS.userState eq 0 ?'selected':''}>禁用</option>
                <option value="" ${USERS.userState eq '3' ?'selected':''}>全部</option>
            </select>
           <button type="button" id="unbutt" class="btn btn-primary show-user-form">搜索</button>
          </div><br/>
     
     
     
     
              <script >                                  
        	 $("#unbutt").click(function(){        		  
        		  var groupName = $("#roleName").val();
        		 	
             	 var groupState=$("#roleState option:selected").val();
             
             	 location.href="${pageContext.request.contextPath}/user/listquanxian.action?groupName="+groupName+"&groupState="+groupState;
        	  
        	  }); 
        	
        	  </script>
       	
                 <button type="button" class="btn btn-warning delete-query" data-toggle="modal" data-target="#delete-confirm-dialog">导出数据</button>
                <!--  删除所选对话框 -->
                <div class="modal fade " id="delete-confirm-dialog" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >警告</h4>
                      </div>
                      <div class="modal-body">
                        	确认删除所选用户吗
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary delete-selected-confirm">确认</button>
                      </div>
                    </div>
                  </div>
                </div>
<!--                  <button type="button" class="btn btn-primary show-user-form" data-toggle="modal" data-target="#add-user-form">添加新用户</button>
 -->               
                <!--添加新用户表单-->
      
                <div class="modal fade " id="add-user-form" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >添加角色</h4>
                      </div>
                      <div class="modal-body">
                      	  <form class="user-form" action="${pageContext.request.contextPath}/user/sfssf.action" method="post">                      	
                          <div class="form-group">
                            <label for="userNameInput">名称</label>
                            <input type="text" name="roleName" value="" class="form-cont" id="userNameInputss" placeholder="名称">
                           <label id="userError"></label>
                          </div>
                          
                          
                             <div class="form-group">
                            <label for="userNameInput">描述</label>
                            <input type="text" name="roleDesc"  class="form-cont" id="userTypeInput" placeholder="描述">
                          	<label id="NameError"></label>
                          </div>
                                         
                  
                      	<div class="form-group" >
                            <label for="passwordInput">代码</label>
                            
                            <input type="text" name="roleCode" class="form-control" id="userPwdInput" placeholder="代码">
                         	<label id="userPwdError"></label>
                          </div>
                          
                        
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <input type="submit" id="user_submit" class="btn btn-primary showform" value="添加">
                      </div>
                       </form>
                   
                    </div>
                  </div>
                </div> 
                
          
            <div class="space-div"></div>
             <table class="table table-hover table-bordered role-list">
            
            	<tr>
                	<td><input type="checkbox" class="select-all-btn"/></td>
                    <td>ID</td>
                    <td>用户名</td>
                    <td>手机号</td>
                    <td>创建时间</td>
                    <td>状态</td>               
                    <td>操作</td>
                </tr>
                <!--  <tr>
                	<td><input type="checkbox" name="roleIds"/></td>
                    <td class="roleid">11</td>
                    <td>用户管理员</td>
                    <td>用户管理</td>
                    <td>user_admin</td>
                    <td><a href="javascript:void(0);" class="show-role-perms" >查看所有权限</a></td>
                    <td><a class="glyphicon glyphicon-pencil show-roleinfo-form" aria-hidden="true" title="修改角色信息" href="javascript:void(0);" data-toggle="modal" data-target="#role-form"></a>
                    	<a class="glyphicon glyphicon-remove delete-this-role" aria-hidden="true" title="删除角色" href="javascript:void(0);"></a></td>
                </tr>-->
                <c:forEach items="${page.resultList}" var="role">
	                <tr>
	                	<td><input type="checkbox" name="roleIds" value="${role.userId }"/></td>
	                    <td class="ssss">${role.userId }</td>
	                    <td class="roleid">${role.nickName}</td>
	                    <td class="userCode">${role.phone}</td>
	                    <td class="cnickName">${role.createTime }</td>
	                    <c:if test="${role.userState eq 1}">
                		<td class="roleState">启用</td>
                		</c:if>
                		<c:if test="${role.userState eq 0}">
                		<td class="roleState"  style="color:#FF0000">禁用</td>
                		</c:if>
	                    <%-- <td>${role.getNickName()}</td> --%>
	                    <td>
	                    	<button type="button"   class="btn btn-warning delete-query updaterole " >
	                    	${role.userState eq 1?"禁用":"启用"}
	                    	</button>
	                    	<c:if test="${role.userState eq 0}" > 
	                    	</c:if>
	                    	<c:if test="${role.userState eq 1}" > 
	                    	 <button type="button" class="btn btn-primary show-user-form   ggaiuserrole"  data-toggle="modal" data-target="#update-userrole-dialogs">重置密码</button>
	                    	</c:if>
	                    	
	                    	</td>
	                
	                
	                </tr>
                </c:forEach>
           
            </table>
             <jsp:include page="standard.jsp"/>
  				<div class="modal fade " id="update-userrole-dialogs" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >用户角色</h4>
                      </div>
                      
			<%-- 		<form class="user-form" action="${pageContext.request.contextPath}/user/userwssann.action" method="post">
                          <div class="form-group">
                            <label >用户名</label>
                            <input type="text"  value="" class="form-control" readonly id="jiaoseF" placeholder="用户名"><br/>
                         
                          </div>
                          <input type="hidden" name="" id="userhidden">
                         <c:forEach var="role" items="${ros}">
                        	<input type="checkbox" class="rolecheckbox" name="roleids" value=${role.roleId }> ${role.roleName }                        
                         </c:forEach>

                          <div class="modal-footer">
                           <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	                      
                       	<input type="submit" class="btn btn-primary show-user-form" value="修改">
                        </div>
                  </form> --%>
		          </div>          
		        </div>
		    </div>
            
            
        <%-- <jsp:include page="standard.jsp"/>
  				<div class="modal fade " id="update-userrole-dialogs" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >用户角色</h4>
                      </div>
			
		          </div>          
		        </div>
		    </div>  --%>
    <!--修改用户角色表单-->
  		<div class="modal fade" id="update-userrole-dialog" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
          <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >修改用户角色</h4>
              </div>
       
        	
             
            </div>                   
          </div>
    </div>
    
    <div class="modal fade " id="role-form-update" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
          <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >修改用户角色</h4>
              </div>     
        	<form class="update-userrole-form" action="${pageContext.request.contextPath}/user/xiugais.action" method="post">
                 <div class="modal-body">
                	 ID<br></br>                	
                	<input name="roleId" readonly   id="RoleId"  type="text" readonly /><br></br>                       	
              		名称<br></br>                	
                	<input name="roleName"   id="uid" type="text"  /><br></br>            		
              		描述<br></br>
                	<input name="roleDesc"  id="ucode" type="text" /><br></br>
                	代码<br></br>
                	<input name="roleCode" id="nname"  type="text" /><br></br>
                	
                    <div class="roles-div"></div>           
              </div>
			<input type="submit" class="btn btn-primary show-user-form" value="提交">
            </form>
             
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
    	function getAllRoles(obj){
        	obj.html("");
    		$.ajax({
				url:"listRoles.html",
				type:"POST",
				dataType:"json",
				success:function(data){
					for(var i in data){
						obj.append("<input type='checkbox' name='roleIds' value='"+
								data[i].roleId+"'/>"+data[i].roleName+":"+data[i].roleDesc);
						obj.append("<br/>");
					}
				}
			});
       	}
      
       	function showTips(content){
       		$("#op-tips-content").html(content);
			$("#op-tips-dialog").modal("show");
       	}
    	$(".select-all-btn").change(function(){
			if($(this).is(":checked")){//$(this).prop("checked")
				$(".user-list input[type='checkbox']:gt(0)").prop("checked",true);
			}else{
				$(".user-list input[type='checkbox']:gt(0)").prop("checked",false);
			}
		});
		$(".delete-selected-confirm").click(function(){
			$("#delete-confirm-dialog").modal("hide");
			var cbs=$("input[name='userIds']:checked")
			if(cbs.length===0){
				showTips("没有选中任意项！");
			}else{
				var userids=new Array();
				$.each(cbs,function(i,cb){
					userids[i]=cb.value;
				});
				//请求删除所选用户
				$.ajax({
					url:"deletemore.html",
					data:{userIds:userids},
					type:"POST",
					traditional:true,
					success:function(){
						cbs.parent().parent().remove();
						showTips("删除所选成功！");
					}
				});
			}
		});
		$(".show-user-form").click(function(){
			getAllRoles($(".user-form .roles-div"));
		});
		$(".add-user-submit").click(function(){
			//请求添加新用户
			$.ajax({
				url:"add.html",
				data:{
				userName:"",
				},
				type:"POST",
				dataType:"json",
				success:function(data){
					$("#add-user-form").modal("hide");
					showTips("添加成功！");

					
				}
			});
			
		});
		
		function getRolesByUserName(username,doSuccess){
			$.ajax({
				url:"showroles.html",
				data:{userName:username},
				type:"POST",
				dataType:"json",
				success:function(data){
					doSuccess(data);
				}
			});
		}
	
		$(".user-list").on("click",".show-user-roles",function(){
		
			var username=$(this).parents("tr").find("roleid").html();
			var urTd=$(this).parent();
			//请求查看用户角色
			/*$.ajax({
				url:"showroles.html",
				data:{userName:username},
				type:"POST",
				dataType:"json",
				success:function(data){
					for(var i in data){
						var role=data[i].roleName+":"+data[i].roleDesc+"<br/>";
						urObj.append(role);
					}
				}
			});*/
			getRolesByUserName(username,function(data){
				urTd.html("");
				for(var i in data){
					var role=data[i].roleName+":"+data[i].roleDesc+"<br/>";
					urTd.append(role);
				}
			});
		});
		
		
	
		
		/* 修改用户 */
	$(".wang").click(function(){
		var username=$(this).parents("tr");
		var useri = username.find(".ssss").text(); 
		
		
		var username=$(this).parents("tr");
		var userids = username.find(".roleid").text();		
		
		
		var username=$(this).parents("tr");
		var userCode = username.find(".userCode").text();
		
		var username=$(this).parents("tr");
		var nickName = username.find(".cnickName").text();
		
		

	
		$("#RoleId").val(useri);
		$("#uid").val(userids);
		
		$("#ucode").val(userCode);		
		$("#nname").val(nickName);

		

		}); 
		 
		
		
		
		

		//删除用户
		$(".ggaiuserrole").click(function(){
			var userTr=$(this).parents("tr");
			//获取id
			
			var userid=userTr.find(".ssss").text();	
		
				location.href="${pageContext.request.contextPath}/user/xiu1.action?userId="+userid;

		});
		
		
		//改变状态
		$(".updaterole").click(function(){
			
			var userId=$(this).parents("tr").find(".ssss").text();
		
			var userTr=$(this).parents("tr");
			var userState=userTr.find(".roleState").text();	
			
			location.href="${pageContext.request.contextPath}/user/alsss1.action?userId="+userId+"&userState="+userState;
			
		});
		

		
		
		$(".showform").click(function() {
				
					//昵称
					var userName = $("#userNameInputss").val();
					//部门
					
					var userType = $("#userTypeInput").val();
					//密码
					var userPwd = $("#userPwdInput").val();			
					
					if ("" == userName) {
						$("#userError").css("color", "red").text(
								"昵称不能为空！");
						return false;
					} if (""==userType){
						$("#NameError").removeClass("red").css(
								"color", "red").text("描述不能为空");
							return false;
					}if ("" == userPwd) {
						$("#userPwdError").css("color", "red").text(
								"代码不能为空");
						return false;
					}
				
				
				});

		
		
		/* 分配角色  */
		$(".ggaiuserrole").click(function(){			
			var groupId=$(this).parents("tr").find(".ssss").html();
			
			//请求查看用户角色
			 $.ajax({
				url:"${pageContext.request.contextPath }/user/userIDs.action",
				data:{groupId:groupId},
				type:"POST",								
				dataType:"json",
				success:function(data){
				$("[name = roleids]:checkbox").attr("checked",false);
					for(var i=0;i<data.length;i++){
						var sse = data[i];
						
						$("input[name='roleids']").each(function(){
							if($(this).val()==sse){
								$(this).prop("checked",true);
							}
							
						})
					}
					 
				}
			});
		
		
		});
		if(${param.res==1}){
			alert("重置成功");
		}
	
		
    </script>
  </body>
</html>
