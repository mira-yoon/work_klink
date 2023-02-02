<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	function fn_egov_downFile(bbsFileId, fileSn){
		window.open("<c:url value='/commbiz/bbs/comBbsFileDown.do?importComBbsFileId="+bbsFileId+"&importfileSn="+fileSn+"'/>");
	}

	function fn_egov_deleteFile(bbsFileId, fileSn){
		if(confirm("해당 파일을 삭제하기겠습니까?")){
		$.ajax({
			url:"/commbiz/bbs/comBbsFileDelete.do",
			type:"get",
			data:{"importComBbsFileId" : bbsFileId, "importfileSn" : fileSn},
			success:function(result){
				deleteFile(bbsFileId, fileSn);
			},
			error:function(e){
				console.log("ERROR!!!!!!!!!!!");
			}
		})
		}
	}
	
	function deleteFile(bbsFileId, fileSn){
		//$("#fileDeleteYn_"+bbsFileId+"_"+fileSn).val("Y");
		//$("#file_"+bbsFileId+"_"+fileSn).hide();
		var bbsId = '${bbsTypeId}';
		
		document.frmBbs.bbsNoticeId.value='${bbsNoticeId}';
		
		var reqUrl = '${returnUrl}';
		$("#frmBbs").attr("action", reqUrl);
		$("#frmBbs").attr("target","_self");
		$("#frmBbs").submit();
	}
</script>

<c:if test="${fn:length(fileList) > 0}">
<!-- <H1>파일목록</H1> -->
<table cellspacing="0" cellpadding="0" style="font-size:12.4px;">
	<input type="hidden" id="fileCount" name="fileCount" value="${fn:length(fileList)}"/>
	<tbody style="display: inline-flex;">
	<c:forEach var="file" items="${fileList}" varStatus="status">
		 	<input type="hidden" name="fileDeleteYn" id="fileDeleteYn_${file.bbsFileId}_${file.fileSn}" value="N"/>
 			<a href="javascript:fn_egov_downFile('${file.bbsFileId}','${file.fileSn}');" style="margin-right:10px;">${file.orgFileName}</a>
			<c:choose>
				<c:when test="${delYn=='Y'}">
				 &nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:fn_egov_deleteFile('${file.bbsFileId}','${file.fileSn}')">[파일삭제]</a>
				</c:when>
			</c:choose>
			<br />
		 
	</c:forEach>
	<c:forEach var="cnt" begin="1" end="${item.attachCnt}" varStatus="status">
		<tr>
			<td><input type="file" id="file${cnt}" name="file${cnt}" /></td>
		</tr>
	</c:forEach>
	</tbody>
</table>
</c:if>

<c:if test="${fn:length(fileList) == 0}">
	<div style="display: inline-table;"></div>
</c:if>

