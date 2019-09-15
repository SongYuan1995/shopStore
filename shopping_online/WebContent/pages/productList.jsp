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
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
  </head>
  <body>
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
          <div>
          <input type="text" name="proName"  placeholder="请输入商品名称"  id="proName" >
          <input type="text" name="typeName"  placeholder="请输入商品分类"  id="typeName" >
       		
          	上下架状态
          	<select id="putUpDownState">
          		<option value="" style="display:none" id="casual">请选择</option>
          		<option value="1" id="putUp">上架</option>
          		<option value="0" id="putDown">下架</option>
          		<option value="">全部</option>
          	</select>
          	是否过期
          	<select id="proState">
          		<option value="" style="display:none"	>请选择</option>
	          	<option value="1" id="health">正常</option>
          		<option value="0" id="unHealth">过期</option>
          		<option value="">全部</option>
          	</select>
          		<button type="button" class="btn btn-primary show-user-form" id="queryPro">商品查询</button>
          </div><br/>
         	
         	<script>/* USER_INFO */
         		$(function(){
         			
         			$("#queryPro").click(function(){
         				var proName = $("#proName").val();
         				var typeName = $("#typeName").val();
         				var proState = $("#proState").val();
         				var proUpDown = $("#putUpDownState").val();
         				location.href="${pageContext.request.contextPath}/productList/list.action?proName="+proName+"&proState="+proState+"&proUpDown="+proUpDown+"&typeName="+typeName;
         			})
         			
         			//参数回显
         			var proName = "${param.proName}";
         			 if (proName != null) {
         				$("#proName").val(proName);
					}
         			var typeName = "${param.typeName}";
         			if (typeName != null) {
         				$("#typeName").val(typeName);
					}
         			var proState = "${param.proState}";
         			if (proState != null) {
         				if (proState == "1") {
         					$("#health").attr("selected","true");
						}
         				else if (proState == "0") {
         					$("#unHealth").attr("selected","true");
						}
         				
					}
         			var proUpDown = "${param.proUpDown}"; 
         			if (proUpDown != null) {
         				if (proUpDown == "1") {
         					$("#putUp").attr("selected","true");
						}
         				else if (proUpDown == "0") {
         					$("#putDown").attr("selected","true");
						}
         				
					}
         			
         			var orderValue = "${orderValue}";
         			console.log("orderValue:"+orderValue);
         			$("#orderBy").html(orderValue);
         			
         			//按销量排序
         			$("#orderBy").click(function(){
         				var order = "";
         				var orderValue =$("#orderBy").html();
         				if (orderValue == "排序(销量)") {
							order = "asc"
							/* $("#orderBy").html("升序(销量)"); */
						}
         				else if(orderValue == "升序(销量)"){
         					order = "desc";
         				}
         				else if(orderValue == "降序(销量)"){
         					order = "";
         				}
         				/* $.ajax({
         					url:"${pageContext.request.contextPath}/productList/list.action",
         					type:"POST",
         					data:{order:order},
         					success:function(data){
         						//window.location.reload(); 
         					}
         				}); */
         				location.href="${pageContext.request.contextPath}/productList/list.action?order="+order;
         				
         			});
         			
         			
         			
         			
         			
         			
         		})
         		
         	</script>
         	
         	
         	
         	
         	
         	
         	<div>
         	
                <button type="button" class="btn btn-warning" id="orderBy"></button>
             	
             
               
               
               
               
                <!--  导出数据对话框    start-->
                <div class="modal fade " id="download" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >警告</h4>
                      </div>
                      <div class="modal-body">
                       		 确认导出所选用户吗
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary download-selected-confirm">确认</button>
                      </div>
                    </div>
                  </div>
                </div>
               <!--  导出数据对话框    end-->
               
               
               
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
                
                
               <!-- data-toggle="modal" data-target="#add-product-form" -->
               <c:if test="${USER_INFO.userType ne '3'}">
                 <button type="button" class="btn btn-primary show-user-form" id="add-product-form">添加新商品</button>
               </c:if>
               	<script type="text/javascript">
               	
               		$(function(){
               			$("#add-product-form").click(function(){
               				
							location.href="${pageContext.request.contextPath}/productList/addNewPro.action";               				
               				
               			});
               			
               		});
               	
               	
               	
               	
               	
               	
               	</script>
                <!--添加新用户表单-->
                
                <div class="modal fade " id="add-product-form" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                    
                      <%-- <div class="modal-header">
                      <c:if test="${fn:contains(THIRD,'添加用户')}">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >添加新用户</h4>
                       	</c:if>
                      </div> --%>
                      
                      
                      <div class="modal-body">
                      	<form class="user-form" >
                      	
                          <div class="form-group">
                            <label for="userNameInput">商品名</label>
                            <input type="text" name="proName" value="" class="form-control" id="userNameInput" placeholder="商品名">
                            <label id="vertifyUsername"></label>
                          </div>
                          
                           <div class="form-group">
                            <label for="nickNameInput">存货</label>
                            <input type="number" name="inventory" value="" class="form-control" id="nickNameInput" placeholder="存货">
                          </div>
                          
          				   <div class="form-group">
                            <label for="userNameInput">生产日期</label>
                            <input type="date" name="proStartName" value="" class="form-control" id="userNameInput" >
                            <label id="vertifyUsername"></label>
                          </div>
                          	
          				  <div class="form-group">
                            <label for="userNameInput">过期日期</label>
                            <input type="date" name="proEndName" value="" class="form-control" id="userNameInput" >
                            <label id="vertifyUsername"></label>
                          </div>
                          
                          <div class="form-group">
                            <label for="userNameInput">商品名</label>
                            <input type="text" name="proName" value="" class="form-control" id="userNameInput" placeholder="商品名">
                            <label id="vertifyUsername"></label>
                          </div>
                          
                           <div class="form-group">
                            <label for="userNameInput">供货商</label>
                            <input type="text" name="proName" value="" class="form-control" id="userNameInput" placeholder="商品名">
                            <label id="vertifyUsername"></label>
                          </div>
                          
                          <%-- <div class="form-group">
                            <label for="groupInput">部门</label>
                            <select id="groupInput">
				          		<option value="" style="display:none">请选择</option>
					          	<c:forEach var="group1" items="${groups}">
					          		<option value=${group1.groupId  }>${group1.groupName }</option>
					          	</c:forEach>
			          		</select>
                          </div>
                          
                          <div class="form-group">
                            <label for="roleInput">用户类型</label>
                            <select id="userType2">
				          		<option value="" style="display:none">请选择</option>
					          	<c:forEach var="role" items="${roles}">
					          		<option value=${role.roleId } >${role.roleName }</option>
					          	</c:forEach>
			          		</select>
                          </div>
                          
                          <div class="form-group">
                            <label for="passwordInput">密码</label>
                            <input type="password" name="password" class="form-control" id="passwordInput" placeholder="密码">
                          </div>
                          
                          <div class="form-group">
                            <label for="passwordInput">确认密码</label>
                            <input type="password" name="confirmPassword" class="form-control" id="confirmPasswordInput" placeholder="确认密码">
                           <label id="vertifyPassword"></label>
                          </div> --%>
                          
                          
                         </form>
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-default cancel-add-user-submit" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary add-user-submit" id="add-user-submit">添加 </button>
                      </div>
                    </div>
                  </div>
                </div>
                
            </div>
            <div class="space-div"></div>
            
            
            <table class="table table-hover table-bordered user-list">
            	<tr>
                	<td><input type="checkbox" class="select-all-btn"/></td>
                    <td>商品ID</td>
                    <td>商品名称</td>
                     <td>商品品牌</td>
                     <td>商品分类</td>
                    <td>销量</td>
                    <td>图片</td>
                    <td>商品库存</td>
                    <td>生产日期</td>
                    <td>过期日期</td>
                    <!-- <td>创建时间</td> -->
                    <td>操作</td>
                </tr>
                <c:forEach items="${page.resultList}" var="product">
                	
                	<tr>
                		<td><input type="checkbox" name="userIds" value="${product.proId}"/></td>
                		<td class="proId">${product.proId}</td> 
                		<td class="proName">${product.proName }</td>
                		<td class="brandName">${product.brand.brandName }</td>
                		<td class="typeName">${product.proType.typeName }</td>
                		<td class="sellCount">${product.sellCount }</td>
                		<td class="proPic">
                			<c:forEach items="${product.proPic.split(',')}" var="src">
                			<img alt="" src="${pageContext.request.contextPath}/${src} " width="50px" height="50px">
                			</c:forEach>
                		</td>
                		<td class="inventory">${product.inventory }</td>
                		 <td class="proStartDate"><fmt:formatDate value="${product.proStartDate }" pattern="yyyy-MM-dd " /> </td> 
                		 <%-- <td class="createTime"><fmt:formatDate value="${product.createTime }" pattern="yyyy-MM-dd " /></td>  --%>
                		  <td class="endTime"><fmt:formatDate value="${product.proEndDate }" pattern="yyyy-MM-dd " /> </td>  
	                    <td>
	                    	 <c:if test="${USER_INFO.userType ne '3'}">
	                    		<a class="glyphicon glyphicon-wrench show-userrole-form updateProInfo"  title="修改商品信息" ></a>
	                    	</c:if>
	                    	
                    		 <c:if test="${USER_INFO.userType ne '3'}">
	                    		<button type="button" class="btn btn-warning delete-query updateProUpDown" id="updateProUpDown" value=${product.proUpDown }  >${product.proUpDown eq 1?'上架':'下架'}</button>
	                    	</c:if>
	                    	
		                    	  <c:if test="${USER_INFO.userType ne '3'}"> 
			                    	 <button type="button" class="btn btn-primary updateProType">修改商品分类</button> 
			                    	 <button type="button" class="btn btn-primary setSku">设置sku</button>
			                    	 <button type="button" class="btn btn-primary updateSku">修改sku</button> 
								 </c:if> 
							 
							
	                    </td>
                	</tr>
               	   
                </c:forEach>
            </table>
            
            
            
            
              <jsp:include page="standard.jsp"/>
              
              
              <!-- 添加商品图片 -->
              <div class="modal fade " id="addPic" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >上传图片</h4>
                      </div>
                      <div class="modal-body">
                      	<form class=""  method="post" action="${pageContext.request.contextPath}/productList/addPic.action"  enctype="multipart/form-data">
     						<input name="proId" type="text"  style="display:none" id="addPic_ProId"/>  <br/>
     						<input type="file" name="file"   />
     						<!-- <input type="file" name=""   />
     						<input type="file" name=""   />
     						<input type="file" name=""   />
     						<input type="file" name=""   /> -->
                        	<div class="roles-div"></div>
                     		<div class="modal-footer">
							     <input type="submit" class="btn btn-primary " id="update-userInfo-submit" value="上传"/>
		                         <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                      		</div>
                       </form>
                        
                      </div>
                    </div>
                  </div>
                  	
            </div>
              
              
              
              <script type="text/javascript">
               
              
              
              
              //*************修改商品信息***********
              	$(function(){
              		$(".updateProInfo").click(function(){
              			var proTr = $(this).parents("tr");
            			var proId = proTr.find(".proId").html();
            			/* var proName = proTr.find(".proName").html();
            			var inventory = proTr.find(".inventory").html();
            			var brandName = proTr.find(".brandName").html();
              			$("#updateProInfoForm_proId").val(proId);
              			$("#updateProInfoForm_proName").val(proName);
              			$("#updateProInfoForm_inventory").val(inventory);
              			//$("#updateProInfoForm_Brands option[value='brandName']").attr("selected","selected");
              			//console.log("brandName:"+brandName);
              			
              			$("#updateProInfoForm_Brands option").each(function(index,e){
              				if ($(e).val() == brandName) {
								$(e).attr("selected","selected");
							}
              			}); */
              			
              			location.href="${pageContext.request.contextPath}/productList/updateProductInfo.action?proId="+proId;
              			
              		});
              		
              		
              		//添加图片时传入Id
              		$(".addPic").click(function(){
              			var proTr=$(this).parents("tr");
            			var proId=proTr.find(".proId").html();
              			//alert("proID"+proId);
              			//proId addPic_ProId
              			$("#addPic_ProId").val(proId);
              		});
              		
              		//点击(修改分类按钮)
              		$(".updateProType").click(function(){
              			var proTr=$(this).parents("tr");
              			var proId = proTr.find(".proId").html();
              			location.href="${pageContext.request.contextPath}/productList/proType.action?proId="+proId;
              		});
              		
              		
              		//跳转sku页面
              		$(".setSku").click(function(){
              			var proTr=$(this).parents("tr");
              			var proId = proTr.find(".proId").html();
              			location.href="${pageContext.request.contextPath}/productList/setSku.action?proId="+proId;
              		});
              		
              		//跳转修改sku页面
              		$(".updateSku").click(function(){
              			
              			var proTr=$(this).parents("tr");
              			var proId = proTr.find(".proId").html();
              			location.href="${pageContext.request.contextPath}/productList/updateSku.action?proId="+proId;
              			
              			
              		});
              		
              	});
              		
              
              
              
              
              </script>
              
              
              
              
              
              
              
              
              
              
              
              
               <!--*************修改商品信息表单**********-->
            <div class="modal fade " id="updateProInfo" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >修改商品信息</h4>
                      </div>
                      <div class="modal-body">
                      	<form class="updateProInfoForm"  method="post" action="${pageContext.request.contextPath}/user/updateUserInfo.action">
                        	 <input name="proId" type="text" id="updateProInfoForm_proId" style="display:none"/>  <br/>
                        	 
                        	  商品名称<br/>
                        	 <input name="proName" type="text" id="updateProInfoForm_proName" readonly/>  <br/>
                        	  品牌<br/>
                        	<select id="updateProInfoForm_Brands" name="brandName">
				          		<option value="" style="display:none">请选择</option>
					          	<c:forEach var="brand" items="${BRANDS}">
					          		<option value=${brand.brandName }>${brand.brandName }</option>
					          	</c:forEach>
					          </select><br/> 
                       		  存货<br/> 
                       		  <input name="inventory" type="number" id="updateProInfoForm_inventory"/> <br/> 
                        	 <!-- 商品介绍<br/> 
                       		  <input name="" type="text" id=""/> <br/> -->
                        		
                        		
                        	  <%-- <select id="update-userInfo-form-groupName" name="groupName">
				          		<option value="" style="display:none">请选择</option>
					          	<c:forEach var="group1" items="${groups}">
					          		<option value=${group1.groupName }>${group1.groupName }</option>
					          	</c:forEach>
					          	<option value="">全部</option>
					          </select> --%>
                        	
                        	<div class="roles-div"></div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <input type="submit" class="btn btn-primary update-userrole-submit" id="update-userInfo-submit"/>
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
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
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
    	
    	//删除所选用户确认按钮
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
				//console.log("userids"+userids);
				location.href="${pageContext.request.contextPath}/user/delete.action?userids="+userids;
			}
		}); 
    	
    	
    	
		
    	//导出数据确认按钮
    	$(".download-selected-confirm").click(function(){
			$("#download").modal("hide");
			/* var cbs=$("input[name='userIds']:checked")
			
				var userids=new Array();
				$.each(cbs,function(i,cb){
					userids[i]=cb.value;
				});
				console.log("userids"+userids); */
				window.location.href="${pageContext.request.contextPath}/user/download.action";
			
		}); 
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
		
		
		
		$(".show-user-form").click(function(){
			getAllRoles($(".user-form .roles-div"));
		});
		
		$("#userNameInput").blur(function(){
			//添加用户时判断用户名唯一
			var userNameInput = $("#userNameInput").val();
			if (userNameInput == "") {
				$("#vertifyUsername").html("用户名不能为空");
			}
			else{
				
				$.ajax({
					url:"${pageContext.request.contextPath}/user/vertifyUnqiueUserCode.action",
					data:{
						userName:userNameInput,
					},
					type:"POST",
					dataType:"json",
					success:function(data){
						console.log("data.msg"+data.msg);
						if (data.msg == 0) {
							$("#vertifyUsername").html("该账号已被占用");
						}
						else {
							$("#vertifyUsername").html("该账号可以使用");
						}

					},
	                error:function (){
	                	alert("系统出现异常！");
	                } 
					
					
				})
				
				
			}
			
			
			
			
			
			
		});
		
		
		
		
		$(".add-user-submit").click(function(){
			//请求添加新用户
			var userNameInput = $("#userNameInput").val();
			var nickNameInput = $("#nickNameInput").val();
			var groupInput = $("#groupInput").val();
			var passwordInput = $("#passwordInput").val();
			var confirmPasswordInput = $("#confirmPasswordInput").val();
			var userType = $("#userType2").val();
			
			//判断信息是否填写正确
			var vertifyUsername = $("#vertifyUsername").html();
			var vertifyPassword = $("#vertifyPassword").html();
			
			
			if (passwordInput != confirmPasswordInput) {
				$("#vertifyPassword").html("两次密码输入不一致");
				return;
			}
			if (!userNameInput || !nickNameInput || !groupInput ||  !passwordInput  || !confirmPasswordInput || !userType) {
				
				alert("请正确填写！");
				
			}
			else {
				
				if (vertifyUsername != "该账号已被占用" && vertifyPassword =="") {
					
				}
				
				$.ajax({
					url:"${pageContext.request.contextPath}/user/add.action",
					data:{
						userNameInput:userNameInput,
						nickNameInput:nickNameInput,
						groupInput:groupInput,
						passwordInput:passwordInput,
						userType:userType
					},
					type:"POST",
					dataType:"json",
					success:function(data){
						if (data.msg==0) {
							$("#add-user-form").modal("hide");
							//location.href="${pageContext.request.contextPath}/user/list.action";
							showTips("添加成功！");
							setTimeout('delayer()',2000);
						}
						else {
							$("#add-user-form").modal("hide");
							showTips("添加失败！");
						}
					},
					error:function(){
						alert("系统错误");
					}
				});
				
				
				
				
			}
			
		});
		
		//取消按钮
		$(".cancel-add-user-submit").click(function(){
			window.location.reload();
		});
		
		
		//添加用户，延迟刷新页面
		function delayer(){
			window.location.reload();
		}
		
		//更改上下架状态：上架，下架
		$(".updateProUpDown").click(function(){
			var proUpDown =$(this).val();
			var proTr=$(this).parents("tr");
			var proId=proTr.find(".proId").html();
			//alert("proId:"+proId+",proUpDown:"+proUpDown);
			if (proUpDown == 1) {
				proUpDown = 0;
			}
			else {
				proUpDown = 1;
			}
			$.ajax({
				url:"${pageContext.request.contextPath}/productList/updateProUpDown.action",
				data:{
					proId:proId,
					proUpDown:proUpDown
				},
				type:"POST",
				success:function(data){
					window.location.reload();
					
				},
				error:function(){
					alert("系统错误");
				}
				
				
			});
			
		});
		
		//重置密码
		
		$(".resetPwd").click(function(){
			var userTr=$(this).parents("tr");
			var userid=userTr.find(".userid").html();
			//alert("userState:"+userState+"。userid:"+userid);
			$.ajax({
				url:"${pageContext.request.contextPath}/user/resetPwd.action",
				data:{userId:userid},
				type:"POST",
				success:function(){
					alert("密码重置成功");
				},
				error:function(){
					
				}
			})
		});
		
		
		
		
		
		//分配角色
			//异步获得当前用户已经拥有的角色
		$(".resetUserRole").click(function(){
			var userTr=$(this).parents("tr");
			var userid=userTr.find(".userid").html();
			
			//分配角色：传userId
			$("#inputUserId").val(userid);
			
			
			$.ajax({
				url:"${pageContext.request.contextPath}/user/resetUserRole.action",
				data:{userId:userid},
				dataType:"html",
				type:"POST",
				success:function(data){
					//将上一次的勾选状况清除
					$("#update-userrole-dialog input").each(function(index,e){
						e.checked = false;
					});
					var roles = data.split(",");
					//console.log("roles："+roles);
					$("#update-userrole-dialog input").each(function(index,e){
						console.log("e.value："+e.value);
						for (var i = 0; i < roles.length; i++) {
							if (roles[i].indexOf(e.value) != -1) {
								e.checked = true;
							}
						}
						
					});
					
					
				}
				
			})
		});
		
		//修改用户信息
			//显示默认信息
		$(".update-userInfo-dialog").click(function(){
			var userTr=$(this).parents("tr");
			
			var userCode=userTr.find(".userCode").html();
			var nickName=userTr.find(".nickName").html();
			var groupName = userTr.find(".groupName").html();
			//console.log("userCode:"+userCode+",nickName:"+nickName+",groupName:"+groupName);
			$("#update-userInfo-form-userCode").val(userCode);	
			$("#update-userInfo-form-nickName").val(nickName);	
			$("#update-userInfo-form-groupName option").each(function(index,e){
				if (e.value == groupName) {
					$(e).attr("selected",true);
				}
			});	
		});
			
		
		//修改权限跳转
		$(".updaAuth").click(function(){
			var userTr=$(this).parents("tr");
			var userCode=userTr.find(".userCode").html();
			var userid=userTr.find(".userid").html();
			//alert("userId:"+userid);
			location.href="${pageContext.request.contextPath}/auth/allAuth.action?userId="+userid+"&userCode="+userCode;
			
			
			
			
			
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
		
			var username=$(this).parents("tr").find(".username").html();
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
		
		$(".user-list").on("click",".show-userrole-form",function(){
			var userid=$.trim($(this).parents("tr").find(".userid").text());
			var username=$(this).parents("tr").find(".username").html();
			$(".update-userrole-form input[name='userId']").val(userid);
			/* //获取当前用户当前角色
			getAllRoles($(".update-userrole-form .roles-div"));
			getRolesByUserName(username,function(data){
				for(var i in data){
					$('.update-userrole-form input[name="roleIds"][value="'+data[i].roleId+'"]').prop("checked",true);
				}
			}); */
		});
		
		$(".user-list").on("click",".delete-this-user",function(){
			var userTr=$(this).parents("tr");
			var userid=userTr.find(".userid").html();
			if(confirm('确认删除当前用户吗？')){
				//请求删除该用户
				$.ajax({
					//location.href="${pageContext.request.contextPath}/user/delete.action?userids="+userids;
					url:"${pageContext.request.contextPath}/user/delete.action",
					data:{userId:userid},
					type:"POST",
					success:function(){
						userTr.remove();
						showTips("删除成功！");
					}
				});
			}
		});
    </script>
  </body>
</html>
