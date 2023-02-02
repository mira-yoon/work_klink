<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%><%@ 
taglib prefix="form" uri="http://www.springframework.org/tags/form"%><%@ 
taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
<!--


function goUserList(code){
	 
	var reqUrl = "/la/apply/listApplyUser";	
	$("#courseCd").val(code);
	$("#searchFrm").attr("action", reqUrl);
	$("#searchFrm").submit();
	
}

function fn_search(pageIndex){
	$("#pageIndex").val(pageIndex);
	var reqUrl = "/la/apply/listApply";	
	$("#searchFrm").attr("action", reqUrl);
	$("#searchFrm").submit();	
}

//-->
</script>
	<c:set var="now" value="<%=new java.util.Date()%>"/>
	<fmt:formatDate var="nowDate" value="${now}" pattern="yyyy"/>
    <fmt:formatNumber value="${nowDate}" type="number" pattern="0000" var="nowDateNumberType" />
    
<form name="searchFrm" id="searchFrm"  target="_self" method="post" >
   	<input type="hidden" name="pageIndex" id="pageIndex" value="${pageIndex}"/>
	<input type="hidden" name="courseCd" id="courseCd" />
 	<ul class="search-list-1" style="margin-top:7px;">
		<li>
			<span style="width: 15%;">년도</span>
			<select name="searchYear" id="searchYear" class="selectype">
			<c:forEach var="yearVal" begin="0" end="20" varStatus="status">
			    <c:set var="yearValStr" value="${nowDateNumberType-yearVal}" />
				<c:choose>
					<c:when test="${applyVO.searchYear eq yearValStr}">
						<option value="${yearValStr }" selected>${yearValStr }년</option>
					</c:when>
					<c:otherwise>
						<option value="${yearValStr }" >${yearValStr }년</option>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			</select>
 		</li>
		<li>
			<span style="width: 15%;"> 과정 상태</span>
			<select name="statusCd" onchange="goSearch(1)" class="selectype">
				${selectBox}
			</select>
		</li>
		<li>
			<span style="width: 15%;">과정명 검색</span>
			<input type="hidden" name="searchType" value="TITLE"/>
			<input type="text" name="searchKeyword" id="searchKeyword" value="${applyVO.searchKeyword }" class="typeTxt" style="width: 400px;" />
		</li>
	</ul>
	
   	<div class="search-btn-area"><a href="#" onclick="javascript:fn_search(1);">조회</a></div>
   	<ul class="board-info">
		<li class="info-area"><span>전체 : </span> <c:out value="${totalCount}" /> 건</li>
		<li class="btn-area">
			<select name="pageSize" id="pageSize" title="목록 갯수 설정하기" onchange="javascript:fn_search(1)">
				<option value="10" <c:if test="${pageSize=='10' }" > selected</c:if> >10 개</option>
				<option value="20" <c:if test="${pageSize=='20' }" > selected</c:if> >20 개</option>
				<option value="30" <c:if test="${pageSize=='30' }" > selected</c:if> >30 개</option>
				<option value="50" <c:if test="${pageSize=='50' }" > selected</c:if> >50 개</option>
			</select>
		</li>
	</ul>
	 
	<table cellspacing="0" cellpadding="0" border="0" summary="연수관리목록" class="list-1">
		<caption>연수 관리</caption>
		<colgroup>
			<col style="width:5%" />
			<col style="width:5%" />
			<col/>
			<col style="width:6%" />
			<col style="width:6%" />
			<col style="width:6%" />
			<col style="width:6%" />
			<col style="width:6%" />
			<col style="width:6%" />
			<col style="width:6%" />
			<col style="width:6%" />
			<col style="width:7%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col"><input type="checkbox" class="typeCheck" onclick="doChkAll(this)" /></th>
				<th scope="col">No</th>
				<th scope="col">과정명</th>
				<th scope="col">모집<br/>인원</th>
				<th scope="col">신청중</th>
				<th scope="col">접수</th>
				<th scope="col">대기</th>
				<th scope="col">승인</th>
				<th scope="col">거부</th>
				<th scope="col">참석</th>
				<th scope="col">불참</th>
				<th scope="col">과정상태</th>
			</tr>
		</thead>
		<tbody> 
			<c:forEach var="resultList" items="${resultList}"  varStatus="status">
				<tr>
					<td><input type="checkbox" name="checkBox" class="typeCheck" value="${resultList.courseCd}" /></td>
					<td>${totalCount-((pageIndex-1) * pageSize + status.count)+1}</td> 
					<td class="title">
						<a href="#" onclick="javascript:goUserList('${resultList.courseCd}')">
							<c:if test="${resultList.todayType eq 'A'}"><font color="blue">[모집중]</font></c:if>[${resultList.orgName}] ${resultList.title}
						</a>
					</td>
					<td>${resultList.participant}</td>
					<td>${resultList.writecnt}</td>
					<td>${resultList.applycnt} </td>
					<td>${resultList.waitcnt} </td>
					<td>${resultList.acceptcnt} </td>
					<td>${resultList.denycnt} </td>
					<td>${resultList.attendcnt} </td>
					<td>${resultList.abcentcnt} </td>
					<td>${resultList.cdname} </td>
				</tr>
       		</c:forEach>
		</tbody>
	</table>
	
	<div class="page-num">
		<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" /> 
	</div>
</form>