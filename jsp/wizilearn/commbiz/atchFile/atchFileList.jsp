<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	<!--
	function fn_egov_downFile(atchFileId, fileSn){
		window.open("<c:url value='/commbiz/atchfle/atchFileDown.do?importAtchFileId="+atchFileId+"&importfileSn="+fileSn+"'/>");
	}

	function fn_egov_deleteFile(atchFileId, fileSn){
		if(confirm("해당 파일을 삭제하기겠습니까?")){
		$.ajax({
			url:"/commbiz/atchfle/atchFileDelete.do",
			type:"get",
			data:{"importAtchFileId" : atchFileId, "importFileSn" : fileSn},
			success:function(result){
				deleteFile(atchFileId, fileSn)
			},
			error:function(e){
				console.log("ERROR!!!!!!!!!!!");
			}
		})
		}
	}
	
	function deleteFile(atchFileId, fileSn){
		$("#fileDeleteYn_"+atchFileId+"_"+fileSn).val("Y");
		$("#file_"+atchFileId+"_"+fileSn).hide();
	}
	//-->
</script>

<c:if test="${fn:length(fileList) > 0}">
<!-- <H1>파일목록</H1> -->
<table cellspacing="0" cellpadding="0" style="font-size:12.4px;">
	<tbody style="display: inline-flex;">
	<c:forEach var="file" items="${fileList}" varStatus="status">
		<tr id="file_${file.atchFileId}_${file.fileSn}" style="display: inline-flex;">
			<input type="hidden" name="fileDeleteYn" id="fileDeleteYn_${file.atchFileId}_${file.fileSn}" value="N"/>
			<td>
				<c:if test="${bbsType eq 'gallery' }">
					<img src="/commbiz/atchfle/getImage.do?atchFileId=${file.atchFileId}&fileSn=${file.fileSn}" style="width:800px;"/> ==>
				</c:if>
				<a href="javascript:fn_egov_downFile('${file.atchFileId}','${file.fileSn}');" style="margin-right:10px;">${file.orgFileName}</a>
				<c:choose>
					<c:when test="${deleYn=='Y'}">
						==> <a href="javascript:fn_egov_deleteFile('${file.atchFileId}','${file.fileSn}')">[파일삭제]</a>
					</c:when>
				</c:choose>
			</td>
		</tr>
		<c:if test="${bbsType eq 'gallery' }">
			<!-- 갤러리 사진 섬네일 생성 위함 -->
			<div style="display:none;">
				<img src="/commbiz/atchfle/getMiImage.do?atchFileId=${file.atchFileId}"/>
				<img src="/commbiz/atchfle/getSmImage.do?atchFileId=${file.atchFileId}"/>
			</div>
		</c:if>
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

