<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<script type="text/javascript">
<!--
	var lastSel = 0;

	var pageSize = '${pageSize}'; //페이지당 그리드에 조회 할 Row 갯수;
	var totalCount = '${totalCount}'; //전체 데이터 갯수
	var pageIndex = '${pageIndex}'; //현재 페이지 정보

	$(document).ready(function() {

		if ('' == pageSize) {
			pageSize = 10;
		}
		if ('' == totalCount) {
			totalCount = 0;
		}
		if ('' == pageIndex) {
			pageIndex = 1;
		}

		loadPage();
	});

	/*====================================================================
		화면 초기화 
	====================================================================*/
	function loadPage() {
		initEvent();
		initHtml();
	}


	/* 각종 버튼에 대한 액션 초기화 */
	function initEvent() {
	}

	/* 화면이 로드된후 처리 초기화 */
	function initHtml() {

//         com.pageNavi( "pageNavi", totalCount , pageSize , pageIndex );

		$("#pageSize").val(pageSize); //페이지당 그리드에 조회 할 Row 갯수;
		$("#pageIndex").val(pageIndex); //현재 페이지 정보
		

// 	    com.datepicker('searchStartDate');
// 	    com.datepicker('searchEndDate');
	}

	/*====================================================================
		사용자 정의 함수 
	====================================================================*/

	function press(event) {
		if (event.keyCode==13) {
			fn_egov_select_adbkInfs('1');
		}
	}
	
	
// 	function fn_getComcode(targetUrl , param1){
// 		var reqUrl = CONTEXT_ROOT + targetUrl;
// 		$("#codeId").val( param1 );
// 		$("#frmComcode").attr("method", "post" );
// 		$("#frmComcode").attr("action", reqUrl);
// 		$("#frmComcode").submit();
// 	}




	/* 첵크된 Row 처리 */
	function fn_checkRowVals( thisObj ){

		var checkedCnt = $("#myGridTable input[name='" + thisObj.name + "']:checked").length;
 

			var valuesStr = "";
			$.each($("#myGridTable input[name='" + thisObj.name + "']:checked").parents("td").siblings(), function() {
				
				var inputObj = $(this).find("input");
				var inputName = inputObj.attr("name");
				var inputVal = inputObj.val();
				
				if( undefined != inputName ){

					inputName = inputName.replace("result_", "frm_");
					$("#" + inputName ).val(inputVal);
				}
			});
			
 
	}
	
	
	/* 리스트 조회 */
	function fn_search( pageNo ){
		//alert($("#searchPageSize").val());
		
		$("#pageSize").val( $("#searchPageSize").val() );
		$("#pageIndex").val( pageNo );
			
		var reqUrl = CONTEXT_ROOT + "/la/comcode/listComcode";
		$("#frmComcode").attr("action", reqUrl);
		$("#frmComcode").submit();
	}
	
	/* 추가 */
	function fn_cret(){
		
		var reqUrl = CONTEXT_ROOT + "/la/comcode/goInsertComcode";
		$("#frmComcode").attr("action", reqUrl);
		$("#frmComcode").submit();
	}

	/* 상세조회 */
	function fn_read( param1 ){
		
		$("#codeId").val( param1 );
		
		var reqUrl = CONTEXT_ROOT + "/la/comcode/getComcode";
		$("#frmComcode").attr("action", reqUrl);
		$("#frmComcode").submit();
	}

	/* 수정 */
	function fn_updt( param1 ){
		
		$("#codeId").val( param1 );
		
		var reqUrl = CONTEXT_ROOT + "/la/comcode/goUpdateComcode";
		$("#frmComcode").attr("action", reqUrl);
		$("#frmComcode").submit();
	}
			
	/* save(추가/수정) */
	function fn_save( param1 ){
		
		$("#codeId").val( param1 );
		
		var reqUrl = CONTEXT_ROOT + "/la/comcode/goSaveComcode";
		$("#frmComcode").attr("action", reqUrl);
		$("#frmComcode").submit();
	}
			
	/* 삭제 */
	function fn_delt(){
		 

		var checkedVals = com.getCheckedVal('check0','check1');
		com.log(checkedVals);

		$("#delCodeId").val( checkedVals );
		
		var reqUrl = CONTEXT_ROOT + "/la/comcode/deleteComcode";
		$("#frmComcode").attr("action", reqUrl);
		$("#frmComcode").submit();
	}

	/*
	* jsp 엑셀
	*/
	function fn_toExcel2(){
		var excelDownUrl = "/la/comcode/protoBoardExcelDownload2";
		
		//동적으로 iframe 생성
		var $iframe = $("#downIFrame");
		if($iframe.length < 1){
			var $iframe = $("<iframe id='downIFrame' name='downIFrame' frameBorder='0' scrolling='no' width='0' height='0'></iframe>");
			$(document.body).append($iframe);
		}
		
		//동적으로 다운로드용 form 생성
		var $form = $("#downForm");
		if($form.length < 1) {
			$form = $("<form id='downForm', method='post', action='"+excelDownUrl+"' target='downIFrame'></form>");
		  	$(document.body).append($form);
		}
		//이전에 처리한 다운로드파일정보 삭제
		$form.empty();

 
		$form.submit();
		
	}
	
	/* AJAX 로 form 저장 */
	function fn_ajaxSave(){
		
		var reqUrl = CONTEXT_ROOT + "/la/comcode/saveComcode.json";
// 			var param 	= $("#frmComcode").serialize();
		var param = $("#frmComcodeAJAX").serializeArray();

		
		com.ajax4confirm( "저장 하시겠습니까?" , reqUrl, param, function(obj, data, textStatus, jqXHR){						
			if (200 == jqXHR.status ) {
				
				com.alert( jqXHR.responseJSON.retMsg );
				
				if( "SUCCESS" == jqXHR.responseJSON.retCd ){
					fn_search( 1 );
				}
			}
		}, {
    		async : true,
    		type : "POST",
    		spinner : true,
			errorCallback : null,
    		timeout : 30000			// 기본 30초
    	});
	}
