<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%> 
<script type="text/javascript">
<!--
	function fn_egov_downFile(bbsNoticeId, bbsFileId){
		window.open("<c:url value='/la/bbs/FileDown?bbsNoticeId="+bbsNoticeId+"&bbsFileId="+bbsFileId+"'/>");
	}

	function fn_egov_deleteFile(bbsNoticeId, bbsFileId) {
		if (confirm("삭제 하시겠습니까?")) {
			forms = document.getElementsByTagName("form");

			for (var i = 0; i < forms.length; i++) {
				if (typeof(forms[i].bbsNoticeId) != "undefined" &&
						typeof(forms[i].bbsFileId) != "undefined" &&
						typeof(forms[i].fileListCnt) != "undefined") {
					form = forms[i];
				}
			}

			//form = document.forms[0];
			form.fileBbsNoticeId.value = bbsNoticeId;
			form.bbsFileId.value = bbsFileId;
			form.action = "<c:url value='/la/bbs/deleteFileInfs'/>";
			form.submit();	
		}
	}

	function fn_egov_check_file(flag) {
		if (flag=="Y") {
			document.getElementById('file_upload_posbl').style.display = "block";
			document.getElementById('file_upload_imposbl').style.display = "none";
		} else {
			document.getElementById('file_upload_posbl').style.display = "none";
			document.getElementById('file_upload_imposbl').style.display = "block";
		}
	}
//-->
</script>
<input type="hidden" name="fileBbsNoticeId" value="${bbsNoticeId}" />
<input type="hidden" name="bbsFileId" />
<input type="hidden" name="fileListCnt" id="fileListCnt" value="${fileListCnt}" /> 
<input type="hidden" name="returnUrl" value="${returnUrl}" />

<!--<title>파일목록</title> -->


		<c:forEach var="fileVO" items="${fileList}" varStatus="status">
			<c:choose>
				<c:when test="${updateFlag=='Y'}">
					<a href="javascript:fn_egov_downFile('<c:out value="${fileVO.bbsNoticeId}"/>','<c:out value="${fileVO.bbsFileId}"/>')"><c:out value="${fileVO.orgFileName}"/>&nbsp;[<c:out value="${fileVO.fileSize}"/>&nbsp;byte]</a>
					&nbsp;&nbsp;<a href="#" onClick="fn_egov_deleteFile('<c:out value="${fileVO.bbsNoticeId}"/>','<c:out value="${fileVO.bbsFileId}"/>');" >[파일삭제]</a> <br />
				</c:when>
				<c:otherwise>
					<a href="javascript:fn_egov_downFile('<c:out value="${fileVO.bbsNoticeId}"/>','<c:out value="${fileVO.bbsFileId}"/>')">
					<c:out value="${fileVO.orgFileName}"/>&nbsp;[<c:out value="${fileVO.fileSize}"/>&nbsp;byte]
					</a> <br />
				</c:otherwise>
			</c:choose>
			<br />
		</c:forEach>
