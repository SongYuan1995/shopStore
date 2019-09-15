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

    <title>品牌管理 - 品牌列表</title>
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
          <h1 class="page-header">品牌列表</h1>
          <div class="row placeholders" style="margin-top: -30px;">
          <%-- <div>
          <input type="text" name="userName"  placeholder="用户名" value="${param.userName }">
          </div> --%><br/>
         	<div>
         		<c:if test="${USER.userType eq 0 }">
                 <button type="button"   class="btn btn-primary addBrand" data-toggle="modal" data-target="#add-brand-form">添加品牌</button>
                </c:if>
                <!--添加品牌表单-->
                <div class="modal fade " id="add-brand-form" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >添加品牌</h4>
                      </div>
                      <div class="modal-body">
                      	<form class="add-brand-form" action="${pageContext.request.contextPath}/brand/addBrand.action" method="post">
							<div class="form-group">
	                            <label for="addBrandNameInput">品牌名</label><label class="addDel" style="margin-left: 60px;" id="addBrandNameErrInput"></label> 
	                            <input type="text" name="brandName" value="" class="form-control addInput" id="addBrandNameInput" placeholder="品牌名">
	                        </div>
	                        <div class="form-group">
	                            <label for="addBrandLeter">品牌首字母</label><label class="addDel" style="margin-left: 70px;" id="addBrandLeterErrInput"></label>
	                            <input type="text" name="brandLeter" value="" onkeyup="this.value=this.value.replace(/[^a-z]/g,'');" maxlength="1" class="form-control addInput" id="addBrandLeterInput" placeholder="品牌首字母">
	                         </div>
	                         <div class="form-group">
	                            <label for="addBrandDesc">品牌介绍</label><label class="addDel" style="margin-left: 100px;" id="addBrandDescErrInput"></label>
	                            <input type="text" name="brandDesc" class="form-control addInput" id="addBrandDesc" onkeyup="this.value=this.value.replace(/\s+/g,'')" placeholder="品牌介绍">
	                         </div>
                         </form>
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal" >取消</button>    <!-- btn-default" data-dismiss="modal -->
                        <button type="button" class="btn btn-primary add-brand-submit">添加 </button>
                      </div>
                    </div>
                  </div>
                </div>
                <c:if test="${USER.userType eq 0 }">
	                <input type="text" id="brandName" style="margin-left: 523px;margin-top: 1px;height: 32px;" name="brandName"  placeholder="请输入品牌名关键字" value="${fuzzyQueryBrande.brandName }">
	                <span><input type="text" id="brandLeter" style="margin-top: 1px;height: 32px;" name="brandLeter"  placeholder="请输入品牌首字母" value="${fuzzyQueryBrande.brandLeter }"></span>
	                <button type="button" class="btn btn-primary show-user-form" >确定查询</button>
	             </c:if>  
            </div>
            <div class="space-div"></div>
            <table class="table table-hover table-bordered user-list" >
            	<tr style="text-align: center;">
                    <td>品牌ID</td>
                    <td>品牌名</td>
                    <td>品牌首字母</td>
                    <td>品牌介绍</td>
                    <td>操作</td>
                </tr>
                <c:forEach items="${page.resultList }" var="brand">
                	<tr >
                		<td style="text-align: center;width: 60px;" class="brandId">${brand.brandId }</td>
                		<td style="text-align: center;width: 400px;" class="brandName">${brand.brandName }</td>
                		<td style="text-align: center;width: 88px;" class="brandLeter">${brand.brandLeter }</td>
                		<td class="brandDesc" style="text-align: center;">${brand.brandDesc }</td>
	                    <td style="width: 60px;">
	                    	<c:if test="${USER.userType eq 3 or USER.userType eq 1 or USER.userType eq 0}">
	                    		<a class="glyphicon glyphicon-wrench update-brand" aria-hidden="true" title="修改品牌" href="javascript:void(0);" data-toggle="modal" data-target="#update-brand-dialog"></a>
	                    	</c:if>
		                    <c:if test="${USER.userType eq 0 }">	
	                    		<a class="glyphicon glyphicon-remove delete-this-brand" aria-hidden="true" title="删除品牌" href="javascript:void(0);" style="color:red"></a>
		                    </c:if>
	                    </td>
                	</tr>
                </c:forEach>
            </table>
            <form id="deleteBrandId" action="${pageContext.request.contextPath}/brand/deleteBrand.action" method="post">
            	<input id="brandId" name="brandId" type="text" value="" style="display: none;">
            </form>
              <jsp:include page="standard.jsp"/>
            <!--修改品牌表单-->
            <div class="modal fade " id="update-brand-dialog" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >修改品牌信息</h4>
                      </div>
                      <div class="modal-body">
                      	<form id="updateBrandForm" class="update-brand-form" method="post">
                      		<div class="form-group">
                        		<label for="UpdateBrandIdInput">品牌Id</label>
                        		<input id="UpdateBrandIdInput" readonly name="brandId" class="form-control " type="text" />
                        	</div>
                        	<div class="form-group">
	                            <label for="UpdateBrandNameInput">品牌名</label><label class="updateDel" style="margin-left: 100px;" id="updateBrandNameErrInput"></label> 
	                            <input type="text" name="brandName" value="" class="form-control " id="UpdateBrandNameInput" placeholder="品牌名">
	                        </div>
	                        <div class="form-group">
	                            <label for="updateBrandLeter">品牌首字母</label><label class="updateDel" style="margin-left: 70px;" id="updateBrandLeterErrInput"></label>
	                            <input type="text" name="brandLeter" value="" onkeyup="this.value=this.value.replace(/[^a-z]/g,'');" maxlength="1" class="form-control addInput" id="updateBrandLeterInput" placeholder="品牌首字母">
	                         </div>
	                         <div class="form-group">
	                            <label for="updateBrandDesc">店铺介绍</label><label class="updateDel" style="margin-left: 100px;" id="updateBrandDescErrInput"></label>
	                            <input type="text" name="brandDesc" class="form-control addInput" id="updateBrandDesc" onkeyup="this.value=this.value.replace(/\s+/g,'')" placeholder="品牌介绍">
	                         </div>
                        </form>
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary update-brand-submit">提交 </button>
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
    		var brandName = $("#brandName").val();
    		var brandLeter = $("#brandLeter").val();
    		/* console.log("用户名关键字="+userCode);
    		console.log("用户类型="+userType);
    		console.log("用户状态="+userState); */
    		location.href="${pageContext.request.contextPath}/brand/adminFullCheckBrand.action?brandName="+brandName+"&brandLeter="+brandLeter;
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
//********************************更新品牌信息*******************************************************************************************************************
		//获取页面的值 赋值给更新弹框
		$(".user-list").on("click",".update-brand",function(){
			//从页面读取数据
			var brandId = $.trim($(this).parents("tr").find(".brandId").text());
			var brandName = $(this).parents("tr").find(".brandName").html();
			var brandLeter = $(this).parents("tr").find(".brandLeter").html();
			var brandDesc = $(this).parents("tr").find(".brandDesc").html();
			//设置到更新提示框里
			$(".update-brand-form input[name='brandId']").val(brandId);
			$(".update-brand-form input[name='brandName']").val(brandName);
			$(".update-brand-form input[name='brandLeter']").val(brandLeter);
			$(".update-brand-form input[name='brandDesc']").val(brandDesc);
		});
		//点击更新品牌清除form表单提示
      	$(".update-brand").click(function(){
      		//alert("进入清除form表单");
      		//获取更新店铺的form表单
      		$(".update-brand-form .updateDel").html("");
      	});
		//获取光标事件,让提示消失
		$("#UpdateBrandNameInput").focus(function(){
			$("#updateBrandNameErrInput").html("");
		});
		var upBrandNamePd = false;
		//判断品牌名是否重复
		$("#UpdateBrandNameInput").blur(function(){
			//alert("进入异步判断 "+$(this).val());
			//获取用户名
			var brandName = $(this).val();
			if(brandName == ""){
				//alert("为空");
				$("#updateBrandNameErrInput").css({color:"red"}).html("品牌名不能为空");
				upBrandNamePd = false;
				return;
			}else if($(this).val().length <2){
				//alert("小于3");
				$("#updateBrandNameErrInput").css({color:"red"}).html("品牌名少于2个字符或数字");
				upBrandNamePd = false;
				return;
			}
			$.ajax({
				url:"${pageContext.request.contextPath}/brand/repeatBrandName.action",
				data:{brandName:brandName},
				type:"POST",
				dataType:"json",
				success:function(data){
					if(data.pd){//无用户
						//alert("店铺名可用");
						$("#updateBrandNameErrInput").css({color:"green"}).html("品牌名可用");
						upBrandNamePd = true;
					}else {
						//有用户
						//alert("店铺名不可用");
						$("#updateBrandNameErrInput").css({color:"red"}).html("品牌名不可用");
						upBrandNamePd = false;
					}
				},
				error:function (){
	                   alert("系统错误！");
	                   upBrandNamePd = false;
	                }
			});
		});
		//判断品牌首字母
		var upBrandLeterPd = false;
		//判断品牌首字母是否为空
		$("#updateBrandLeterInput").blur(function(){
			if($(this).val()==""){
				//alert("手机号为空");
				$("#updateBrandLeterErrInput").css({color:"red"}).html("品牌首字母不能为空");
				upBrandLeterPd = false;
			}else{
				//alert("手机号正确");
				upBrandLeterPd = true;
			}
		});
		$("#updateBrandLeterInput").focus(function(){
			$("#updateBrandLeterErrInput").html("");
		});
		//鼠标按下提交按钮
		$(".update-brand-submit").mousedown(function(){
			$("#UpdateBrandNameInput").trigger("blur");
			$("#updateBrandLeterInput").trigger("blur");
		});
		//鼠标松开提交按钮,更新品牌
		$(".update-brand-submit").mouseup(function(){
			//请求更新品牌
			//alert(upStoreNamePd+"  "+upPhonePd)
			if(upBrandNamePd && upBrandLeterPd){
				$(".update-brand-form").attr("action","${pageContext.request.contextPath}/brand/updateBrand.action");//action("");
				$(".update-brand-form").submit();
			}else{
				alert("请完善信息! !");
			}
		});
