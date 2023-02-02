<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<c:set var="targetUrl" value="/la/apply/"/>

<script type="text/javascript">
<!--
	var targetUrl = "${targetUrl}"; 

	$(document).ready(function() {
  
	});
 
	/* 리스트 조회 */
	function fn_search(  ){
		 		
		var reqUrl = CONTEXT_ROOT + targetUrl + "listApply";
		$("#frmApply").attr("action", reqUrl);
		$("#frmApply").attr("target","_self");
		$("#frmApply").submit();
	}	 
	


/* 워드파일 다운로드 */
function fn_wordDownload(appNo, recNo){
	$("#applyNo").val(appNo);
	$("#receiptNo").val(recNo);
	
	var reqUrl = CONTEXT_ROOT + targetUrl + "listApplyWordDownload";
	$("#frmApply").attr("action", reqUrl);
	$("#frmApply").attr("target","_self");
	$("#frmApply").submit();
}
//-->
</script> 
<form id="frmApply" name="frmApply" action="<c:url value='/la/apply/listApply'/>" method="post">
<input type="hidden" id="applyNo" name="applyNo"  />
<input type="hidden" id="receiptNo" name="receiptNo"  />
<input type="hidden" id="selectYn" name="selectYn" value="${comApplyVO.selectYn }" />
<input type="hidden" id="applyArea" name="applyArea" value="${comApplyVO.applyArea }" />
<input type="hidden" id="searchType" name="searchType" value="${comApplyVO.searchType }" />
<input type="hidden" id="searchKeyword" name="searchKeyword" value="${comApplyVO.searchKeyword }" />



	<input type="hidden" id="pageSize" name="pageSize" value="${comApplyVO.pageSize }" />
	<input type="hidden" id="pageIndex" name="pageIndex" value="${comApplyVO.pageIndex }" />  
</form>	
						<div class="title-name-1">지원현황 상세화면</div>
						<table border="0" cellpadding="0" cellspacing="0" class="view-1">
							<tbody> 
								<tr>
									<th style="width:300px;">접수번호</th>
									<td><c:out value="${resultList.receiptNo }" /></td>
								</tr>
								<tr>
									<th>지원분야</th>
									<td>
										<c:if test="${resultList.applyArea eq 'T'}">ICT일반</c:if>
										<c:if test="${resultList.applyArea eq 'I'}">지능정보</c:if>
									</td>
								</tr>
								<tr>
									<th>팀명</th>
									<td><c:out value="${resultList.devName }" /></td>
								</tr>
								<tr>
									<th>서비스명<br />(개발명)</th>
									<td><c:out value="${resultList.serviceName }" /></td>
								</tr>
								<tr>
									<th>대표자명</th>
									<td><c:out value="${resultList.ceoName }" /></td>
								</tr>
								<tr>
									<th>소재지</th>
									<td><c:out value="${resultList.location }" /></td>
								</tr>
								<tr>
									<th>소속</th>
									<td><c:out value="${resultList.ceoPost }" /></td>
								</tr>
								<tr>
									<th>휴대폰</th>
									<td><c:out value="${resultList.ceoPhone }" /></td>
								</tr>
								<tr>
									<th>이메일</th>
									<td><c:out value="${resultList.ceoEmail }" /></td>
								</tr>
								<tr>
									<th>해당 아이디어<br /> 창업 여부</th>
									<td><c:out value="${resultList.startupYn }" /></td>
								</tr>
								<tr>
									<th>창업시기</th>
									<td><c:out value="${resultList.startupDate }" /></td>
								</tr>
								<tr>
									<th>투자유치</th>
									<td><c:out value="${resultList.investYn }" /></td>
								</tr>
								<tr>
									<th>지원서</th>
									<td><a href="#fn_wordDownload" onclick="javascript:fn_wordDownload('${resultList.applyNo}','${resultList.receiptNo}'); return false" onkeypress="this.onclick;" class="btn-1">다운로드</a></td>
								</tr>
								<tr>
									<th>첨부파일</th>
									<td>
										<c:import url="/commbiz/atchfle/atchFileListImport.do" charEncoding="utf-8">
											<c:param name="param_atchFileId" value="${resultList.atchFileId}" />
										</c:import>
									</td>
								</tr>
							</tbody>
						</table><!-- E : view-1 -->

<div class="page-btn">
	<a href="#" onclick="javascript:fn_search();">목록</a>
</div><!-- E : page-btn -->
