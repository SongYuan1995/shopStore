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

    <title>店铺管理 - 店铺列表</title>
    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/static/css/layout.css" rel="stylesheet">
  </head>
  <body>
<c:if test="${empty USER }">
	<c:redirect url="/pages/login.jsp"></c:redirect>
</c:if>
    <!-- 头部 -->
    <jsp:include page="header.jsp"/>
    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
          <jsp:include page="navibar.jsp"/>
         </div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h1 class="page-header">店铺列表</h1>
          <div class="row placeholders" style="margin-top: -30px;">
          <%-- <div>
          <input type="text" name="userName"  placeholder="用户名" value="${param.userName }">
          </div> --%><br/>
         	<div>
         		<c:if test="${USER.userType eq 0 }">
                 <button type="button"   class="btn btn-primary addShop" data-toggle="modal" data-target="#add-ShopStore-form">添加店铺</button>
                </c:if>
                <!--添加店铺表单-->
                <div class="modal fade " id="add-ShopStore-form" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >添加店铺</h4>
                      </div>
                      <div class="modal-body">
                      	<form class="add-Shop-form" action="${pageContext.request.contextPath}/shop/addShop.action" method="post">
                          <div class="form-group">
                            <label for="shopNameInput">店铺名</label><label class="delAdd" style="margin-left: 63px;" id="shopErrInput"></label>
                            <input type="text" name="storeName" value="" onkeyup="this.value=this.value.replace(/\s+/g,'')" class="form-control addInput" id="shopNameInput" placeholder="店铺名">
                          </div>
                          <div class="form-group">
                            <label for="userNameInput">店主</label>
                            <select id="userShop" name="userShop" class="form-control" >
			                	<c:forEach var="qab" items="${queryAllBoss }">
			                		<option value="${qab.userId},${qab.userCode }">${qab.userCode }</option>
			                	</c:forEach>
                            </select>
                          </div>
                          <div class="form-group">
                            <label for="storePhone">联系电话</label><label class="delAdd" style="margin-left: 100px;" id="shopPhoneErrInput"></label>
                            <input type="text" name="storePhone" value="" onkeyup="this.value=this.value.replace(/\s+/g,'')" class="form-control addInput" id="storePhone" placeholder="联系电话">
                          </div>
                          <div class="form-group">
                            <label for="storeIntro">店铺介绍</label><label class="delAdd" style="margin-left: 100px;" id="storeIntroErrInput"></label>
                            <input type="text" name="storeIntro" class="form-control addInput" id="storeIntro" onkeyup="this.value=this.value.replace(/\s+/g,'')" placeholder="店铺介绍">
                          </div>
                         </form>
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal" >取消</button>    <!-- btn-default" data-dismiss="modal -->
                        <button type="button" class="btn btn-primary add-shop-submit">添加 </button>
                      </div>
                    </div>
                  </div>
                </div>
                <c:if test="${USER.userType eq 0 }">
	                <input type="text" id="storeName" style="margin-left: 613px;margin-top: 1px;height: 31px;" name="userName"  placeholder="请输入店铺名关键字" value="${fuzzyQueryShopStore.storeName }">
	                <%-- <select id="userRole" style="width: 85px;height: 31px;">
	                	<option  value="" ${userInfo.roleId eq null?selected:"" } style="display: none;">用户类型</option>
	                	<c:forEach var="userInfo" items="${USERINFO }">
	                		<option value="${userInfo.roleId }" ${userFuzzyQueryUserInfo.userType eq userInfo.roleId?"selected":""} >${userInfo.roleName }</option>
	                	</c:forEach>
	                	<option value="99" ${userFuzzyQueryUserInfo.userType eq 99?"selected":""}>全部</option>
	                </select> --%>
	                <select id="storeState" style="width: 85px;height: 31px;">
	                	<option ${empty fuzzyQueryShopStore.storeState ?selected:"" } style="display: none;" value="">店铺状态</option>
	                	<option value="1" ${fuzzyQueryShopStore.storeState eq 1?"selected":""}>启用</option>
	                	<option value="0" ${(not empty fuzzyQueryShopStore.storeState and  fuzzyQueryShopStore.storeState eq 0)?"selected":""}>禁用</option>
	                	<option value="99" ${fuzzyQueryShopStore.storeState eq 99?"selected":""}>全部</option>
	                </select>
	                <button type="button" class="btn btn-primary show-user-form" >确定查询</button>
	             </c:if>  
            </div>
            <div class="space-div"></div>
            <table class="table table-hover table-bordered user-list" >
            	<tr style="text-align: center;">
                	<!-- <td><input type="checkbox" class="select-all-btn"/></td> -->
                    <td>店铺ID</td>
                    <td>店铺名</td>
                    <td>店铺等级</td>
                    <td>店主</td>
                    <td>联系电话</td>
                    <td>关注度</td>
                    <td>店铺介绍</td>
                    <td>店铺状态</td>
                    <td>创建时间</td>
                    <td>操作</td>
                </tr>
                <c:forEach items="${page.resultList }" var="shop">
                	<tr >
                		<%-- <td style="text-align: center;"><input type="checkbox" name="userIds" value="${shop.storeId }"/></td> --%>
                		<td style="text-align: center;width: 60px;" class="storeId">${shop.storeId }</td>
                		<td style="text-align: center;" class="storeName">${shop.storeName }</td>
                		<td class="storeLevel" style="text-align: center;width: 73px;">${shop.storeLevel }</td>
                		<%-- <td class="UserGroupId" style="display: none;">${shop.storeHost }</td> --%>
                		<td class=storeHost style="text-align: center;">${shop.storeHost }</td>
                		<td class="storePhone" style="text-align: center;">${shop.storePhone }</td>
                		<td style="text-align: center;width: 60px;">${shop.storeAgree }</td>
                		<td class="storeAgree" style="text-align: center;">${shop.storeIntro }</td>
                		<td style="text-align: center;width: 73px;${shop.storeState eq 0?'color:red;':'' }">${shop.storeState eq 0?"禁用":"启用" }</td>
                		<td style="text-align: center;width: 89px;"><fmt:formatDate value="${shop.createTime }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                		<!-- <td><a href="javascript:void(0);" class="show-user-roles" >显示所有角色</a></td> -->
	                    <td style="width: 18%;">
	                    	<c:if test="${USER.userType eq 3 or USER.userType eq 1 or USER.userType eq 0}">
	                    		<a class="glyphicon glyphicon-wrench update-show-form" aria-hidden="true" title="修改店铺" href="javascript:void(0);" data-toggle="modal" data-target="#update-shop-dialog"></a>
	                    	</c:if>
	                    	<!-- <a class="glyphicon glyphicon-remove delete-this-user" aria-hidden="true" title="删除用户" href="javascript:void(0);" style="color:red"></a> -->
		                    <c:if test="${USER.userType eq 0 }">	
		                    	<a href="${pageContext.request.contextPath}/shop/adminStatus.action?storeId=${shop.storeId }&storeState=${shop.storeState }">
		                    		<button type="button" class="btn btn-warning forbudden" style="width: 72px;padding-left: 6px;" >${shop.storeState eq 1?"禁用":"启用" }</button>
		                    	</a>
		                    </c:if>
		                    <c:if test="${USER.userType eq 3 or USER.userType eq 2 or USER.userType eq 1 or USER.userType eq 0}">
		                    	<a href="${pageContext.request.contextPath}/indexUserManage/forbuddenUser.action?userId=${shop.storeId }&forbuddenId=${shop.storeState }">
		                    		<button type="button" class="btn btn-warning forbudden" style="width: 72px;padding-left: 6px;" >查看店铺</button>
		                    	</a>
		                    </c:if>
	                    </td>
                	</tr>
                </c:forEach>
            </table>
            <form id="deleteUserId" action="${pageContext.request.contextPath}/indexUserManage/deleteUser.action" method="post">
            	<input id="userId" name="userId" type="text" value="" style="display: none;">
            </form>
              <jsp:include page="standard.jsp"/>
            <!--修改店铺表单-->
            <div class="modal fade " id="update-shop-dialog" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >修改店铺信息</h4>
                      </div>
                      <div class="modal-body">
                      	<form id="updateShopForm" class="update-shop-form" method="post">
                      		<div class="form-group">
                        		<label for="UpdateShopIdInput">店铺Id</label>
                        		<input id="UpdateStoreIdIdInput" readonly name="storeId" class="form-control " type="text" />
                        	</div>
                        	<div class="form-group">
	                            <label for="UpdateUserNameInput">店铺名</label><label class="updateDel" style="margin-left: 100px;" id="updateStoreNameErrInput"></label> 
	                            <input type="text" name="storeName" value="" class="form-control " id="UpdateStoreNameInput" >
	                        </div>
	                        <div class="form-group">
	                             <label for="updateStoreHost">店主</label><label class="updateDel" style="margin-left: 100px;" id="updateStoreHostErrInput"></label>
                            <select id="updateStoreHost" name="updateStoreHost" class="form-control" >
			                	<c:forEach var="qab" items="${queryAllBoss }">
			                		<option value="${qab.userId},${qab.userCode }" >${qab.userCode }</option>
			                	</c:forEach>
                            </select>
	                        </div>
	                        <div class="form-group">
	                            <label for="updateStorePhone">联系电话</label><label class="updateDel" style="margin-left: 100px;" id="updateStorePhoneErrInput"></label>
	                            <input type="text" name="storePhone" value="" onkeyup="this.value=this.value.replace(/\s+/g,'')" class="form-control addInput" id="updateStorePhone" placeholder="联系电话">
	                         </div>
	                         <div class="form-group">
	                            <label for="updateStoreIntro">店铺介绍</label><label class="updateDel" style="margin-left: 100px;" id="updateStoreIntroErrInput"></label>
	                            <input type="text" name="storeIntro" class="form-control addInput" id="updateStoreIntro" onkeyup="this.value=this.value.replace(/\s+/g,'')" placeholder="店铺介绍">
	                         </div>
                        </form>
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary update-shop-submit">提交 </button>
                      </div>
                    </div>
                  </div>
            </div>
            <!--修改用户角色表单-->
            <div class="modal fade " id="update-userrole-dialog" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >修改用户角色</h4>
                      </div>
                      <div class="modal-body">
                      	<form id="updateUserRoleForm" class="update-userrole-form" method="post">
                      		<div class="form-group">
                        		<label for="UpdateUserIdInput">用户Id</label>
                        		<input id="UpdateRoleUserIdInput" readonly name="userId" class="form-control RoleUserId" type="text" />
                        	</div>
                        	<div class="form-group">
	                            <label for="UpdateUserNameInput">用户名</label>
	                            <input type="text" name="userCode" readonly value="" class="form-control RoleUserName" id="UpdateRoleUserNameInput" >
	                        </div>
	                        <div class="form-group">
	                        	<label >角色 : </label><br/>
	                        	<c:forEach items="${USERINFO }" var="role">
	                        		<input class="Role" type="checkbox" name="roleId" value="${ role.roleId }" >${ role.roleName}&emsp;&emsp;&emsp;&emsp;
	                            </c:forEach>
	                            <input style="display: none;" type="text" name="roleIds" value="" class="form-control " id="roleIds" >
	                        </div>
                        </form>
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary update-userrole-submit">提交 </button>
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
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
    <script>
