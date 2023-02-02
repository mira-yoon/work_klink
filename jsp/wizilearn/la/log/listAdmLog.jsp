<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%><%@
taglib prefix="form" uri="http://www.springframework.org/tags/form"%><%@ 
taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<c:set var="targetUrl" value="/la/log/"/>
<script type="text/javascript">
<!--
	var targetUrl = "${targetUrl}"; 

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
		
 	    com.datepicker('searchStartDate');
 	    com.datepicker('searchEndDate');
	}

	/*====================================================================
		사용자 정의 함수 
	====================================================================*/

	function press(event) {
		if (event.keyCode==13) {
			fn_egov_select_adbkInfs('1');
		}
	}

	/* 리스트 조회 */
	function fn_search( pageNo ){
		$("#pageIndex").val( pageNo );

		var reqUrl = CONTEXT_ROOT +  targetUrl+"listAdmLog";
		$("#frmMain").attr("action", reqUrl);
		$("#frmMain").submit();
	}
	
	/* 엑셀다운로드 */
	function fn_exclDownload(){
		var reqUrl = "/la/log/listAdmLogExcelDownload";
		$("#frmMain").attr("action", reqUrl);
		$("#frmMain").attr("target", "_blank");
		$("#frmMain").submit();
	}
//-->
</script>
<form id="frmMain" name="frmMain"  method="post">
<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }" /> 
<input type="hidden" id="historyId"  name="historyId" />
<div class="title-name-1">검색 조건</div>
<ul class="search-list-1" style="margin-top:7px;">

	<li>
		<span>기간</span>
		<input type="text" id="searchStartDate" name="searchStartDate"  value="${comAdmLoginLogVO.searchStartDate}"  style="width:80px" /> ~
		<input type="text" id="searchEndDate" name="searchEndDate"   value="${comAdmLoginLogVO.searchEndDate}"  style="width:80px" />
	</li>
	<li>
		<span>이름</span>
		<input type="text" name="memName" id ="memName" value="${comAdmLoginLogVO.memNameStr}" />
	</li>
	<!--li>
		<span>메뉴명</span>
		<input type="text" name="workText" id ="workText" value="${comAdmLoginLogVO.workText}" />
	</li -->
	
</ul><!-- E : search-list-1 -->
<div class="search-btn-area">
	<a href="#fn_search" onclick="javascript:fn_search(1); return false" onkeypress="this.onclick();">조회</a>
</div>

<ul class="board-info">
	<li class="info-area"><span>전체 : </span> <c:out value="${totalCount }"/> 건</li>
	<li class="btn-area">
		<a href="#fn_exclDownload" onclick="javascript:fn_exclDownload(); return false" onkeypress="this.onclick;" class="btn">엑셀다운로드</a>					
	</li>
</ul><!-- E : board-info -->

<table border="0" cellpadding="0" cellspacing="0" class="list-1">
	<thead>
		<tr>
			<th width="30px">번호</th>
			<th width="10%" >이름</th>
			<th width="15%" >접속시간</th>
			
			<th>아이피</th>
			<th>OS</th>
			<th>브라우저</th>
			
			<th>메뉴명</th>
			
			<th width="20%" >실행URL</th>
			<th width="20%" >실행유형</th>
		</tr>
	</thead>
	<tbody>
	<!-- 로그가 있는경우 시작 -->
    <c:choose>
        <c:when test="${!empty resultList}">
          <c:forEach var="resultList" items="${resultList}"  varStatus="status">
            <tr>            
              <td>${totalCount-((pageIndex-1) * pageSize + status.count)+1}</td>
              <td>${resultList.memNameStr}</td>
              <td  class="title" >${resultList.loginDateStd }</td>

              <td>${resultList.clientIp }</td>
              <td>${resultList.clientOs }</td>
              <td>${resultList.clientBrowser }</td>
              
              <td>${resultList.menuName }</td>
              
              <td>${resultList.workUrl }</td>
              <td>${resultList.workType }</td>
            </tr>
          </c:forEach>
        </c:when>
        <c:otherwise>
        <c:if test="${empty resultList}">
          <tr>
            <td colspan="8">로그가 없습니다.</td>
          </tr>
          </c:if>
        </c:otherwise>
    </c:choose>
    <!--  끝 -->

</tbody>
</table><!-- E : list -->
<div class="page-num">
	<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
</div><!-- E : page-num -->
</form>