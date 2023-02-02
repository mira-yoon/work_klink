<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%><%@ 
taglib prefix="form" uri="http://www.springframework.org/tags/form"%><%@ 
taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">

	/* 리스트 조회 */
	function fn_search( param1 ){
		$("#pageIndex").val( param1 );
		$("#pageSize").val($("#searchPageSize").val());
		var reqUrl = "/la/apply/listApplyUser";
		$("#frmApply").attr("action", reqUrl);
		$("#frmApply").attr("target","_self");
		$("#frmApply").submit();
	}
	
	/* 엑셀다운 */
	function fn_excel(){
		var reqUrl = "/la/apply/listApplyUserExcelDown";
		$("#frmApply").attr("action", reqUrl);
		$("#frmApply").attr("target", "_blank");
		$("#frmApply").submit();
	}
	
</script>

<form name="frmApply" id="frmApply"  target="_self" method="post" >
	<input type="hidden" name="pageIndex" id="pageIndex" value="${pageIndex}"/>
  	<ul class="search-list-1" style="margin-top:7px;">
		<li>
			<span style="width: 15%;"> 국적</span>
			<select name="natCd" onchange="goSearch(1)" class="selectype">
				${nationSelect}
			</select>
		</li>
		<li>
			<span style="width: 15%;"> 수료 연수과정</span>
			<select name="statusCd" onchange="goSearch(1)" class="selectype">
				<%-- ${codeSelect} --%>
			</select>
			<select name="statusCd" onchange="goSearch(1)" class="selectype">
				<%-- ${codeSelect} --%>
			</select>
		</li>
		<li>
			<span style="width: 15%;"> 검색</span>
			<select name="searchType" class="selectype">
				<option value="">--검색조건--</option>
				<%-- <option value="USERID" <c:if test="${'USERID' == studentVO.searchType}"> selected </c:if>>사용자ID</option>
				<option value="NAT_NAME_KR" <c:if test="${'NAT_NAME_KR' == studentVO.searchType}"> selected </c:if>>국가명(한글)</option>
				<option value="NATION" <c:if test="${'NATION' == studentVO.searchType}"> selected </c:if>>국가명(영어)</option> --%>
			</select>
			<input type="text" name="searchKeyword" id="searchKeyword" value="${studentVO.searchKeyword }" class="typeTxt" style="width: 400px;" />
		</li>
	</ul>

       	<div class="search-btn-area"><a href="#" onclick="javascript:fn_search(1);">조회</a></div>
        	<ul class="board-info">
		<li class="info-area">
		</li>
		<li class="btn-area">
			<a href="#" onclick="fn_excel()">엑셀다운</a>
			<select name="pageSize" id="pageSize" title="목록 갯수 설정하기" onchange="javascript:fn_search(1)">
				<option value="10" <c:if test="${pageSize=='10' }" > selected</c:if> >10 개</option>
				<option value="20" <c:if test="${pageSize=='20' }" > selected</c:if> >20 개</option>
				<option value="30" <c:if test="${pageSize=='30' }" > selected</c:if> >30 개</option>
				<option value="50" <c:if test="${pageSize=='50' }" > selected</c:if> >50 개</option>
			</select>
		</li>
	</ul>

	<table cellspacing="0" cellpadding="0" border="0" summary="" class="list-1">
		<caption>연수생 관리</caption>
		<colgroup>
			<col style="width: 5%" />
			<col style="width: 10%" />
			<col style="width: 15%" />
			<col style="width: 8%" />
			<col style="width: auto%" />
			<col style="width: 12%" />
		</colgroup>
		<thead>
		<tr>
			<th scope="col">No</th>
			<th scope="col">국가</th>
			<th scope="col">이름</th>
			<th scope="col">연도</th>
			<th scope="col">과정명</th>
			<th scope="col">연수기간</th>
		</tr>
		</thead>
		<tbody>
		
		<c:choose>
	        <c:when test="${!empty resultList}">
	        	<c:forEach var="resultList" items="${resultList}"  varStatus="status">
					<tr>
						<td><input type="checkbox" name="applyCd" value="${resultList.applyCd}" /></td>
						<td class="no">${totalCount-((pageIndex-1) * pageSize + status.count)+1}</td>
						<td>
							<a href="#" onclick="goPopup('${resultList.userId}','${resultList.applyCd}')">${resultList.firstNameStr},${resultList.lastNameStr}</a>
						</td>
						<td>
							<a href="#" onclick="goPopup('${resultList.userId}','${resultList.applyCd}')">${resultList.userId}</a>
						</td>
						<td class="title">
							<a href="#" onclick="goPopup('${resultList.userId}','${resultList.applyCd}')">${resultList.natName}</a>
						</td>
						<td>${resultList.statusCdName}</td>
						<td>${resultList.applyDate}</td>
						<td>${resultList.modDate}</td>
						<td>
							<c:if test="${!empty resultList.dayStart}" >
								<span><a href="#" onclick="dateInput('${resultList.applyCd}', this,'start','on','${resultList.dayStart}')">${resultList.dayStart}</a></span>
							</c:if>
							<c:if test="${empty resultList.dayStart}" >
								<span><a href="#" style="color: silver;" onclick="dateInput('${resultList.applyCd}', this,'start','off','')">날짜등록</a></span>
							</c:if>
						</td>
						<td>
							<c:if test="${!empty resultList.dayEnd}" >
								<span><a href="#" onclick="dateInput('${resultList.applyCd}', this,'end','on','${resultList.dayEnd}')">${resultList.dayEnd}</a></span>
							</c:if>
							<c:if test="${empty resultList.dayEnd}" >
								<span><a href="#" style="color: silver;" onclick="dateInput('${resultList.applyCd}', this,'end','off','')">날짜등록</a></span>
							</c:if>
						</td>
						<td>${resultList.contactYn}</td>
						<td>
							<a href="#" onclick="fn_evaluation_select('${resultList.applyCd}', '${resultList.evaluationYn}'); return false;">
							<c:if test="${resultList.evaluationYn eq 'Y'}" >
								${resultList.total}
							</c:if>
							<c:if test="${resultList.evaluationYn ne 'Y'}" >
								<img src="/pages/admin/images/kljjs.gif" alt="점수입력"/>
							</c:if>
							</a>
						</td>
					</tr>
	        	</c:forEach>
	        </c:when>
	        <c:otherwise>
	          	<tr>
					<td colspan="6">신청자 목록이 없습니다.</td>
				</tr>
	        </c:otherwise>
	    </c:choose>
		</tbody>
	</table>
	
	<div class="page-num">
		<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" /> 
	</div>
	
</form>