<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
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
		
	    com.datepicker('searchNtceBgnde');
	    com.datepicker('searchNtceEndde');
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
		var pathId = $("#mainBannerType").val();
		$("#pageIndex").val( pageNo );

		var reqUrl = "/la/banner/"+pathId+"/listBanner";
		$("#frmBanner").attr("action", reqUrl);
		$("#frmBanner").submit();
	}

	/* 등록 */
	function fn_cret(){
		var pathId = $("#mainBannerType").val();
		
		var reqUrl = "/la/banner/"+pathId+"/insertBanner";
		$("#frmBanner").attr("action", reqUrl);
		$("#frmBanner").submit();
	}

	/* 상세조회 */
	function fn_read( param1 ){
		var pathId = $("#mainBannerType").val();
		$("#mainBannerId").val( param1 );

		var reqUrl = "/la/banner/"+pathId+"/detailBanner";
		$("#frmBanner").attr("action", reqUrl);
		$("#frmBanner").submit();
	}
 
	/* 수정페이지 */
	function fn_save(id){ 
		var pathId = $("#mainBannerType").val();
		$("#mainBannerId").val(id);
		var reqUrl = "/la/banner/"+pathId+"/updateBanner";
		$("#frmBanner").attr("action", reqUrl);
		$("#frmBanner").submit();
	}
	
	/* 삭제 */
	function fn_del(id){
		var pathId = $("#mainBannerType").val();
		
		if (confirm("삭제 하시겠습니까?")) {
			document.frmBanner.mainBannerId.value = id;
			var reqUrl = "/la/banner/"+pathId+"/goDeleteBanner";
			$("#frmBanner").attr("action", reqUrl);
			$("#frmBanner").submit();
		}
	}
//-->
</script>
<form id="frmBanner" name="frmBanner"  method="post">
<input type="hidden" id="menuId" name="menuId" value="<c:out value='${menuId}'/>"> 
<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }" /> 
<input type="hidden" id="mainBannerType" name="mainBannerType" value="${pathBbsId }"/>
<input type="hidden" id="historyId"  name="historyId" />  
<input type="hidden" id="mainBannerId" name="mainBannerId" />
<input type="hidden" id="delMainBannerId" name="delMainBannerId" />
<div class="title-name-1">검색 조건</div>
<ul class="search-list-1" style="margin-top:7px;">
	<li>
		<span>기간</span>
		<input type="text" id="searchNtceBgnde" name="searchNtceBgnde"  value="${comMainBannerVO.searchNtceBgnde}"  style="width:80px" /> ~
		<input type="text" id="searchNtceEndde" name="searchNtceEndde"   value="${comMainBannerVO.searchNtceEndde}"  style="width:80px" />
	</li>
	<li>
		<span>제목</span>
		<input type="text" name="searchValue" id ="searchValue" value="${comMainBannerVO.searchValue}" />
	</li>
	
</ul><!-- E : search-list-1 -->
<div class="search-btn-area">
	<a href="#fn_search" onclick="javascript:fn_search(1); return false" onkeypress="this.onclick();">조회</a>
</div>

<ul class="board-info">
	<li class="info-area"><span>전체 : </span> <c:out value="${totalCount }"/> 건</li>
</ul><!-- E : board-info -->
	
<table border="0" cellpadding="0" cellspacing="0" class="list-1">
	<thead>
		<tr> 
			<th width="10%" >번호</th>
			<th>제목</th>
			<th width="20%" >기간</th>
			<th width="10%" >이미지</th>
			<th width="10%" >등록일</th>
			<th width="100px">관리</th>
		</tr>
	</thead>
	<tbody> 
    <!-- 게시글 목록 시작 -->
	<c:choose>
		<c:when test="${!empty resultList}">
			<c:forEach var="resultList" items="${resultList}"  varStatus="status">
				<tr>               
					<td>${totalCount-((pageIndex-1) * pageSize + status.count)+1}</td>					
					<td class="title">
						<a href="#fn_read" onclick="javascript:fn_read('${resultList.mainBannerId}')"> ${resultList.mainBannerTitle}</a>
					</td>
					<td>${resultList.ntceBgnde } ~ ${resultList.ntceEndde }</td>
					<td>              	 
						<c:if test="${!empty resultList.saveFileName}">	
							<img src="/la/banner/${pathBbsId}/getImage?mainBannerId=${resultList.mainBannerId }"
							<c:if test="${pathBbsId eq 'big'}">
								width="150px;" height="70px;"
							</c:if>
							<c:if test="${pathBbsId eq 'sub'}">
								width="110px;" height="55px;"
							</c:if>
							<c:if test="${pathBbsId eq 'rolling'}">
								width="110px;" height="24px;"
							</c:if>
							/>
						</c:if>
					</td>
					<td>${resultList.insertDate}</td>
					<td>
						<a href="#@" onclick="fn_save('${resultList.mainBannerId }');" class="btn-1">수정</a>
						<a href="#@" onclick="fn_del('${resultList.mainBannerId }');" class="btn-2">삭제</a>
					</td>
				</tr>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<c:if test="${empty resultList}">
				<tr>
					<td colspan="7"><spring:message code="common.nodata.msg" /></td>
				</tr>
			</c:if>
		</c:otherwise>
	</c:choose>
    <!-- 게시글 목록 끝 -->
	</tbody>
</table><!-- E : list -->

<div class="page-btn">
	<a href="#fn_cret" onclick="javascript:fn_cret(); return false" onkeypress="this.onclick();">등록</a> 
</div>

<div class="page-num">
	<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
</div><!-- E : page-num -->

</form>