<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="${pageContext.request.contextPath}/static/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Custom styles for this template -->
<link href="${pageContext.request.contextPath}/static/css/layout.css"
	rel="stylesheet">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
	<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/ueditor.all.min.js"> </script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/lang/zh-cn/zh-cn.js"></script>
	
</head>

<body>
	<script
		src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
	<jsp:include page="header.jsp" />
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 sidebar">
				<jsp:include page="navibar.jsp" />
			</div>
		</div>
		<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
			<div id="add-product-form">
				<div role="document">
					<!-- class="modal-dialog modal-sm"  -->
					<div>
						<!--  class="modal-content" -->




						<div class="modal-body"><!--  -->
							<form  enctype="multipart/form-data" class="user-form"
								method="post"
								action="${pageContext.request.contextPath}/productList/addPic.action"
								onsubmit="return checkProInfo()">

								<div class="form-group">
									<label for="proName">商品名</label> <input type="text"
										name="proName" value="" class="form-control" id="proName"
										placeholder="商品名"> <label id="vertifyProName"></label>
								</div>

								<div class="form-group">
									<label for="inventory">存货</label> <input type="number"
										name="inventory" value="" class="form-control" id="inventory"
										placeholder="存货"> <label id="vertifyInventory"></label>
								</div>


								<div class="form-group">
									<label for="brand">品牌</label> 
									<select id="brandId" name="brandId">
										<option value="" style="display: none">请选择</option>
										<c:forEach var="brand" items="${BRANDS }">
											<option value="${brand.brandId}">${brand.brandName }</option>
										</c:forEach>
									</select>
								</div>

								<div class="form-group" id="SeclectProType">
									<label for="proType">商品类型</label><br />
									<button type="button">点击此处选择商品类型</button>
									<br /> <input id="proType" value="点击此处" readonly /> <input
										type="number" name="typeId" id="proTypeId" value=""
										style="display: none" />
									<!--style="display:none"  -->
								</div>

								<div class="form-group">
									<label>产地</label> <select id="proAddress" name="proAddress">
										<option value="" style="display: none">请选择</option>
										<c:forEach var="address" items="${ADDRESSES }">
											<option value="${address.addrId }"
												${NewProduct.proAddress == address.addrId ?"selected":"" }>${address.addrInfo }</option>
										</c:forEach>
									</select>
								</div>

								<div class="form-group">
									<label for="proSupply">供货商</label> 
									<select id="proSupply" name="proSupply">
										<option value="" style="display: none">请选择</option>
										<c:forEach var="supply" items="${SUPPLIES }">
											<option value="${supply.supplyId}">${supply.supplyName}</option>
										</c:forEach>
									</select>
								</div>
								<div class="form-group">
									<label for="proStartName">生产日期</label> <input type="date"
										name="proStartDate" value="" class="form-control"
										id="proStartDate"> <label id="vertifyProStartName"></label>
								</div>
								<div class="form-group">
									<label for="proEndDate">过期日期</label> <input type="date"
										name="proEndDate" value="" class="form-control"
										id="proEndDate"> <label id="vertifyUsername"></label>
								</div>
								
								
								
								<label>商品描述</label> 
								<div class="modal-footer">
									<input type="text" value="" name="proInfo" id="proInfo"/>
									<script id="editor" type="text/plain" style="width:1024px;height:500px;"></script>
								</div>
								<label>添加图片</label> 
									   <input class="addPic" type="file" name=files /> 
									   <input class = "addPic" type="file" name="files" style="display:none"/>
				                       <input class = "addPic" type="file" name="files" style="display:none"/>
				                       <input class = "addPic" type="file" name="files" style="display:none"/>
				                       <input class = "addPic" type="file" name="files" style="display:none"/> 
								<div class="modal-footer">
									<button type="button"
										class="btn btn-default cancel-add-user-submit"
										data-dismiss="modal">取消</button>
									<input type="submit" class="btn btn-primary" id="addNewPro"
										value="添加">
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>


		</div>

	</div>
	<script type="text/javascript">

    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue = UE.getEditor('editor');


    function isFocus(e){
        alert(UE.getEditor('editor').isFocus());
        UE.dom.domUtils.preventDefault(e)
    }
    function setblur(e){
        UE.getEditor('editor').blur();
        UE.dom.domUtils.preventDefault(e)
    }
    function insertHtml() {
        var value = prompt('插入html代码', '');
        UE.getEditor('editor').execCommand('insertHtml', value)
    }
    
    function createEditor() {
        enableBtn();
        UE.getEditor('editor');
    }

    function getContent() {
        var arr = [];
        arr.push("使用editor.getContent()方法可以获得编辑器的内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('editor').getContent());
        alert(arr.join("\n"));
    }
    function getPlainTxt() {
        var arr = [];
        arr.push("使用editor.getPlainTxt()方法可以获得编辑器的带格式的纯文本内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('editor').getPlainTxt());
        alert(arr.join('\n'))
    }
    function setContent(isAppendTo) {
        var arr = [];
        arr.push("使用editor.setContent('欢迎使用ueditor')方法可以设置编辑器的内容");
        UE.getEditor('editor').setContent('欢迎使用ueditor', isAppendTo);
        alert(arr.join("\n"));
    }


    function getText() {
        //当你点击按钮时编辑区域已经失去了焦点，如果直接用getText将不会得到内容，所以要在选回来，然后取得内容
        var range = UE.getEditor('editor').selection.getRange();
        range.select();
        var txt = UE.getEditor('editor').selection.getText();
        alert(txt)
    }

    function getContentTxt() {
        var arr = [];
        arr.push("使用editor.getContentTxt()方法可以获得编辑器的纯文本内容");
        arr.push("编辑器的纯文本内容为：");
        arr.push(UE.getEditor('editor').getContentTxt());
        alert(arr.join("\n"));
    }

</script>
	<script type="text/javascript">
		//提交按钮
		
		function checkProInfo() {
			
			
			var content = ue.getPlainTxt();
			//把ueditor的内容写入input
			  //$(function(){
				$("#proInfo").val(content);
				 var val = $("#proInfo").val();
				var proName = $("#proName").val();
				//存货
				var inventory = $("#inventory").val();
				//生产日期
				var proStartDate = $("#proStartDate").val().replace(/-/g, "/");
				//过期日期
				var proEndDate = $("#proEndDate").val().replace(/-/g, "/");
				//品牌
				var brandId = $("#brandId").val();
				 
				//var brandName = ${"#NewProduct.brand.brandName"};
				//商品类型ID
				var NewProTypeId = "$(typeId).val()";
				//var NewProTypeName = "${NewProduct.proType.typeName}";
				//产地
				var proAddress = $("#proAddress").val();
				//供货商
				var proSupply = $("#proSupply").val(); 
			//})  
			//商品名称
			if (!proName || !inventory || !proStartDate || !proEndDate
					|| !brandId || !NewProTypeId || !NewProTypeName
					|| !proAddress || !proSupply) {
				if (proEndDate < proStartDate) {
					alert("注意日期填写规则。");
					return false;
				}
				alert("请填写完整。");
				return false;
				
			} else {
				return true;
			} 
				 
		}

		$(function() {
			$("#SeclectProType")
					.click(
							function() {
								var proName = $("#proName").val();
								var inventory = $("#inventory").val();
								var proStartDate = $("#proStartDate").val();
								var proEndDate = $("#proEndDate").val();
								//品牌
								var brandId = $("#brandId").val();
								var brandName = $("#brandId").text();
								//产地
								var proAddress = $("#proAddress").val();
								//alert("proAddress:"+proAddress);
								//供货商
								var proSupply = $("#proSupply").val();
								//alert("proAddress"+proAddress+",proSupply:"+proSupply);
								location.href = "${pageContext.request.contextPath}/productList/addNewProType.action?proName="
										+ proName
										+ "&inventory="
										+ inventory
										+ "&proAddress="
										+ proAddress
										+ "&proStartDate="
										+ proStartDate
										+ "&proEndDate="
										+ proEndDate
										+ "&brandId="
										+ brandId
										+ "&brandName="
										+ brandName + "&proSupply=" + proSupply;
							});

			//参数回显
			var newProduct = "${NewProduct}";
			//分类名称   			
			var NewProTypeName = "${NewProduct.proType.typeName}";
			var NewProTypeId = "${NewProduct.proType.typeId}";
			$("#proType").val(NewProTypeName);
			$("#proTypeId").val(NewProTypeId);
			//商品名称
			var proName = "${NewProduct.proName}";
			$("#proName").val(proName);
			//存货
			var inventory = "${NewProduct.inventory}";
			$("#inventory").val(inventory);
			//品牌
			var brandName = "${NewProduct.brand.brandName}"
			var brandId = "${NewProduct.brandId}";
			$("#brandId option").each(function(index, e) {
				if (e.value == brandId) {
					$(e).attr("selected", "true");
				}
			});
			//产地
			var proAddress = "${NewProduct.proAddress}";
			//console.log("aasdasd:"+proAddress);
			/* $("#proAddress option").each(function(index,e){
				console.log(e.value);
				if (e.value == proAddress) {
				$(e).attr("selected","true");
			}
			}); */

			//供货商
			var proSupply = "${NewProduct.proSupply}"
			$("#proSupply option").each(function(index, e) {
				if (e.value == proSupply) {
					$(e).attr("selected", "true");
				}
			});

			//增加图片input框
			$(".addPic").change(function() {
				
				//alert($(this).val());
				$(".addPic").each(function(index, e) {
					if (null != e.value  && ""!= e.value) {
						$(this).next().css("display", "");
						
					}
					return;
				});

			});

		})
	</script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/static/js/jquery.cookie.js"></script>
</body>
</html>