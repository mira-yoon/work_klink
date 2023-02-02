<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags" %><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script type="text/javascript" src="/smarteditor/js/HuskyEZCreator.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
	});	
	/* 수정화면 */
	function fn_update(){
		var reqUrl = "/la/popup/goUpdatePopup";
		$("#frmComPopup").attr("action", reqUrl);
		$("#frmComPopup").attr("target","_self");
		$("#frmComPopup").submit();
	}
	/* 삭제 */
	function fn_delete(){
		if(confirm("해당 글을 삭제하시겠습니까?")){
			$("#deleteYn").val("Y");
			var reqUrl = "/la/popup/updatePopup";
			$("#frmComPopup").attr("action", reqUrl);
			$("#frmComPopup").attr("target","_self");
			$("#frmComPopup").submit();
		}
	}
	
	/* 리스트 조회 */
	function fn_search(){		 
		var reqUrl = "/la/popup/listPopup";
		$("#frmComPopup").attr("action", reqUrl);
		$("#frmComPopup").attr("target","_self");
		$("#frmComPopup").submit();
	}

	/* ********************************************************
	* 팝업창  오픈
	******************************************************** */
	function fn_egov_popupOpen_PopupManage(popupId,stopviewYn){

		var url = "<c:url value='/la/popup/openPopupManage.do' />?";
		url = url + "stopviewYn=" + stopviewYn;
		url = url + "&popupId=" + popupId;	
		var name = popupId;

		var openWindows = window.open(url,name,"width=${result.popupWidthSize},height=${result.popupHeightSize},top=${result.popupHeightPosi},left=${result.popupWidthPosi},toolbar=no,status=no,location=no,scrollbars=yes,menubar=no,resizable=yes");

		if (window.focus) {openWindows.focus()}
	}

</script>
<form id="frmComPopup" name="frmComPopup" method="post" enctype="multipart/form-data" >
	<input type="hidden" id="menuId" name="menuId" value="<c:out value='${menuId}'/>">
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}" />
	<input type="hidden" id="popupId" name="popupId" value="${result.popupId }"/>
	<input type="hidden" id="deleteYn" name="deleteYn" value="N"/>
	
	<div class="title-name-1">팝업 상세</div>
	<table border="0" cellpadding="0" cellspacing="0" class="view-2">
		<tbody>
			<tr>
				<th>제목</th>
				<td>${result.popupTitle}</td>
			</tr>
			<tr>
				<th width="100px">게시 기간</th>
				<td>
					${result.ntceBgnde} ~ ${result.ntceEndde}
				</td>
			</tr>
			<tr>
				<th>사용여부</th>
				<td>
					<c:choose>
						<c:when test="${result.useYn == 'Y'}">
							사용
						</c:when>
						<c:otherwise>
							미사용
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th>그만보기 여부</th>
				<td>
					<c:choose>
						<c:when test="${result.stopviewYn == 'Y'}">
							사용
						</c:when>
						<c:otherwise>
							미사용
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr> 
				<th>팝업 위치</th>
				<td>
					LEFT : ${result.popupWidthPosi}px,   TOP : ${result.popupHeightPosi}px
				</td>
			</tr>
			<tr>
				<th>팝업 사이즈</th>
				<td>
					폭 : ${result.popupWidthSize}px,   높이 : ${result.popupHeightSize}px
				</td>
			</tr>	
			<tr>
				<th>내용</th>
				<td ><c:out value='${result.popupContent}' escapeXml="false"/></td>
			</tr>
		</tbody>
	</table>
</form>

<div class="page-btn">
	<a href="#@" class="btn-lg-x2 btn-blue" onclick="javascript:fn_egov_popupOpen_PopupManage('${result.popupId}','${result.stopviewYn}'); return false;">미리보기</a>
	<a href="#!" onclick="fn_update();">수정</a>
	<a href="#!" onclick="fn_delete();">삭제</a>
	<a href="#!" onclick="fn_search();">목록</a>
</div>