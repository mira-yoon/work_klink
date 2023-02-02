<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags" %><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><link href="${contextRoot}/css/jquery.treemenu.css" rel="stylesheet" type="text/css" />
<style>
.tree { background-color:#e7f4be; color:#0f1301;}
.tree li,
.tree li > a,
.tree li > span {
    padding-top: 4pt;
    padding-bottom: 4pt;
    padding-left: 10pt;
    padding-right: 10pt;
    border-radius: 7px;
}

.tree li a {
   color:#0f1301;
    text-decoration: none;
    line-height: 20pt;
    border-radius: 7px;
}

.tree li a:hover {
    background-color: #34BC9D;
    color: #fff;
}

.active {
    background-color: #34495E;
    color: white;
}

.active a {
    color: #fff;
}

.tree li a.active:hover {
    background-color: #34BC9D;
}
</style>
<script src="${contextRoot}/js/jquery.treemenu.js"></script> 
<script>
<!--
function selectMenu(menuId){
		
	var reqUrl = "/la/menu/listMenuTree.json";
	var param = {"menuId":menuId}; //  $("#searchFrm").serializeArray();
	

		$.ajax({
			url:reqUrl,
			type:"POST",
			data:param,
			success:function(data){
				var map = data.records;				
				
				$('#menuId').val(map.menuId);
				$('#menuTitle').val(map.menuTitle);				

				$('#menuDepth').val(map.menuDepth);
				$('#upMenuId').val(map.upMenuId);
				$('#upMenuTitle').val(map.upMenuTitle);
				
				$('#menuStatus').val(map.menuStatus);				
				$('#menuOrder').val(map.menuOrder); 
				$('#menuUrl').val(map.menuUrl);
				$("select[name=menuViewTypeCode] option[value="+map.menuViewTypeCode+"]").attr("selected",true);
				 
			},error:function(xhr,status,error){
				alert("시스템관리자에게 문의하세요.");
			}
		});

}

/*  조회 */
function fn_search(){
	
	var reqUrl =  "/la/menu/listMenu";
	$("#searchFrm").attr("target","_self");
	$("#searchFrm").attr("action", reqUrl);
	$("#searchFrm").submit();
}
/* 최상위메뉴등록 */
function fn_Root(){
	popOpenWindow
	$("#upMenuId").val("TOP");
	$("#upMenuTitle").val("최상위");
	$("#menuDepth").val("1");
	
}
$(function(){

        $(".tree").treemenu({delay:300}).openActive();

        $(".treemenu").show();

});

/*  팝업조회 */
function fn_popup(){
 
	popOpenWindow("", "popSearchMenu", 470, 650);
	
	var reqUrl =  "/la/menu/popupMenu";
	$("#searchFrm").attr("target","popSearchMenu");
	$("#searchFrm").attr("action", reqUrl);
	$("#searchFrm").submit();
}
/* 메뉴저장 */
function fn_save(){
	if (fn_formValidate()) {
		var reqUrl =  "/la/menu/insertMenu";
		$("#frmHtml").attr("target","_self");
		$("#frmHtml").attr("action", reqUrl);
		$("#frmHtml").submit();
	}
}

function fn_formValidate() {
	if( !$("#menuTitle").val() ){
		alert("메뉴명을 입력하세요.");
		return false;
	}
	
	if( !$("#upMenuId").val() ){
		alert("상위메뉴를 선택하세요.");
		return false;
	}
		
	return true;
}

/* 초기화 */
function fn_reset(){
	$('#menuId').val("");
	$('#menuTitle').val("");				

	$('#menuDepth').val("");
	$('#upMenuId').val("");
	$('#upMenuTitle').val("");
	
	$('#menuStatus').val("");				
	$('#menuOrder').val(""); 
	$('#menuUrl').val("");
}
//-->
</script> 				 
						<div>
										
									<form id="searchFrm" name="searchFrm" method="post" action="">
										<ul  class="title-name-1" style="margin-bottom: 20px;">
											<li class="num">
										<input type="hidden" name="menuId"  value="${menuId}"/>
								사이트구분 : <select id="searchMenuType" name="searchMenuType" style="width: 180px; margin-right: 10px;" onchange="javascript:fn_search();">
												<option value="LA" <c:if test="${menuVO.searchMenuType eq 'LA' }" >selected="selected"</c:if>>관리자사이트${menuVO.menuType}</option>
												<option value="LU" <c:if test="${menuVO.searchMenuType eq 'LU' }" >selected="selected"</c:if>>이용자사이트${menuVO.menuType}</option>
											</select>
											</li>
										</ul>
									</form>
							<div  style="float:left;width:400px;">											
									 <ul class="tree" >
												<li>
													 <span> 메인</span>
															<c:set var="upperMenuNo" value="TOP"/>
															<c:set var="menuLevel" value="1"/>
															<c:set var="menuTypeNum" value="1"/>
															<c:set var="key1" value="${ upperMenuNo}_${menuLevel}"/>
															<c:if test="${not empty menuList1[key1]}">
															<ul>
																<c:forEach var="menu1" items="${menuList1[key1]}" varStatus="status">
									
																<li>
																	<!-- S : depth-1 -->
																	 
																	<c:set var="menuTypeNum" value="${menuTypeNum+1}"/>
																	 
																		 <c:choose>
																				<c:when test="${0 eq menu1.isLeafMenu}"><a id="a_${menu1.menuId }" href="#" >${menu1.menuTitle }</a></c:when>
																				<c:otherwise><a id="a_${menu1.menuId }" href="#" onclick="javascript:selectMenu('${menu1.menuId }' );">${menu1.menuTitle }</a></c:otherwise>
																			</c:choose>
																			<c:set var="key2" value="${ menu1.menuId}_${menu1.menuDepth+1}"/>
																			<c:choose>
																				<c:when test="${not empty menuList1[key2]}">
																				<ul>
																					<c:forEach var="menu2" items="${menuList1[key2]}" varStatus="status2">
																						<li><!-- S : depth-2 -->
																				 				<c:choose>
																									<c:when test="${0 eq menu2.isLeafMenu}"><a id="a_${menu2.menuId }" href="#" >${menu2.menuTitle }</a></c:when>
																									<c:otherwise><a id="a_${menu2.menuId }" href="#" onclick="javascript:selectMenu( '${menu2.menuId }' );">${menu2.menuTitle }</a></c:otherwise>
																								</c:choose> 
																								<c:set var="key3" value="${ menu2.menuId}_${menu2.menuDepth+1}"/>
																								<c:choose>
																									<c:when test="${not empty menuList1[key3]}">
																									<ul>
																									
																										<c:forEach var="menu3" items="${menuList1[key3]}" varStatus="status3">
																											<!-- S : depth-3 -->
																											<li>
																													<c:choose>
																														<c:when test="${0 eq menu3.isLeafMenu}"><a id="a_${menu3.menuId }" href="#" >${menu3.menuTitle }</a></c:when>
																														<c:otherwise><a id="a_${menu3.menuId }" href="#" onclick="javascript:selectMenu('${menu3.menuId }' );">${menu3.menuTitle }</a></c:otherwise>
																													</c:choose>
																													<c:set var="key4" value="${ menu3.menuId}_${menu3.menuDepth+1}"/>
																													<c:choose>
																														<c:when test="${not empty menuList1[key4]}">
																															<ul>
																																<c:forEach var="menu4" items="${menuList1[key4]}" varStatus="status3">
																																	<li><a id="a_${menu4.menuId }" href="#" onclick="javascript:selectMenu( '${menu4.menuId }' );">${menu4.menuTitle }</a></li>
																																</c:forEach>																							
																															</ul>
																														</c:when>
																														<c:otherwise></c:otherwise>
																													</c:choose>
																											 <!-- E : depth-3 -->
																											 </li>
																										</c:forEach>
																									
																									</ul>
																									</c:when>
																									<c:otherwise></c:otherwise>
																								</c:choose>
																						</li><!-- E : depth-2 -->
																					</c:forEach>
																				</ul>
																				</c:when>
																				<c:otherwise></c:otherwise>
																			</c:choose>
																	 </li><!-- E : depth-1 -->
									
																</c:forEach>
																</ul>
															</c:if>
														</li>
									 	</ul>
									</div>
									<div style="float:left;padding-left: 30px;">									 				
										<ul>
									<table border="0" cellpadding="0" cellspacing="0" class="view-2">
								<form id="frmHtml" name="frmHtml" method="post" action="" >									
										<tbody>
											<tr>
												<th>메뉴코드</th>
												<td><input type="text" id="menuId" name="menuId" readonly title="메뉴코드 입력"></td>
											</tr>
											<tr>
												<th>메뉴명<span class="pre"></span></th>
												<td><input type="text" id="menuTitle" name="menuTitle" maxLength="33" title="메뉴명 입력"></td>
											</tr>
											<tr>
												<th>상위메뉴</th>
												<td>
													<input type="hidden" id="menuDepth" name="menuDepth"  >
													<input type="hidden" id="upMenuId" name="upMenuId"  >
													<input type="text" id="upMenuTitle" name="upMenuTitle" readonly  title="상위메뉴 입력">
													<a class="btn" href="#" onclick="javascript:fn_popup();" title="상위메뉴 선택 팝업 열기" style="text-align: center; ">찾기</a>
													<a class="btn" href="#" onclick="javascript:fn_Root();" title="최상위 메뉴">최상위 메뉴</a>
												</td>
											</tr>
											<tr>
												<th>메뉴상태<span class="pre"></span></th>
												<td><input type="text" id="menuStatus" name="menuStatus" dir="rtl" maxLength="3" title="메뉴상태"></td>
											</tr>
											<tr>
												<th>메뉴순서<span class="pre"></span></th>
												<td><input type="text" id="menuOrder" name="menuOrder" dir="rtl" maxLength="3" title="순서 입력"></td>
											</tr>
 
											<tr>
												<th>메뉴타입<span class="pre"></span></th>
												<td>
													<select id="menuType" name="menuType">
														<option value="LA" <c:if test="${menuVO.searchMenuType eq 'LA' }" >selected="selected"</c:if> >관리자사이트</option>
														<option value="LU" <c:if test="${menuVO.searchMenuType eq 'LU' }" >selected="selected"</c:if> >이용자사이트</option>
													</select>													
												</td>
											</tr>
											<tr>
												<th>메뉴유형<span class="pre"></span></th>
												<td>
													<select id="menuViewTypeCode" name="menuViewTypeCode" title="메뉴유형 선택" data-rule-required="true">
														<option value="" >선택</option>
														<option value="2016CCOD0000011">메뉴 노출</option>
														<option value="2016CCOD0000012">메뉴 비노출(페이지:메인,사용자관련등등...)</option>
														<option value="2016CCOD0000013">메뉴 비노출(팝업)</option>
														<option value="2016CCOD0000014">메뉴 비노출(import)</option>
													</select>
												</td>
											</tr>
											<tr>
												<th>메뉴 URL</th>
												<td>
													<input type="text" id="menuUrl" name="menuUrl" style="width: 100%;">
												</td>
											</tr>
											<tr>
												<th>삭제여부<span class="pre"></span></th>
												<td>
													<input type="radio" id="deleteYnY" name="deleteYn" value="Y" ><label for="deleteYnY">Yes</label>
													<input type="radio" id="deleteYnN" name="deleteYn" value="N"  checked><label for="deleteYnN">No</label>
												</td>
											</tr>
											<tr>
												<th>보기여부<span class="pre"></span></th>
												<td>
													<input type="radio" id="showYnY" name="showYn" value="Y"  checked><label for="showYnY">Yes</label>
													<input type="radio" id="showYnN" name="showYn" value="N"><label for="showYnN">No</label>
												</td>
											</tr>
										</tbody>
								</form><!-- E : view-1 --> 										
									</table>
									
										<div class="page-btn">
											<a href="#" onclick="javascript:fn_save();" class="type-1">저장</a>
											<a href="#"  onClick="javascript:fn_reset();">초기화</a>
										</div>
				
				
										</ul>	
</div>
						</div><!-- E : code-box -->
 
 