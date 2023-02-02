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
	
	/* 목록 */
	function fn_search(){
		var reqUrl = "/la/youtube/listYoutube";
		$("#frmUTub").attr("action", reqUrl);
		$("#frmUTub").attr("target","_self");
		$("#frmUTub").submit();
	}
	
	/* 수정 화면 */
	function fn_update(){
		var reqUrl = "/la/youtube/goUpdateYoutube";
		$("#frmUTub").attr("action", reqUrl);
		$("#frmUTub").attr("target","_self");
		$("#frmUTub").submit();
	}
	
</script>
<form id="frmUTub" name="frmUTub" method="post" enctype="multipart/form-data" >
	<input type="hidden" id="menuId" name="menuId" value="<c:out value='${menuId}'/>">
	<input type="hidden" id="youtubeId" name="youtubeId" value="${result.youtubeId }"/>
	<div class="title-name-1">카테고리 등록</div>
	<table border="0" cellpadding="0" cellspacing="0" class="view-2">
		<tbody>
			<tr>
				<th>컨텐츠 명</th>
				<td colspan="3">${result.youtubeTitle }</td>
			</tr>
			<tr>
				<th>수정일</th>
				<td>${result.updateDate }</td>
				<th>수정자</th>
				<td>${result.updateUser }</td>
			</tr>
			<tr>
				<th>유튜브 URL</th>
				<td colspan="3">
					<a href="${result.youtubeUrl }" target="_blank">${result.youtubeUrl }</a>
				</td>
			</tr>
			<tr>
				<th>유튜브 썸네일</th>
				<td colspan="3">
					<c:choose>
						<c:when test="${not empty result.youtubeFileId}" >
							<img src="/commbiz/youtube/getImage.do?youtubeFileId=${result.youtubeFileId}" >
						</c:when>
						<c:otherwise>
							<img src="http://img.youtube.com/vi/${fn:split(result.youtubeUrl,'=')[1]}/mqdefault.jpg"/>
						</c:otherwise>
						</c:choose>
				</td>
			</tr>
			<tr>
				<th>유튜브 미리보기</th>
				<td colspan="3">
					<iframe width="90%" height="500" src="https://www.youtube.com/embed/${fn:split(result.youtubeUrl,'=')[1]}"></iframe>
				</td>
			</tr>
			<tr>	
				<th>컨텐츠 소개</th>
				<td colspan="3" style="overflow: -webkit-paged-y; padding:50px 70px; line-height:25px;">
					<c:out value="${result.youtubeDesc}" escapeXml="false"/>
				</td>
			</tr>
		</tbody>
	</table>
</form>

<div class="page-btn">
	<a href="javascript:void(0);" onclick="fn_update();">수정</a>
	<a href="javascript:void(0);" onclick="fn_search();">목록</a>
</div>