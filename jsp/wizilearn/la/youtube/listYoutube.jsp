<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags" %><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script type="text/javascript">
	$(document).ready(function() {
		
	});
	
	/* 리스트 조회 */
	function fn_search( param1 ){
		$("#pageIndex").val( param1 );
		$("#pageSize").val($("#searchPageSize").val());
		var reqUrl = "/la/youtube/listYoutube";
		$("#frmUTub").attr("action", reqUrl);
		$("#frmUTub").attr("target","_self");
		$("#frmUTub").submit();
	}
	
	/* 작성 화면 */
	function fn_write(){
		var reqUrl = "/la/youtube/goInsertYoutube";
		$("#frmUTub").attr("action", reqUrl);
		$("#frmUTub").attr("target","_self");
		$("#frmUTub").submit();
	}
	
	/* 상세 화면 */
	function fn_detail(param){
		$("#youtubeId").val(param);
		var reqUrl = "/la/youtube/goDetailYoutube";
		$("#frmUTub").attr("action", reqUrl);
		$("#frmUTub").attr("target","_self");
		$("#frmUTub").submit();
	}
	
	/* 수정 화면 */
	function fn_update(param1,param2){
		var reqUrl = "/la/youtube/goUpdateYoutube";
		$("#youtubeId").val(param1);
		$("#frmUTub").attr("action", reqUrl);
		$("#frmUTub").attr("target","_self");
		$("#frmUTub").submit();
	}
	
	/* 삭제 */
	function fn_delete(param1,param2,param3){
		if(param2 == "url"){
			var reqUrl = "/la/youtube/updateYoutube";
		}else{
			var reqUrl = "/la/youtube/deleteYoutubeVideo";
		}
		
		if(confirm("해당 컨텐츠를 삭제 하시겠습니까?")){
			$("#youtubeId").val(param1);
			$("#youtubeUrl").val(param3);
			$("#deleteYn").val("Y");
			$("#frmUTub").attr("action", reqUrl);
			$("#frmUTub").attr("target","_self");
			$("#frmUTub").submit();
		}
	}
	
</script>

<form id="frmUTub" name="frmUTub" method="post" enctype="multipart/form-data">
	<input type="hidden" id="menuId" name="menuId" value="<c:out value='${menuId}'/>"> 
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}" />
	<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
	<input type="hidden" id="deleteYn" name="deleteYn" value="N"/>
	<input type="hidden" id="youtubeId" name="youtubeId" value=""/>
	<input type="hidden" id="youtubeUrl" name="youtubeUrl" value=""/>
	
	<div class="title-name-1">검색 조건</div>
	
	<ul class="search-list-1" style="margin-top:7px;">
		<li>
			<span style="width: 10%;">콘텐츠 명</span>
			<input type="text" name="searchKeyword" id="searchKeyword" value="${comContentVO.searchKeyword }" style="width:300px;" />
		</li>
	</ul>
			
	<div class="search-btn-area"><a href="#" onclick="javascript:fn_search(1);">조회</a></div>
	
	<ul class="board-info">
		<li class="info-area">
			<span>전체 : </span> <c:out value="${totalCount}" /> 건<br/>
		</li>
		<li class="btn-area">
			<select name="searchPageSize" id="searchPageSize" title="목록 갯수 설정하기" onchange="javascript:fn_search(1)">
				<option value="10" <c:if test="${pageSize=='10' }" > selected</c:if> >10 개</option>
				<option value="20" <c:if test="${pageSize=='20' }" > selected</c:if> >20 개</option>
				<option value="30" <c:if test="${pageSize=='30' }" > selected</c:if> >30 개</option>
				<option value="50" <c:if test="${pageSize=='50' }" > selected</c:if> >50 개</option>
			</select>
		</li>
	</ul>
</form>

<table  border="0" cellpadding="0" cellspacing="0" class="list-1">
	<thead>
	<tr>
		<th width="5%">번호</th>
		<th>콘텐츠명</th>
		<th width="25%">유튜브 URL</th>
		<th width="10%">등록일</th>
		<th width="10%">관리</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<tr>
			<td><c:out value="${totalCount - ((pageIndex-1) * pageSize + status.count)+1}"/></td>
			<td>
				<a href="javascript:void(0);" onclick="fn_detail('${result.youtubeId}');">
					<c:out value="${result.youtubeTitle }"/>
				</a>
			</td>
			<td>
				<a href="${result.youtubeUrl}" target="_blank">
					<c:out value="${result.youtubeUrl }"/>
				</a>
			</td>
			<td><c:out value="${result.insertDate }"/></td>
			<td>
				<a href="javascript:void(0);" onclick="fn_update('${result.youtubeId}','${result.youtubeType}','${result.youtubeUrl }');" class="btn-1">수정</a>
				<a href="javascript:void(0);" onclick="fn_delete('${result.youtubeId}','${result.youtubeType}','${result.youtubeUrl }');" class="btn-2">삭제</a>
			</td>
		</tr>
	</c:forEach>
	<c:if test="${fn:length(resultList) == 0}">
			<tr>
				<td colspan="5">
					조회된 데이터가 없습니다.
				</td>
			</tr>
	</c:if>
	</tbody>
</table>

<div class="page-btn">
	<a href="javascript:void(0);" onclick="fn_write();">등록</a>
</div>

<div class="page-num">
	<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" /> 
</div><!-- E : page-num -->