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
								action="${pageContext.request.contextPath}/productList/confirmUpdateProductInfo.action"
								onSubmit="return checkProInfo()">

								<div class="form-group">
									<label for="proName">商品名</label> 
									<input name="proId" style="display:none" id="proId">
									<input type="text" name="proName" value="${PRODUCT.proName }" class="form-control" id="proName"
										placeholder="商品名"> <label id="vertifyProName"></label>
								</div>

								<div class="form-group">
									<label for="inventory">存货</label> 
									<input type="number" name="inventory" value="" class="form-control" id="inventory"
										placeholder="存货"> <label id="vertifyInventory"></label>
								</div>


								<div class="form-group">
									<label for="brand">品牌</label> 
									<select id="brandId" name="brandId">
										<option value="" style="display: none">请选择</option>
										<c:forEach var="brand" items="${BRANDS }">
											<option value="${brand.brandId}" ${PRODUCT.brandId == brand.brandId ?'selected':''}>${brand.brandName }</option>
										</c:forEach>
									</select>
								</div>

								<div class="form-group" id="SeclectProType">
									<label for="proType">商品类型</label><br />
									<button type="button">点击此处选择商品类型</button>
									<br /> 
									<input id="proType" value=${ PRODUCT.typeId} /> 
									<input type="number" name="typeId" id="proTypeId" value="${ PRODUCT.typeId}"
										style="display: none" />
									<!--style="display:none"  -->
								</div>

								<div class="form-group">
									<label>产地</label> <select id="proAddress" name="proAddress">
										<option value="" style="display: none">请选择</option>
										<c:forEach var="address" items="${ADDRESSES }">
											<option value="${address.addrId }"
												${PRODUCT.proAddress eq address.addrId ?'selected':''}>${address.addrInfo }</option>
										</c:forEach>
									</select>
								</div>

								<div class="form-group">
									<label for="proSupply">供货商</label> 
									<select id="proSupply" name="proSupply">
										<option value="" style="display: none">请选择</option>
										<c:forEach var="supply" items="${SUPPLIES }">
											<option value="${supply.supplyId}"
											${PRODUCT.proSupply == supply.supplyId ?'selected':''}>${supply.supplyName}</option>
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
								<%-- <div class="form-group">
								<c:forEach items="${Product.proPic.split(',')}" var="src">${src}
		                			<img alt="" src="${pageContext.request.contextPath}/${src} " width="50px" height="50px">
	                			</c:forEach>
								</div> --%>
								<label>修改图片2</label>
								 <c:forEach items="${PRODUCT.proPic.split(',')}" var="src">
		                			<img alt="" src="${pageContext.request.contextPath}/${src} " width="50px" height="50px">
	                			</c:forEach>
								<%-- <img alt="" src="${pageContext.request.contextPath}/${product.proPic}"> --%>
								   <input class="addPic" type="file" name="files" /> 
								   <input class = "addPic" type="file" name="files" style="display:none"/>
			                       <input class = "addPic" type="file" name="files" style="display:none"/>
			                       <input class = "addPic" type="file" name="files" style="display:none"/>
			                       <input class = "addPic" type="file" name="files" style="display:none"/> 
								<div class="modal-footer">
									<button type="button"
										class="btn btn-default cancel-add-user-submit"
										data-dismiss="modal">取消</button>
									<input type="submit" class="btn btn-primary" id="updatePro"
										value="确认修改">
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>


		</div>

	</div>
	<script type="text/javascript">
		$(function(){
			var inventory = "${PRODUCT.inventory}";
			 $("#inventory").val(inventory);
			var proId = "${PRODUCT.proId}";
			 $("#proId").val(proId);
			 $(".addPic").change(function() {
					
					//alert($(this).val());
					$(".addPic").each(function(index, e) {
						if (null != e.value  && ""!= e.value) {
							$(this).next().css("display", "");
							
						}
						return;
					});

				});
			
			
			
			
		});
	</script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/static/js/jquery.cookie.js"></script>
</body>
</html>