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

    <title>商品管理 - 商品列表</title>
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
          <h1 class="page-header">商品列表</h1>
          <div class="row placeholders">
          <!-- 模糊搜索 -->
          <div>
       
          <div id="fuzzyQInfo">
      
          	<input id="fuzzyQInput" class="fuzzyQuery" type="text" name="userCode" placeholder="请输入用户名关键字"  value="${userName}">
          
            <select id="fuzzyQType" class="fuzzyQuery fuzzyQuery_userType" name="userType" style="width:95px">
                <option value="" ${empty userType?'selected':''} style="display:none" >用户类型</option>
                <c:forEach items="${ROLES}" var="role" >
                 	<option value="${role.roleName}" ${role.roleName eq userType?'selected':'' } >${role.roleName}</option>
                </c:forEach>
                <option value="全部">全部</option>
            </select>
        
           <select id="fuzzyQState" class="fuzzyQuery" name="userState" style="width:95px" >
               <option value="" ${empty userState?'selected':'' } style="display:none">用户状态</option>
               <option value="启用" ${userState eq '启用'?'selected':''}>启用</option>
               <option value="禁用" ${not empty userState and userState eq '禁用'?'selected':''}>禁用</option>
               <option value="全部">全部</option>
           </select>
           
          	<button type="button" id="fuzzyQuery" class="btn btn-primary show-user-form">搜索</button>
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
	       		var userName = $("#fuzzyQInput").val();
	       		//获取下列框中的值
	       		var userType=$(".fuzzyQuery_userType option:selected").val(); 
	       		//获取下列框中的值
	       		var userState=$("#fuzzyQState option:selected").val(); 
	       		location.href="../user/list.action?userCode="+userName+"&userType="+userType+"&userState="+userState;
          	});
          
          </script>
          
         	<div>
                <button type="button" class="btn btn-warning export-date-userInfo" >导出数据</button>
                <!-- data-toggle="modal" data-target="#delete-confirm-dialog" -->
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
                 <button type="button" class="btn btn-primary show-user-form" data-toggle="modal" data-target="#add-user-form">添加新用户</button>
<!--**********************添加新用户表单***********************-->
                <div class="modal fade " id="add-user-form" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >添加新用户</h4>
                      </div>
                      <div class="modal-body">
                      	<form class="user-form" action="${pageContext.request.contextPath}/user/addUserInfo.action" method="post">
                          <div class="form-group">
                            <label >用户名</label>
                            <input type="text" name="userCode" value="${param.userName}" class="form-control" id="userCodeInput" placeholder="用户名">
                         	 <label id="userCodeError"></label>
                          </div>
                          <div class="form-group">
                            <label >昵称</label>
                            <input type="text" name="nickName" class="form-control" id="userNameInput"  placeholder="昵称">
                           <label id="userNameError"></label>
                          </div>
                          
                         <!--  -->
                          <div class="form-group">
                            <label >部门</label>
                            <select id="userTypeInput" name="userType" class="form-control"  >
				               <option value="" disable selected hidden>${userGroup.groupName eq null?"选择部门":userGroup.groupName}</option>
				               <c:forEach items="${USER_GROUP}" var="userGroup" >
				                	<option value="${userGroup.groupName}" >${userGroup.groupName}</option>
				               </c:forEach>
				           </select>
				            <label id="userTypeError"></label>
                          </div>
                         
                          <div class="form-group">
                            <label >密码</label>
                            <input type="password" name="userPwd" class="form-control" id="userPwdInput" placeholder="密码">
                         	<label id="userPwdError"></label>
                          </div>
                          <div class="form-group">
                            <label for="passwordInput">确认密码</label>
                            <input type="password" name="userPwdConfirm" class="form-control" id="passwordInput" placeholder="确认密码">
                         	<label id="passwordError"></label>
                          </div>
                          <div class="modal-footer">
	                       <input type="reset" onclick="location.href='user-list.jsp'" value="取消" class="btn " />
	                       <input id="user_submit" type="submit" value="添加" class="btn btn-primary add-user-submit"/>
	                     </div>
                         </form>
                    </div>
                  </div>
                </div>
                </div>
            </div>
            </div>
            
            <div class="space-div"></div>
