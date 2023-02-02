<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags" %><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script type="text/javascript">
	$(document).ready(function(){
		
	});
	
	/* 수정화면 */
	function fn_update(){
		var reqUrl = "/la/organization/goUpdateOrganization";
		$("#frmOrganization").attr("action", reqUrl);
		$("#frmOrganization").attr("target","_self");
		$("#frmOrganization").submit();
	}
	/* 삭제 */
	function fn_delete(){
		if(confirm("해당 글을 삭제하시겠습니까?")){
			$("#deleteYn").val("Y");
			var reqUrl = "/la/organization/updateOrganization";
			$("#frmOrganization").attr("action", reqUrl);
			$("#frmOrganization").attr("target","_self");
			$("#frmOrganization").submit();
		}
	}
	/* 리스트 조회 */
	function fn_search(){		 
		var reqUrl = "/la/organization/listOrganization";
		$("#frmOrganization").attr("action", reqUrl);
		$("#frmOrganization").attr("target","_self");
		$("#frmOrganization").submit();
	}
</script>
<form id="frmOrganization" name="frmOrganization" method="post" enctype="multipart/form-data">
	<input type="hidden" id="menuId" name="menuId" value="<c:out value='${menuId}'/>"> 
	<input type="hidden" id="orgCd" name="orgCd" value="${result.orgCd }"/>
	<input type="hidden" id="deleteYn" name="deleteYn" value="N"/>
	<div class="title-name-1">기관관리 상세</div>
	<table border="0" cellpadding="0" cellspacing="0" class="view-2">
		<tbody>
			<tr>
				<th>기관로고</th>
				<td>
					<c:if test="${!empty atchFileVO}">	 
						<img src="/commbiz/atchfle/getImage.do?atchFileId=${atchFileVO.atchFileId }"/>
					</c:if>
				</td>
			</tr>
			<tr>  
				<th>정렬순서</th>
				<td>${result.orgStep}</td>
			</tr>
			<tr>
				<th>기관명</th>
				<td>${result.orgName}</td>
			</tr>
			<tr>
				<th>기관명(전체)</th>
				<td>${result.orgNameFull}</td>
			</tr>
			<tr>  
				<th>기관 홈페이지</th>
				<td>${result.orgUrl }</td>
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
	<a href="#!" onclick="fn_delete();">삭제</a>
	<a href="#!" onclick="fn_search();">목록</a>
</div>