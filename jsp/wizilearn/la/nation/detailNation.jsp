<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags" %><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script type="text/javascript">
	function fn_update(){
		var reqUrl = "/la/nation/goUpdateNation";
		$("#frmNation").attr("action", reqUrl);
		$("#frmNation").attr("target","_self");
		$("#frmNation").submit();
	}
	/* 리스트 조회 */
	function fn_search(){
		var reqUrl = "/la/nation/listNation";
		$("#frmNation").attr("action", reqUrl);
		$("#frmNation").attr("target","_self");
		$("#frmNation").submit();
	}
</script>
<form id="frmNation" name="frmNation" method="post">
	<input type="hidden" id="menuId" name="menuId" value="<c:out value='${menuId}'/>"> 
	<input type="hidden" id="natCd" name="natCd" value="${result.natCd }"/>
	<div class="title-name-1">국가관리 상세</div>
	<table border="0" cellpadding="0" cellspacing="0" class="view-2">
		<tbody>
			<tr>
				<th>대륙구분</th>
				<td>${result.partCdName}</td>
			</tr>
			<tr>
				<th>국가구분</th>
				<td>${result.typeCdName }</td>
			</tr>
			<tr>
				<th>국가명(영문)</th>
				<td>${result.natName}</td>
			</tr>
			<tr>
				<th>국가명(국문)</th>
				<td>${result.natNameKr}</td>
			</tr>
			<tr>
				<th>정렬순서</th>
				<td>${result.natStep}</td>
			</tr>
			<tr>
				<th>배점</th>
				<td>${result.natScore}</td>
			</tr>		 
			<tr>
				<th>상태</th>
				<td>
					<c:choose>
						<c:when test="${result.useYn == 'Y'}">
							공개
						</c:when>
						<c:otherwise>
							비공개
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</tbody>
	</table>
</form>

<div class="page-btn">
	<a href="#!" onclick="fn_update();">수정</a>
	<a href="#!" onclick="fn_search();">목록</a>
</div>