<!-- 用户列表数据展示区 -->
             <table class="table table-hover table-bordered role-list">
            	<tr>
                	<td ><input type="checkbox" class="select-all-btn"/></td>
                    <td >用户ID</td>
                    <td >用户名</td>
                    <td >昵称</td>
                    <td >部门</td>
                    <td >用户类型</td>
                    <td >用户状态</td>
                    <td >创建时间</td>
                    <td >操作</td>
                </tr>
                <!-- 遍历列表数据 -->
                <c:forEach items="${page.resultList}" var="role">
	                <tr>
	                	<td><input type="checkbox" name="roleIds" value=""/></td>
	                    <td class="userid">${role.userId }</td>
	                    <td class="userCode">${role.userCode}</td>
	                    <td class="nickName">${role.nickName}</td>
	                    <td class="groupName">${role.userGroup.groupName}</td>
	                    <td>${role.role.roleName}</td>
	                    
	                    <td style="${role.userState eq 0?'color:red;':'' }">${role.userState eq 0?"禁用":"启用" }</td>
	                    <!-- 时间格式的转化 -->
	                    <td><fmt:formatDate value="${role.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
	                    <td>
	                    	<a class="glyphicon glyphicon-wrench show-userrole-form" aria-hidden="true" title="修改所有角色" href="javascript:void(0);" data-toggle="modal" data-target="#update-userrole-dialog"></a>
							<a class="glyphicon glyphicon-remove delete-this-user" aria-hidden="true" title="删除用户" href="javascript:void(0);" ></a>

	                    	<button type="button" class="btn btn-warning delete-query enableAndDisable" >
	                    	${role.userState eq 1?"禁用":"启用" }
	                    	</button>
	                    	<c:if test="${role.userState eq 0}" > 
	                    	</c:if>
	                    	<c:if test="${role.userState eq 1}" > 
		                    	 <button type="button" class="btn btn-primary show-user-form resetThisPassword">重置密码</button>
		                    	 <button type="button" class="btn btn-primary assigningRoles" data-toggle="modal" data-target="#assign-userrole-dialog">分配角色</button>
		                    	 <button type="button" class="btn btn-primary changeUSerAuthority">更改权限</button>
	                    	</c:if>
	                	</td>
	                 </tr>
                </c:forEach>
            </table>
<!-- 用户列表数据展示区结束 -->            
              <jsp:include page="standard.jsp"/>
            <!--修改用户角色表单-->
            <div class="modal fade " id="update-userrole-dialog" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >修改用户角色</h4>
                      </div>
                      <div class="modal-body">
                      	<div class="modal-body">
                      	<!-- from表单修改 -->
                      	<form action="${pageContext.request.contextPath}/user/updateUserInfo.action" method="post">
                          <div class="form-group">
                            <label >用户名</label>
                            <input id="updateUserCode" type="text" name="userCode" readonly class="form-control"  placeholder="用户名">
                          </div>
                          <div class="form-group">
                            <label >昵称</label>
                            <input id="updateNickName" type="text" name="nickName" class="form-control" id="userNameInput"  placeholder="昵称">
                          </div>
                         <!--  -->
                           <div class="form-group">
                            <label >部门</label>
                            <select  name="userType" class="form-control updateGroupName"  >
				               <c:forEach items="${USER_GROUP}" var="userGroup" >
				                	<option >${userGroup.groupName}</option>
				               </c:forEach>
				           </select>
                          </div>
                          
                           <div class="modal-footer">
	                       <input type="reset" value="取消" class="btn btn-default" data-dismiss="modal"/>
	                       <input type="submit" value="修改" class="btn btn-primary "/>
	                     </div>
                        </form>
                        <!-- from表单修改结束 -->
                      </div>
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
                      	<form action="${pageContext.request.contextPath}/user/comfirmAssignSubmit.action"  method="post">
                      	<%-- action="${pageContext.request.contextPath}/user/##.action" --%>
                       
                        <div class="form-group">
                           <!--  <label >用户id</label> -->
                            <input id="assignUserId" type="hidden" name="userCode" readonly class="form-control" placeholder="用户id"/>
                          </div>
                        <div class="form-group">
                            <label >用户名</label>
                            <input id="assignUserCode" type="text" name="userCode" readonly class="form-control"  placeholder="用户名"/>
                          </div>
                          <div class="form-group">
                          	<label >用户角色</label><br>
                 			<c:forEach items="${assignUserRoles}" var="assignUserRole" >
	                 			<input class="assignSelectUserRole" name="roleIds" type="checkbox" value="${assignUserRole.roleId}" /> ${assignUserRole.roleName}<br>
				            </c:forEach>
                         </div>
                          <div class="modal-footer">
	                       <input type="reset" value="取消分配" class="btn btn-default" data-dismiss="modal"/>
	                       <input type="submit" value="确认分配" class="btn btn-primary comfirmAssignSubmit"/>
	                     </div>
                         </form>
                    </div>
                  </div>
                </div>
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
  <!-- Bootstrap core JavaScript-->
   <!-- ================================================== -->
    <script>
