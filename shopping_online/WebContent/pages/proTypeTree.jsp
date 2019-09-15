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
<title>商品分类管理 - 商品分类列表</title>
<!-- Bootstrap core CSS -->
<link
	href="${pageContext.request.contextPath}/static/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Custom styles for this template -->
<link href="${pageContext.request.contextPath}/static/css/layout.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/zTree/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/zTree/css/demo.css"
	type="text/css">
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/zTree/js/jquery.ztree.core.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/zTree/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript">
    var Id;
       var setting = {    
        
        	check:{
               enable:true,
               chkStyle: "radio",  //单选框
               radioType: "all"   //对所有节点设置单选
            },   
            
            /* check:{//使用复选框
                enable:true  
            }, */ 
            data: {
                simpleData:{//是否使用简单数据模式
                    enable:true
                }
            },
            callback:{
                onCheck:onCheck
            },
            view:{
            	fontCss:setFontCss
            }
        };
         //id 标识 ，pId 父id，name 名称，open 是否展开节点， checked  是否选中        
        var zNodes = ${proTypeJson}; 

        function setFontCss(treeId, treeNode){
        	return treeNode.state == "0"?{color:"gray"}:{};
        }
        $(document).ready(function(){
            $.fn.zTree.init($("#treeDemo"), setting, zNodes);
        });
//**************************************提示信息*********************************************************
        $(function(){
        	if(${null == identify}){
        		//showTips("请选择一个节点,方可操作! !");
        	}else if(${identify == 1}){
        		showTips("删除失败! !");
        	}else if(${identify == 5}){
        		showTips("更新失败! !");
        	}else if(${identify == 7}){
        		showTips("添加失败! !");
        	}
        });
    	function showTips(content){
       		$("#op-tips-content").html(content);
			$("#op-tips-dialog").modal("show");
       	}    
//***************************选中复选框后触发事件***************************************************************
        //选中复选框后触发事件
        function onCheck(e,treeId,treeNode){
        	var treeObj=$.fn.zTree.getZTreeObj(treeId),
        	nodes=treeObj.getCheckedNodes(true),
        	nodes1=treeObj.getCheckedNodes(false),//点击取消redio消失
        	v="";//authId
        	//console.log("长度="+nodes1.length);
        	//console.log("treeId="+treeId);
        	for(var i=0;i<nodes1.length;i++){//点击取消redio消失
        		$(".xiugai").css({display:"none"});
        		$(".shanchu").css({display:"none"});
        		//console.log("未选中哪一级="+nodes1[i].level);
        		/* $(".huifu").css({display:"none"}); */
        	}
        	//获取选中的复选框的值
        	for(var i=0;i<nodes.length;i++){
        		v+=nodes[i].id;
        		$(".xiugai").css({display:"none"});
        		$(".shanchu").css({display:"none"});
        		$(".huifu").css({display:"none"});
        		console.log("等级="+nodes[i].level);
        		if(nodes.length==0){
        			
        		}else{
        			$(".xiugai").css({display:""});
        			/* $(".huifu").css({display:""}); */
        			$(".tianjia").css({display:""});
        			$(".shanchu").css({display:""});
        		}
        	}
        	Id=v;
       	 	//alert(v);
        }