//********************************添加品牌*******************************************************************************************************************
		//点击添加品牌清除form表单
      	$(".addBrand").click(function(){
      		//alert("进入清除form表单");
      		$("#add-brand-form form .addInput").val("");
      		$("#add-brand-form form .addDel").html("");
      	});
		//获取光标事件,让提示消失
		$("#addBrandNameInput").focus(function(){
			$("#addBrandNameErrInput").html("");
		});
		var addBrandNamePd = false;
		//判断品牌名是否重复
		$("#addBrandNameInput").blur(function(){
			//alert("进入异步判断 "+$(this).val());
			//获取品牌名
			var brandName = $(this).val();
			if(brandName == ""){
				$("#addBrandNameErrInput").css({color:"red"}).html("品牌名不能为空");
				addBrandNamePd = false;
				return;
			}else if($(this).val().length <2){
				$("#addBrandNameErrInput").css({color:"red"}).html("品牌名少于2个字符或数字");
				addBrandNamePd = false;
				return;
			}
			$.ajax({
				url:"${pageContext.request.contextPath}/brand/repeatBrandName.action",
				data:{brandName:brandName},
				type:"POST",
				dataType:"json",
				success:function(data){
					if(data.pd){//无用户
						$("#addBrandNameErrInput").css({color:"green"}).html("品牌可用");
						addBrandNamePd = true;
					}else {
						//有用户
						$("#addBrandNameErrInput").css({color:"red"}).html("品牌名不可用");
						addBrandNamePd = false;
					}
				},
				error:function (){
	                   alert("系统错误！");
	                   addBrandNamePd = false;
	                }
			});
		});
		//判断品牌首字母
		var addBrandLeterPd = false;
		//判断品牌首字母是否为空
		$("#addBrandLeterInput").blur(function(){
			if($(this).val()==""){
				$("#addBrandLeterErrInput").css({color:"red"}).html("品牌首字母不能为空");
				addBrandLeterPd = false;
			}else{
				addBrandLeterPd = true;
			}
		});
		$("#addBrandLeterInput").focus(function(){
			$("#addBrandLeterErrInput").html("");
		});
		$(".add-brand-submit").mousedown(function(){
			$("#addBrandNameInput").trigger("blur");
			$("#addBrandLeterInput").trigger("blur");
		});
		//添加用户
		$(".add-brand-submit").mouseup(function(){
			//请求添加新用户
			//alert(storeNamePd+"  "+phonePd)
			if(addBrandNamePd && addBrandLeterPd){
				$(".add-brand-form").submit();
			}else{
				alert("请完善信息! !");
			}
		});
//*********************************删除品牌******************************************************************************				
		//删除用户
		$(".user-list").on("click",".delete-this-brand",function(){
			var brandTr=$(this).parents("tr");
			var brandId=brandTr.find(".brandId").html();
			//alert("获取标签tr="+userTr.html());
			if(confirm('确认删除ID为"'+brandId+'"的品牌吗？')){
				//请求删除该用户
				$("#brandId").val(brandId);
				$("#deleteBrandId").submit();
			}
		});
		
		
		
		
		
		
		
		
		
		
		
		
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
