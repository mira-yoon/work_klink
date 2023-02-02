<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
<!--
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
	
		$("#pageSize").val(pageSize); //페이지당 그리드에 조회 할 Row 갯수;
		$("#pageIndex").val(pageIndex); //현재 페이지 정보
		
	    com.datepicker('searchDate');
	}
	
	function press(event) {
		if (event.keyCode==13) {
			fn_egov_select_adbkInfs('1');
		}
	}
	
	/* 조회 */
	function fn_search(param1){
		var scSection = $("#scSection").val();
		$("#pageIndex").val( param1 );
		$("#pageSize").val($("#searchPageSize").val());
		var reqUrl = "/la/schedule/"+scSection+"/listSchedule";
		$("#frmSchedule").attr("action", reqUrl);
		$("#frmSchedule").attr("target","_self");
		$("#frmSchedule").submit();
	}
	/* 상세 조회 */
	function fn_detail(seq){
		var scSection = $("#scSection").val();
		$("#scSeq").val(seq);
		
		var reqUrl = "/la/schedule/"+scSection+"/adminDetailSchedule";
		$("#frmSchedule").attr("action", reqUrl);
		$("#frmSchedule").attr("target","_self");
		$("#frmSchedule").submit();
	}
	
	/* 작성 화면 */
	function fn_write(){
		var scSection = $("#scSection").val();
		var reqUrl = "/la/schedule/"+scSection+"/adminInsertSchedule";
		$("#frmSchedule").attr("action", reqUrl);
		$("#frmSchedule").attr("target","_self");
		$("#frmSchedule").submit();
		
	}
	//-->
</script>

<form id="frmSchedule" name="frmSchedule" method="post" enctype="multipart/form-data">
	<input type="hidden" id="menuId" name="menuId" value="<c:out value='${menuId}'/>"> 
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}" />
	<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
	<input type="hidden" id="scSeq" name="scSeq"/>
	<input type="hidden" id="scSection" name="scSection" value="${pathBbsId}"/>
	
	<div class="title-name-1">검색 조건</div>
	<ul class="search-list-1" style="margin-top:7px;">
		<li>
			<span>
				<c:if test="${pathBbsId eq 'calendar'}">제목</c:if>
				<c:if test="${pathBbsId eq 'meeting'}">예약자</c:if>
			</span>
			<input type="text" name="searchKeyword" id="searchKeyword" value="${comScheduleVO.searchKeyword }" style="width:30%;" />
		</li>
		<c:if test="${pathBbsId eq 'calendar'}">
			<li>
				<span>일정 구분</span>
				<select name="searchType"  id="searchType" title="일정 구분" style="width:30%;"> 
					<option value="">= 선택 =</option>
					<c:forEach var="codeList" items="${codeList }" varStatus="status">
						<option value="${codeList.codeCode }" class="choice" <c:if test="${comScheduleVO.searchType == codeList.codeCode}">selected</c:if>/><label>${codeList.codeName }</label>
					</c:forEach>
				</select>
			</li>
		</c:if>
		<li>
			<span>일자</span>
			<input type="text" id="searchDate" name="searchDate"  value="${comScheduleVO.searchDate}"  style="width:150px;" />
		</li>
	</ul>
	
	<div class="search-btn-area"><a href="#" onclick="javascript:fn_search(1);">조회</a></div>
	
	<ul class="board-info">
		<li class="info-area"><span>전체 : </span> <c:out value="${totalCount}" /> 건</li>
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
		<th width="60px">번호</th>
		<c:if test="${pathBbsId eq 'calendar'}">
			<th width="20%">구분</th>
			<th width="30%">제목</th>
		</c:if>
		<c:if test="${pathBbsId eq 'meeting'}">
			<th width="30%">예약자</th>
		</c:if>
		<c:if test="${pathBbsId eq 'calendar'}"><th>장소</th></c:if>
		<th>일자</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<tr>
			<td>
				<c:out value="${totalCount - ((pageIndex-1) * pageSize + status.count)+1}"/>
			</td>	
			<c:if test="${pathBbsId eq 'calendar'}">
				<td>
					<c:if test="${result.scType eq 'TM' }"><span>Tech Meetup</span></c:if>
					<c:if test="${result.scType eq 'GM' }"><span>그룹 멘토링</span></c:if>
					<c:if test="${result.scType eq 'PE' }"><span>피칭교육</span></c:if>
					<c:if test="${result.scType eq 'PC' }"><span>피칭컨설팅</span></c:if>
					<c:if test="${result.scType eq 'PP' }"><span>피칭대회</span></c:if>
				</td>
			</c:if>
			<td><a href="#detail" onclick="javascript:fn_detail('${result.scSeq}');"><c:out value="${result.title }"/></a></td>
			<c:if test="${pathBbsId eq 'calendar'}">
				<td>${result.location }</td>
			</c:if>
			<td>${result.scDay }&nbsp;&nbsp; (${result.startTime }&nbsp; ~&nbsp;  ${result.endTime })</td>
		</tr>							
	</c:forEach>
	<c:if test="${fn:length(resultList) == 0}">
			<tr>
				<td colspan="8">
					조회된 데이터가 없습니다.
				</td>
			</tr>
	</c:if>
	</tbody>
</table>

<div class="page-btn">
	<a href="#" onclick="fn_write();">등록</a>
</div>

<div class="page-num">
	<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" /> 
</div><!-- E : page-num -->