//*****************************添加分类*********************************************************************       
	//分类名成功还是失败
	var addTypeNamePd = false;
	//分类描述是否为空
	//var addTypeDescPd = false;
	//分类特性成功还是失败
	var addSpecIdsPd = false;
	
	$(function(){
		//点击添加按钮
		$(".add-button-form").click(function(){
			var treeObj=$.fn.zTree.getZTreeObj("treeDemo"),
        	nodes=treeObj.getCheckedNodes(true),
        	v="";
			//清除添加form表单的内容
			$(".add-proType-form .delInput").val("");
			$(".add-proType-form .qingkong").html("");
			$(".add-proType-form .specidsInput").each(function(){//清除打勾的
				$(this)[0].checked=false;
			});
			//alert("清空form表单");
		});
		$("#addTypeNameInput").focus(function(){//点击分类名称清空错误提示
			$("#addTypeNameErrInput").html("");
		});
		//判断分类名是否重复
		$("#addTypeNameInput").blur(function(){
			if($(this).val() == ""){
				$("#addTypeNameErrInput").css({color:"red"}).html("分类名不能为空!");
				addTypeNamePd = false;
				return;
			}else{
				var typeName = $(this).val();
				//alert("传的参数为="+authName);
				$.ajax({
					url:"${pageContext.request.contextPath}/proType/isTypeName.action",
					data:{typeName:typeName},
					type:"POST",
					dataType:"json",
					success:function(data){
						if (data.pd === "Y") {
							$("#addTypeNameErrInput").css({color:"green"}).html("分类名可用!");
							addTypeNamePd = true;
							return;
						}else if(data.pd === "N"){
							$("#addTypeNameErrInput").css({color:"red"}).html("分类名不可用!");
							addTypeNamePd = false;
							return;
						}
					},
					error: function(data){
						console.log("服务器异常");
						addTypeNamePd = false;
					}
				});
			}
		});
		$(".addSpecidsDiv").focus(function(){//鼠标获取清空提示
			$("#addSpecidsInputErrInput").html("");
		});
	});
	//请求添加分类 
	function addProTypeSubmit(){ 
			//alert("进入添加");
			$("#addTypeNameInput").blur();
			$(".specidsInput").each(function(){
				if($(this)[0].checked){
					addSpecIdsPd = true;
					//console.log("有选中checkBox");
					return false;
				}else{
					//console.log("无选中checkBox");
					addSpecIdsPd = false;
				}
			});
	 		var treeObj=$.fn.zTree.getZTreeObj("treeDemo"),
            	nodes=treeObj.getCheckedNodes(true);
	 		//console.log(addTypeNamePd +",,"+ addSpecIdsPd);
	 		if(addTypeNamePd && addSpecIdsPd){
	 			$(".add-proType-form").attr("action","${pageContext.request.contextPath}/proType/addShopType.action");
	 			//console.log("几级="+ nodes.length);
	 			if(nodes.length == 0){
	      				$("#addParentIdInput").val("0");//类型Type
	      				$(".add-proType-form").submit();
		 		}else{ 
		 			//alert("当前等级为:"+nodes[0].level+"级");
      				var parentId=nodes[0].id;
      				alert(" Pid为当前id="+parentId);
      				$("#addParentIdInput").val(parentId);//父id
      				$(".add-proType-form").submit();
				}
	 		}else{
	 			alert("请正确填写");
	 		}
	}
	//});
			
//******************************修改分类***************************************************************************			 
		function updateClick(){
			var treeObj=$.fn.zTree.getZTreeObj("treeDemo"),
        	nodes=treeObj.getCheckedNodes(true),
        	v=""; 
			for(var i=0;i<nodes.length;i++){
        		v=nodes[i].id;
        		//console.log("1获取的当前id="+v); //获取选中节点的值
        	}
			$(".update-form .specidsInput").each(function(){//清除打勾的
				$(this)[0].checked=false;
			});
			if(v != ""){
		 		var TypeName="";//权限名
		 		var TypeDesc="";//权限描述
				for(var i=0;i<nodes.length;i++){
		       		v=nodes[i].id;
		       		//alert("选中id="+v);
		       		TypeName=nodes[i].name;
		       		//alert("选中name="+authName);
		       		TypeDesc=nodes[i].desc;
		       		//alert("选中描述="+authDesc);
		       		//alert(nodes[i].id); //获取选中节点的值
		       		/* $("#authIdInput").val(v); */
		       	}
				$.ajax({
					url:"${pageContext.request.contextPath}/proType/shopTypeId.action",
					data:{typeId:v},
					type:"POST",
					dataType:"json",
					success:function(data){
						$.each(data,function(key,value){
							$(".update-form .specidsInput").each(function(){
								if($(this).val() == value){
									//$(this).attr("checked","true");不稳定
									$(this)[0].checked = true;
								}
							});
						});
					},
					error: function(data){
						console.log("服务器异常");
						typeNamePd=false;
					}
				});
				var id=$("#typeIdInputCh").val(v);
		       	var an=$("#updateTypeNameInput").val(TypeName);
		 		var ad=$("#updateTypeDescInput").val(TypeDesc);
		 		$("#updateTypeNameErrInput").html("");
		 		$("#updateTypeDescErrInput").html("");
			}else{
				alert("请选择要修改的权限");
			}
		}
		var typeNamePd=false;//判断权限名是否正确
		//var typeDescPd=false;//判断权限描述是否正确
		$(function(){
			//判断分类名是否正确
			$("#updateTypeNameInput").blur(function(){
				//alert("进入判断分类名是否正确");
				if($(this).val() == ""){
					$("#updateTypeNameErrInput").css({color:"red"}).html("分类名不能为空!");
					typeNamePd=false;
					return;
				}else {
					var typeName = $(this).val();
					//alert("传的参数为="+authName);
					$.ajax({
						url:"${pageContext.request.contextPath}/proType/isTypeName.action",
						data:{typeName:typeName},
						type:"POST",
						dataType:"json",
						success:function(data){
							if (data.pd === "Y") {
								$("#updateTypeNameErrInput").css({color:"green"}).html("分类名可用!");
								typeNamePd=true;
							}else if(data.pd === "N"){
								$("#updateTypeNameErrInput").css({color:"red"}).html("分类名不可用!");
								typeNamePd=false;
							}
						},
						error: function(data){
							console.log("服务器异常");
							typeNamePd=false;
						}
					});
				}
			});
			$("#updateTypeNameInput").focus(function(){
				$("#updateTypeNameErrInput").html("");
			});
		});
		//点击提交执行的方法
		function updateAuth(){
			var typeId=$("#typeIdInputCh").val();
			$("#typeIdInput").val(typeId);
			var updateSpecIdsPd = false;
			$(".specidsInput").each(function(){
				if($(this)[0].checked){
					$("#updateSpecidsInputErrInput").html("");
					updateSpecIdsPd = true;
					//console.log("有选中checkBox");
					return false;
				}else{
					//console.log("无选中checkBox");
					$("#updateSpecidsInputErrInput").css({color:"red"}).html("至少选择一个特性");
					updateSpecIdsPd = false;
				}
			});
      		if(!!typeId){
      			//alert("将修改的值传入后台");
      			$("#updateTypeNameInput").blur();
				if(typeNamePd  && updateSpecIdsPd){
					$(".update-form").attr("action","${pageContext.request.contextPath}/proType/updateShopType.action");
					$(".update-form").submit();
				}else{
					showTips("请完善信息! !");
				}
		    }else{
		    	alert("请选择要修改的分类");
		    } 
		}