/*  <!-- *******************添加用户时使用的规则验证********************* --> */
  //添加用户时，用Ajax验证用户名的唯一性
  var flag = true;
	$("#userCodeInput").blur(function(){
		//用户名
		var userCode = $("#userCodeInput").val();
		//用户名的规则验证
		 if(!/^\w{4,16}$/.test(userCode)){
			//alert("用户名不合法! 4-16位，字母，数字，下划线");
			$("#userCodeError").css("color","red").text("用户名不合法! 4-16位，字母，数字，下划线");
			flag = false;
		}
		//alert("添加用户 "+userCode);
		$.ajax({
			type:"POST",
			url:"${pageContext.request.contextPath}/user/addUserCode.action",
			dataType:"json",
			data:{
            	userCode:userCode,
            }, 
            //请求成功
            success:function(json){ 
            	//alert("请求成功")
            	if(json.MSG==1){
            		$("#userCodeError").removeClass("red").css("color","green").html("用户名正确并可用!");
            	}else{
            		$("#userCodeError").css("color","red").text("用户名被占用，请重新输入用户名！");
            	}
            },
            //请求失败了
            error:function (){
               // alert("系统错误！");
             } 
            
		})  
		
	});
//密码的规则验证
	$("#userPwdInput").blur(function(){
		//获取密码
		var userPwd = $("#userPwdInput").val();
		//要求密码6-16位
		if(userPwd.length>16 || userPwd.length<6){
			$("#userPwdError").css("color","red").text("密码不合法! 6-16位，字母，数字");
			   //alert("密码不合法! 6-16位，字母，数字");
				flag = false;
			}else{
				$("#userPwdError").removeClass("red").css("color","green").html("密码格式正确!");
				
			}
		//alert("密码为："+userPwd);
	});
	//获取确认密码
	$("#passwordInput").blur(function(){
		//获取密码
		var userPwd = $("#userPwdInput").val();
		//获取确认密码
		var password = $("#passwordInput").val();
		if(userPwd.length==0){
			$("#passwordError").css("color","red").text("请输入密码再确认");
		}else if(userPwd.length>6 || userPwd.length<16){
			if(userPwd!=password){
				$("#passwordError").css("color","red").text("两次密码输入不一致");
			}else{
				$("#passwordError").removeClass("red").css("color","green").html("两次密码输入一致了，请添加");
			}
		}
	});
	//昵称
	$("#userNameInput").blur(function(){
		$("#userNameError").removeClass("red").css("color","green").html("");
	});
	//部门
	$("#userTypeInput").blur(function(){
		$("#userTypeError").removeClass("red").css("color","green").html("");
	});