//-->
</script>
 
<form id="frmComcode" name="frmComcode" action="<c:url value='/la/comcode/listComcode'/>" method="post">
	<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }" /> 
	<input type="hidden" id="codeId" name="codeId" /> 
	<input type="hidden" id="delCodeId" name="delCodeId" />
	<div class="title-name-1">검색 조건</div>
	<ul class="search-list-1"  style="margin-top:7px;"> 
		<li>
			<span>코드 구분</span>
			<select id="searchCodeGroup" name="searchCodeGroup" style="width:280px; margin-right:10px;">
				<option value="">선택하세요</option>
			<c:forEach items="${comcodeGroupList}" var="item" varStatus="status" >
				<option value="${item.codeGroup}" <c:if test="${ item.codeGroup eq searchCodeGroup or item.codeGroup eq returnResultMap.searchCodeGroup}" > selected="selected"</c:if> >${item.groupDesc}</option>
			</c:forEach></select>
		</li>
		<li>
			<span>코드 명</span>
			<input type="text" id="searchCodeName" name="searchCodeName" style="width:415px;" value="${searchCodeName }"/>
		</li>
	</ul><!-- E : search-list-1 -->
	<div class="search-btn-area"><a href="#" onclick="fn_search(1);">조회</a></div>
	
	
	<ul class="board-info">
		<li class="info-area"><span>전체 : </span> <c:out value="${totalCount }"/> 건</li>
		<li class="btn-area">
			<a role="button" href="#" onclick="fn_save();">신규</a>
			<a role="button" href="#" onclick="fn_delt();">삭제</a>
			<select style="width:80px; margin-left:20px;" name="searchPageSize" id="searchPageSize" onchange="javascript:fn_search(1)">
				<option value="10" <c:if test="${pageSize eq '10' }">selected</c:if> >10 개</option>
				<option value="20" <c:if test="${pageSize eq '20' }">selected</c:if> >20 개</option>
				<option value="30" <c:if test="${pageSize eq '30' }">selected</c:if> >30 개</option>
				<option value="50" <c:if test="${pageSize eq '50' }">selected</c:if> >50 개</option>
			</select>
		</li>
	</ul>
	
	<table id="myGridTable" border="0" cellpadding="0" cellspacing="0" class="list-1">
		<thead>
			<tr>
				<th width="30px"><input type="checkbox" id="check0" name="check0" onclick="javascript:com.checkAll('check0','check1');"/></th>
				<th width="30px">순번</th>
				<th width="100px">코드구분</th>
				<th width="100px">코드</th>
				<th>코드명</th>
				<th width="100px">코드영문명</th>
				<th width="100px">코드설명</th>
				<th width="100px">순서</th>
				<!-- <th width="100px">삭제여부(탈퇴)</th> -->
				<th width="100px">사용여부</th>
				<!-- 
				<th width="100px">비고1</th>
				<th width="100px">비고2</th>
				<th width="100px">비고3</th> 
				-->
				<th width="100px">추가/수정</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td><input type="checkbox" name="check1" class="choice" value='<c:out value="${result.codeId}"/>'  onclick="javascript:fn_checkRowVals(this);"></td>
				<td><c:out value="${totalCount-((pageIndex-1) * pageSize + status.count)+1}"/>
					<input type="hidden" name="result_codeId" value='<c:out value="${result.codeId}"/>' /> </td>
				<td><c:out value="${result.codeGroup}"/><input type="hidden" name="result_codeGroup"		value='<c:out value="${result.codeGroup}"/>'  /></td>
				<td><c:out value="${result.codeCode}"/><input type="hidden" name="result_codeCode"		value='<c:out value="${result.codeCode}"/>'  /></td>
				<td class="subject"><c:out value="${result.codeName}"/><input type="hidden" name="result_codeName"		value='<c:out value="${result.codeName}"/>'  /></td>
				<td><c:out value="${result.codeNameEng}"/><input type="hidden" name="result_codeNameEng"		value='<c:out value="${result.codeNameEng}"/>'  /></td>
				<td><c:out value="${result.groupDesc}"/><input type="hidden" name="result_groupDesc"		value='<c:out value="${result.groupDesc}"/>'  /></td>
				<td><c:out value="${result.codeOrder}"/><input type="hidden" name="result_codeOrder"		value='<c:out value="${result.codeOrder}"/>'  /></td>
				<!-- <td><c:out value="${result.deleteYn}"/><input type="hidden" name="result_deleteYn"		value='<c:out value="${result.deleteYn}"/>'  /></td> -->
				<td><c:out value="${result.useYn}"/><input type="hidden" name="result_useYn"		value='<c:out value="${result.useYn}"/>'  /></td>
				<!-- 
				<td><c:out value="${result.bigo1}"/><input type="hidden" name="result_bigo1"		value='<c:out value="${result.bigo1}"/>'  /></td>
				<td><c:out value="${result.bigo2}"/><input type="hidden" name="result_bigo2"		value='<c:out value="${result.bigo2}"/>'  /></td>
				<td><c:out value="${result.bigo3}"/><input type="hidden" name="result_bigo3"		value='<c:out value="${result.bigo3}"/>'  /></td>
				-->
 				<td><a class="btn-2" href="#fn_read" onclick="javascript:fn_save( '<c:out value="${result.codeId}"/>'); return false" onkeypress="this.onclick;">수정</a></td>
			</tr>
			</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
			<tr>
				<td class="lt_text3" nowrap colspan="20"><spring:message code="common.nodata.msg" /></td>
			</tr>
		</c:if>
		</tbody>
	</table>
</form>

<div class="page-num">
	<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
</div>