//******************************删除权限***************************************************************************		
		/* $(".delete-auth-submit").click(function(){ */
		 function deleteAuth(){
      		var authId =Id;
      		//alert("获取要删除的authId="+Id);
      		if(!!authId){
      			$("#input1").val(authId);
      			$("#fromBd").attr("action","${pageContext.request.contextPath}/AuthManage1/deleteAuth.action");
      			$("#fromBd").submit();
		    }else{
		    	alert("请选择要删除的权限");
		    }
  		}
//******************************恢复权限***************************************************************************		
  		/*恢复权限
  		 */
  	function reinAuth(){
		var authId =Id;
		//alert("恢复的id="+authId);
      	if(!!authId){
     		$("#input1").val(authId);
 			$("#fromBd").attr("action","${pageContext.request.contextPath}/AuthManage1/recoverAuth.action");
 			$("#fromBd").submit();
	    }else{
	    	alert("请选择要恢复的权限");
	    }
	}
  		
    </script>
</head>

<body>
	<c:if test="${empty USER }">
	<c:redirect url="/pages/login.jsp"></c:redirect>
	</c:if>
	<!-- 头部 -->
	<jsp:include page="header.jsp" />
	<div class="container-fluid" style="margin-top: 30px;">
		<div class="row">
			<div class="col-sm-3 col-md-2 sidebar">
				<jsp:include page="navibar.jsp" />
			</div>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<h1 class="page-header">商品分类列表</h1>
				<div class="row placeholders">
					<!--添加分类表单 start-->
					<div>
						<button type="button" class="btn btn-default add-button-form"
							data-toggle="modal" data-target="#add-proType-div"
							style="width: 100px;">添加分类
						</button>
						<button type="button" class="btn btn-default xiugai show-add-form" 
							style="width:100px;display: none;"data-toggle="modal" onclick="updateClick()"
							data-target="#update-proType-form-div">修改分类
						</button>
						<!-- <button type="button" style="width:100px;display: none;" 
							class="btn btn-primary huifu" onclick="reinAuth()">恢复分类
						</button> -->
						<button type="button" style="width:100px;display: none;" 
							class="btn btn-primary shanchu" onclick="deleteAuth()">删除分类
						</button>
						<form id="fromBd" method="post">
							<input id="input1" name="input1" style="display: none;">
						</form>	
						
							
						<!-- 更新分类 -->
						<div class="modal fade " id="update-proType-form-div" tabindex="-1"
							role="dialog" aria-labelledby="mySmallModalLabel">
							<div class="modal-dialog modal-md" role="document">
								<div class="modal-content" style="margin-left: 190px; margin-right: 51px;">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<h4 class="role-form-title">更新分类</h4>
									</div>
									<div class="modal-body">
										<form class="update-form" method="Post">
											<div class="update-form-div">
												<label for="authIdInput">分类id：</label> 
												<input type="text" name="typeIdCh" disabled="disabled" 
												class="form-control" id="typeIdInputCh">
												<input type="text" name="typeId" style="display: none;" 
												class="form-control" id="typeIdInput">
											</div>
											<div >
												<label for="updateTypeNameInput">分类名称：</label><label class="qingkong" style="margin-left: 100px;" id="updateTypeNameErrInput"></label><br/>
												<input type="text" name="typeName" class="form-control delInput" id="updateTypeNameInput" placeholder="分类名称">
											</div>
											<div >
												<label for="updateTypeDescInput">分类描述：</label><label class="qingkong" style="margin-left: 100px;" id="updateTypeDescErrInput"></label><br/>
												<input type="text" name="typeDesc" class="form-control delInput" id="updateTypeDescInput" placeholder="分类描述">
											</div>
											<div class="updateSpecidsDiv">
												<label for="specidsInput">分类特性：</label><label class="qingkong" style="margin-left: 100px;" id="updateSpecidsInputErrInput"></label><br/>
					                        	<c:forEach items="${shopTypeSpecIds }" var="spcIds">
					                        		<input class="specidsInput" type="checkbox" name="specids" value="${spcIds.spcId }" />${spcIds.spcName}&emsp;&emsp;&emsp;&emsp;
					                            </c:forEach>
											</div>
										</form>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default"
											data-dismiss="modal">取消</button>
										<button type="button" class="btn btn-primary button-updateProType-submit"
											id="checkon" onclick="updateAuth()">提交</button>
									</div>
								</div>
							</div>
						</div>
						<!-- 恢复权限 -->
						<%-- <div class="modal fade " id="rein-auth-form-div" tabindex="-1"role="dialog" aria-labelledby="mySmallModalLabel">
							<div class="modal-dialog modal-md" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<h4 class="role-form-title">恢复权限</h4>
									</div>
									<div class="modal-body">
										<c:forEach items="${auth0}" var="auth0">
										<div><input type="checkbox" name="authId" value="${auth0.authId}"/>${auth0.authName}</div>
										</c:forEach>
										<button type="button" style="width:100px;" class="btn btn-primary" data-dismiss="modal" class="btn btn-default">取消</button>
										<button type="button" style="width:100px;" class="btn btn-primary" onclick="reinAuth()">提交</button>
									</div>
								</div>
							</div>
						</div> --%>
				</div>
				<!-- 添加分类 -->
				<div class="modal fade " id="add-proType-div" tabindex="-1"
					role="dialog" aria-labelledby="mySmallModalLabel">
					<div class="modal-dialog modal-md" role="document">
						<div class="modal-content" style="margin-left: 190px; margin-right: 51px;">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
								<h4 class="role-form-title">添加商品分类</h4>
							</div>
							<div class="modal-body">
								<form class="add-proType-form" method="post">
									<!-- <input type="text" name="authId" class="form-control" id="authIdInput"> -->
									<div >
										<label for="addTypeNameInput">分类名称：</label><label class="qingkong" style="margin-left: 100px;" id="addTypeNameErrInput"></label><br/>
										<input type="text" name="typeName" class="form-control delInput" id="addTypeNameInput" placeholder="分类名称">
										<!-- 分类id -->
										<!-- <input type="text" name="authId"  id="addAuthIdInput" style="display: none;"> -->
										<!-- 分类父id -->
										<input type="text" name="parentId"  id="addParentIdInput" style="display: none;">
									</div>
									<div >
										<label for="addTypeDescInput">分类描述：</label><label class="qingkong" style="margin-left: 100px;" id="addTypeDescErrInput"></label><br/>
										<input type="text" name="typeDesc" class="form-control delInput" id="addTypeDescInput" placeholder="分类描述">
									</div>
									<div class="specidsDiv">
										<label for="specidsInput">分类特性：</label><label class="qingkong" style="margin-left: 100px;" id="addSpecidsInputErrInput"></label><br/>
			                        	<c:forEach items="${shopTypeSpecIds }" var="spcIds">
			                        		<input class="specidsInput" type="checkbox" name="specids" value="${spcIds.spcId }" />${spcIds.spcName}&emsp;&emsp;&emsp;&emsp;
			                            </c:forEach>
			                            <!-- <input style="display: none;" type="text" name="roleIds" value="" class="form-control " id="roleIds" > -->
									</div>
								</form>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
								<button type="button" class="btn btn-primary add-proType-submit" id="add-proType-submit" onmouseup="addProTypeSubmit()">提交</button>
							</div>
						</div>
					</div>
				</div>
			</div>
					
					<!--添加权限表单 end-->
					<div class="space-div"></div>

					<div class="zTreeDemoBackground left">
						<ul id="treeDemo" class="ztree" style="width:1024px;"></ul>
					</div>
					<div class="space-div"></div>
																
				</div>
			</div>
		</div>
	<!-- </div> -->

	<!-- 提示框 -->
	<!-- <div class="modal fade" id="op-tips-dialog" tabindex="-1" role="dialog"
		aria-labelledby="mySmallModalLabel">
		<div class="modal-dialog modal-sm" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">提示信息</h4>
				</div>
				<div class="modal-body" id="op-tips-content"></div>
			</div>
		</div>
	</div> -->
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

	<script
		src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>

</body>
</html>