//点击添加按钮时非空验证
	$(".user-form").submit(function(){
		//用户名
		var userCode = $("#userCodeInput").val();
		//昵称
		var userName = $("#userNameInput").val();
		//部门
		var userType = $("#userTypeInput").val();
		//密码
		var userPwd = $("#userPwdInput").val();
		//获取确认密码
		var password = $("#passwordInput").val();
		
		if(""==userCode){
			$("#userCodeError").css("color","red").text("用户名不能为空！");
			flag = false;
		}else if(""!=userCode){
			if(!/^\w{4,16}$/.test(userCode)){
				//alert("用户名不合法! 4-16位，字母，数字，下划线");
				$("#userCodeError").css("color","red").text("用户名不合法! 4-16位，字母，数字，下划线");
				flag = false;
			}
			//alert("添加用户 "+userCode);
			$.ajax({
				type:"POST",
				url:"${pageContext.request.contextPath}/user/addUserCode.action",
				dataType:"json",
				data:{
	            	userCode:userCode,
	            }, 
	            //请求成功
	            success:function(json){ 
	            	//alert("请求成功")
	            	if(json.MSG==1){
	            		$("#userCodeError").removeClass("red").css("color","green").html("您的用户名正确并可用!");
	            		flag = true;
	            	}else{
	            		$("#userCodeError").css("color","red").text("用户名已近被占用，请您重新输入用户名！");
	            		flag = false;
	            	}
	            },
	            //请求失败了
	            error:function (){
	                alert("系统错误！");
	             } 
			});  
		}
		
		if(""==userName){
			$("#userNameError").css("color","red").text("昵称不能为空！");
			flag = false;
		}else{
			$("#userNameError").removeClass("red").css("color","green").html("");
		}
		if(""==userType){
			$("#userTypeError").css("color","red").text("请选择部门！");
			flag = false;
		}
		if(""==userPwd){
			$("#userPwdError").css("color","red").text("密码不能为空！");
			flag = false;
		}
		if(""==password ){
			$("#passwordError").css("color","red").text("请确认密码！");
			flag = false;
		}
		if(userPwd!==password){
			$("#passwordError").css("color","red").text("两次密码输入不一致，请重新输入！");
			flag = false;
		}
		return flag==true?true:false;
	});
 
/* <!-- *************************删除用户点击事件********************************* --> */
//删除用户
$(".delete-this-user").click(function(){
	var userTr=$(this).parents("tr");
	//获取id
	var userid=userTr.find(".userid").html();
	//获取userCode
	var userCode = userTr.find(".userCode").html();
	if(confirm('您确认要删除用户ID为【'+userid+'】的用户吗？')){
		location.href="${pageContext.request.contextPath}/user/updateUserInfo.action?userCode="+userCode+"&isDelete=1";
	}
});
/* <!-- *************************修改用户点击事件******************************* -->  */
	$(".show-userrole-form").click(function(){
		var userTr=$(this).parents("tr");
		//var userId=userTr.find(".userid").html();
		var userCode = userTr.find(".userCode").html();
		var nickName = userTr.find(".nickName").html();
		var groupName = userTr.find(".groupName").html();
		//设置进去
		$("#updateUserCode").val(userCode);
		$("#updateNickName").val(nickName);
		//设置下拉列的时候，因为下拉列是遍历出来的,要用class属性，不能用id，一定要注意，
		//不要在原有的class属性上操作，否则将会改变原有的class属性
		$(".updateGroupName").val(groupName);
		//$(".updateGroupName").find("option[text='财务部']").attr("selected",true);
		//alert("userCode"+userCode+"nickName"+nickName+"groupName"+groupName)
		
	});
	
/* <!-- *************************禁用启用的点击事件********************************* -->  */	
    $(".enableAndDisable").click(function(){
    	var userTr=$(this).parents("tr");
		//获取id
		var userId=userTr.find(".userid").html();
		//获取userCode
		var userCode = userTr.find(".userCode").html();
		//$.trim()去掉两边的空格
		var userState = $.trim(userTr.find(".enableAndDisable").html());
		var userState1 = $.trim(userTr.find(".enableAndDisable").html());
		 userState = userState=="启用"?"disable":"enable"
		 userState1 = userState1=="禁用"?"禁用":"启用"
    	//alert("禁用启用的点击事件"+userCode+"用户的id为："+userId+"用户的状态"+userState);
		if(confirm('您确认要'+userState1+'用户ID为【'+userId+'】的用户吗？')){
		 location.href="${pageContext.request.contextPath}/user/updateUserInfo.action?userCode="+userCode+"&isDelete="+userState;
		}
	
    });
/* <!-- **************************重置密码的点击事件******************************** --> */   
	$(".resetThisPassword").on("click",function(){
		var userTr=$(this).parents("tr");
		//获取id
		var userId=userTr.find(".userid").html();
		//获取userCode
		var userCode = userTr.find(".userCode").html();
		if(confirm('您确认重置用户ID为:【'+userId+'】的用户密码吗？')){
		location.href="${pageContext.request.contextPath}/user/updateUserInfo.action?userCode="+userCode+"&isDelete=resetPassword";
		}
	});