//********************************模糊查询*******************************************************************************************************************		
    	function getAllRoles(obj){
    		//alert("进入模糊查询");
    		var storeName = $("#storeName").val();
    		var storeState = $("#storeState").val();
    		/* console.log("用户名关键字="+userCode);
    		console.log("用户类型="+userType);
    		console.log("用户状态="+userState); */
    		location.href="${pageContext.request.contextPath}/shop/adminFullCheckShop.action?storeName="+storeName+"&storeState="+storeState;
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
		/* $(".delete-selected-confirm").click(function(){
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
		}); */
		//查询
		$(".show-user-form").click(function(){
			getAllRoles($(".user-form .roles-div"));
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
//********************************更新用户角色*******************************************************************************************************************		
		//获取页面的值 赋值给更新角色弹框
		$(".user-list").on("click",".show-user-roles",function(){
			var userid = $.trim($(this).parents("tr").find(".userid").text());
			var userCode = $(this).parents("tr").find(".username").html();
			$("#updateUserRoleForm input[name='userId']").val(userid);
			$("#updateUserRoleForm input[name='userCode']").val(userCode);
			//alert("roles="+$("#updateUserRoleForm .Role").length);
			//请求查看用户角色
			$.ajax({
				url:"${pageContext.request.contextPath}/indexUserManage/groupIdUser.action",
				data:{userId:userid},
				type:"POST",
				dataType:"json",
				success:function(data){
					//alert("进入查看用户角色 " +data[0].roleId);
					$("#updateUserRoleForm .Role").removeAttr("checked");
					$.each(data,function(key,value){
						//console.log("id为="+value.roleId);
						$("#updateUserRoleForm .Role").each(function(){
							if($(this).val() == value.roleId){
								//$(this).attr("checked","true");不稳定
								$(this)[0].checked = true;
							}
						});
					});
				}
			});
		});
		//点击添加角色 
		$(".update-userrole-submit").click(function(){
			//拼接当前用户角色的id
			var roleId = "";
			//记录没选角色
			var notRoleId = 0;
			$("#updateUserRoleForm .Role").each(function(){
				console.log($(this)[0].checked);
				if($(this)[0].checked){
					roleId +=$(this).val()+","; 
				}else{
					notRoleId++;
				}
			});
			console.log("roleId="+roleId);
			console.log("notRoleId="+notRoleId);
			if(notRoleId == $("#updateUserRoleForm .Role").length){
				alert("至少选择一个用户角色! !");
			}else{
				$("#roleIds").val(roleId);
				$("#updateUserRoleForm").attr("action","${pageContext.request.contextPath}/indexUserManage/updatRoleUser.action");
				$("#updateUserRoleForm").submit();
			}
		});
//********************************更新店铺信息*******************************************************************************************************************
		//获取页面的值 赋值给更新弹框
		$(".user-list").on("click",".update-show-form",function(){
			//从页面读取数据
			var storeId = $.trim($(this).parents("tr").find(".storeId").text());
			var storeName = $(this).parents("tr").find(".storeName").html();
			var storeHost = $(this).parents("tr").find(".storeHost").html();
			var storePhone = $.trim($(this).parents("tr").find(".storePhone").text());
			var storeIntro = $.trim($(this).parents("tr").find(".storeIntro").text());
			//设置到更新提示框里
			$(".update-shop-form input[name='storeId']").val(storeId);
			$(".update-shop-form input[name='storeName']").val(storeName);
			//删除option的selected属性
			$("#updateStoreHost option").removeAttr("selected");
			//遍历option设置selected
			$("#updateStoreHost option").each(function(){
				$(this).html() == storeHost?$(this).attr("selected","selected"):"";
			});
			$(".update-shop-form input[name='storePhone']").val(storePhone);
			$(".update-shop-form input[name='storeIntro']").val(storeIntro);
		});
		//点击更新店铺清除form表单提示
      	$(".update-show-form").click(function(){
      		//alert("进入清除form表单");
      		//获取更新店铺的form表单
      		$(".update-shop-form .updateDel").html("");
      	});
		//获取光标事件,让提示消失
		$("#UpdateStoreNameInput").focus(function(){
			$("#updateStoreNameErrInput").html("");
		});
		var upStoreNamePd = false;
		//判断店铺名是否重复
		$("#UpdateStoreNameInput").blur(function(){
			//alert("进入异步判断 "+$(this).val());
			//获取用户名
			var storeName = $(this).val();
			if(storeName == ""){
				//alert("为空");
				$("#updateStoreNameErrInput").css({color:"red"}).html("店铺名不能为空");
				upStoreNamePd = false;
				return;
			}else if($(this).val().length <3){
				//alert("小于3");
				$("#updateStoreNameErrInput").css({color:"red"}).html("店铺名少于3个字符或数字");
				upStoreNamePd = false;
				return;
			}
			$.ajax({
				url:"${pageContext.request.contextPath}/shop/repeatShop.action",
				data:{storeName:storeName},
				type:"POST",
				dataType:"json",
				success:function(data){
					if(data.pd){//无用户
						//alert("店铺名可用");
						$("#updateStoreNameErrInput").css({color:"green"}).html("店铺名可用");
						upStoreNamePd = true;
					}else {
						//有用户
						//alert("店铺名不可用");
						$("#updateStoreNameErrInput").css({color:"red"}).html("店铺名不可用");
						upStoreNamePd = false;
					}
				},
				error:function (){
	                   alert("系统错误！");
	                   upStoreNamePd = false;
	                }
			});
		});
		//判断店长有无绑定店铺
		var upShopPd = false;
		//获取光标事件,让提示消失
		$("#updateStoreHost").focus(function(){
			$("#updateStoreHostErrInput").html("");
		});
		$("#updateStoreHost").blur(function(){
			//alert("判断店长有无绑定店铺异步判断 "+$(this).val());
			//获取用户名
			var userCode = $(this).val();
			if(userCode == ""){
				//alert("为空");
				$("#updateStoreHostErrInput").css({color:"red"}).html("店铺名不能为空");
				upShopPd = false;
				return;
			}
			$.ajax({
				url:"${pageContext.request.contextPath}/shop/repeatBoss.action",
				data:{userCode:userCode},
				type:"POST",
				dataType:"json",
				success:function(data){
					if(data.pd){//无用户
						//alert("店铺名可用");
						$("#updateStoreHostErrInput").css({color:"green"}).html("店长无绑定店铺");
						upShopPd = true;
					}else {
						//有用户
						//alert("店铺名不可用");
						$("#updateStoreHostErrInput").css({color:"red"}).html("店长已有店铺");
						upShopPd = false;
					}
				},
				error:function (){
	                   alert("系统错误！");
	                   upShopPd = false;
	                }
			});
		});
		//判断联系电话
		var upPhonePd = false;
		//判断联系电话是否为空
		$("#updateStorePhone").blur(function(){
			var p1=/^(13[0-9]\d{8}|15[0-35-9]\d{8}|18[0-9]\{8}|14[57]\d{8})$/;
			if($(this).val()==""){
				//alert("手机号为空");
				$("#updateStorePhoneErrInput").css({color:"red"}).html("手机号不能为空");
				upPhonePd = false;
			}else if(p1.test($(this).val())==false){
				//alert("手机号不正确");
				$("#updateStorePhoneErrInput").css({color:"red"}).html("请填写正确手机号");
				upPhonePd = false;
			}else{
				//alert("手机号正确");
				upPhonePd = true;
			}
		});
		$("#updateStorePhone").focus(function(){
			$("#updateStorePhoneErrInput").html("");
		});
		//
		$(".update-shop-submit").mousedown(function(){
			$("#UpdateStoreNameInput").trigger("blur");
			$("#updateStoreHost").trigger("blur");
			$("#updateStorePhone").trigger("blur");
		});
		//更新店铺
		$(".update-shop-submit").mouseup(function(){
			//请求更新店铺
			//alert(upStoreNamePd+"  "+upPhonePd)
			if(upStoreNamePd && upShopPd && upPhonePd){
				$(".update-shop-form").attr("action","${pageContext.request.contextPath}/shop/updateShop.action");//action("");
				$(".update-shop-form").submit();
			}else{
				//判断店长绑定的店铺是否强制绑定该店铺
				if(!upShopPd && upStoreNamePd  && upPhonePd){
					if(confirm('当前店长绑定的店铺,确认绑定后当前店铺的原店长将不能管理该店铺,确认继续吗？')){
						$(".update-shop-form").attr("action","${pageContext.request.contextPath}/shop/updateShop.action");//action("");
						$(".update-shop-form").submit();
					}
				}else{
					alert("请完善信息! !");
				}
			}
		});
//********************************添加店铺*******************************************************************************************************************
		//点击添加店铺清除form表单
      	$(".addShop").click(function(){
      		//alert("进入清除form表单");
      		$("#add-ShopStore-form form .addInput").val("");
      		$("#add-ShopStore-form form .delAdd").html("");
      	});
		//获取光标事件,让提示消失
		$("#shopNameInput").focus(function(){
			$("#shopErrInput").html("");
		});
		var storeNamePd = false;
		//判断店铺名是否重复
		$("#shopNameInput").blur(function(){
			//alert("进入异步判断 "+$(this).val());
			//获取用户名
			var storeName = $(this).val();
			if(storeName == ""){
				$("#shopErrInput").css({color:"red"}).html("用户名不能为空");
				storeNamePd = false;
				return;
			}else if($(this).val().length <5){
				$("#shopErrInput").css({color:"red"}).html("用户名少于5个字符或数字");
				storeNamePd = false;
				return;
			}
			$.ajax({
				url:"${pageContext.request.contextPath}/shop/repeatShop.action",
				data:{storeName:storeName},
				type:"POST",
				dataType:"json",
				success:function(data){
					if(data.pd){//无用户
						$("#shopErrInput").css({color:"green"}).html("用户名可用");
						storeNamePd = true;
					}else {
						//有用户
						$("#shopErrInput").css({color:"red"}).html("用户名不可用");
						storeNamePd = false;
					}
				},
				error:function (){
	                   alert("系统错误！");
	                   storeNamePd = false;
	                }
			});
		});
		//判断联系电话
		var phonePd = false;
		//判断联系电话是否为空
		$("#storePhone").blur(function(){
			var p1=/^(13[0-9]\d{8}|15[0-35-9]\d{8}|18[0-9]\{8}|14[57]\d{8})$/;
			if($(this).val()==""){
				$("#shopPhoneErrInput").css({color:"red"}).html("昵称不能为空");
				phonePd = false;
			}else if(p1.test($(this).val())==false){
				$("#shopPhoneErrInput").css({color:"red"}).html("请填写正确手机号");
				phonePd = false;
			}else{
				phonePd = true;
			}
		});
		$("#storePhone").focus(function(){
			$("#shopPhoneErrInput").html("");
		});
		$(".add-shop-submit").mousedown(function(){
			$("#shopNameInput").trigger("blur");
			$("#storePhone").trigger("blur");
		});
		//添加用户
		$(".add-shop-submit").mouseup(function(){
			//请求添加新用户
			//alert(storeNamePd+"  "+phonePd)
			if(storeNamePd && phonePd){
				$(".add-Shop-form").submit();
			}else{
				alert("请完善信息! !");
			}
		});
//*********************************************************************************************************************				
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		function identify(){
			if(${identify == 99} ){
				//alert("☻返回为99");
			}else if(${identify == 0}){
				//alert("返回为0");
				showTips("删除失败！");
			}else if(${identify == 1}){
				//alert("返回为1");
				showTips("删除成功！");
			}else if(${identify == 3}){
				showTips("☻添加成功！");
			}else if(${identify == 4}){
				showTips("添加失败！");
			}else if(${identify == 5}){
				showTips("更新失败！");
			}else if(${identify == 6}){
				showTips("☻更新成功！");
			}
		}
		window.onload = identify; 
    </script>
  </body>
</html>