/* <!-- *****************导出数据export-date-userInfo点击事件*********************** -->  */	
	$(".export-date-userInfo").click(function(){
		//alert("导出数据");
		if(confirm('您确认要导出用户列表的数据吗？')){
			$.ajax({
				type:"POST",
				url:"${pageContext.request.contextPath}/user/exportUserInfo.action",
				dataType:"json",
				//请求成功
		        success:function(json){ 
		        	if(json.EXPORT_MSG==1){
		        	//alert("请求成功");
		        	location.href="${pageContext.request.contextPath}/pages/user-list-download.jsp";
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
/* 华丽的分割线***********************分配角色的点击事件*******************************  */
		 var userId
	 $(".assigningRoles").click(function(){
			var userTr=$(this).parents("tr");
			//获取id
			 userId=userTr.find(".userid").html();
			//获取用户名userCode
			var userCode = userTr.find(".userCode").html();
			//alert("给id为"+userId+"的用户分配角色的点击事件，用户名为"+userCode);
			//给分配角色的form表单中的userId设置值
			$("#assignUserId").val(userId);
			//给分配角色的form表单中的userCode设置值
			$("#assignUserCode").val(userCode);
			
			$.ajax({
				type:"POST",
				url:"${pageContext.request.contextPath}/user/assigningRoles.action",
				dataType:"json",
				data:{
					userId:userId,
	            }, 
				//请求成功
		        success:function(jsonArray){ 
		        	//alert("请求成功");
		        	//alert(jsonArray)
		        	$("[name=roleIds]:checkbox").attr("checked",false);
		        	for(var i=0;i<jsonArray.length;i++){
		        		var assignedRoleId = jsonArray[i];
		        		//页面遍历出来的获取复选框,让匹配的复选框被选中
		        		$("input[name='roleIds']").each(function(){
		        			console.log("***"+$(this).val()+"***")
		        			if($(this).val()==assignedRoleId){
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
  $(".comfirmAssignSubmit1111").click(function(){
	 //id是在上面获取到的
	//alert("点击确认分配进入的");
	var selectedAssignIds="";
	var selectFlag=0;
	var i=0;
	 $("input[name='rolrIds']").each(function(){
		 //判断复选框是否被选中
		 i=i+1;
		 alert("遍历次数"+i)
		 if($(this).prop("checked")==true){
			 selectedAssignIds = selectedAssignIds+","+$(this).val();
			 /* if(selectFlag==0){
			 selectedAssignIds = selectedAssignIds + $(this).val();
			 alert("^^^^^^^^selectedAssignIds^^^^^^^^^^^"+selectedAssignIds)
			 selectFlag = selectFlag+1;
			 }else{
			 selectedAssignIds = selectedAssignIds+","+$(this).val();
			 } */
			 alert("是否为空："+selectedAssignIds);
			//将给用户的角色id存在数组中
		 }
		 if(selectedAssignIds==""){
			//alert("用户不能没有角色！");
			return false;
		 }
	 alert(selectedAssignIds)
	 });
	 //alert(selectedAssignIds+"id为"+userId);
	 $.ajax({
		 type:"POST",
		 url:"${pageContext.request.contextPath}/user/comfirmAssignSubmit.action",
		 data:{
			userId:userId,
			selectedAssignIds:selectedAssignIds
      		},
      	dataType:"json",
      	//async: false,
      	
    	success:function(jsonAssign){ 
    		alert("返回的值为"+jsonAssign.ASSGIN_MSG);
	       	if("1"==jsonAssign.ASSGIN_MSG){
	       	alert("成功为该用户分配了角色!");
	       	//location.href="${pageContext.request.contextPath}/pages/user-list-download.jsp";
	       	}else if("6"==jsonAssign.ASSGIN_MSG){
	       		alert("用户不能没有角色！为该用户分配了角色失败");
	       	}
        },
        error:function (){
           	alert("系统错误！");
        },
	 });
 });   
    
/* 华丽的分割线**********************点击“更改权限”的点击事件******************************* */ 	    
   $(".changeUSerAuthority").click(function(){
	   var userTr=$(this).parents("tr");
		//获取id
		 userId=userTr.find(".userid").html();
	   //alert("点击确认分配的点击事件");
	   location.href="${pageContext.request.contextPath}/user/userListChangeAuthority.action?userId="+userId;
   });
    
    
    
    
    
    
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
    
    
    
    
    
    
    
		
    </script>
  </body>
</html>
