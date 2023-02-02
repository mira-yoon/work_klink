<%
/******************************************************************
*   @ 화면명		: KOALP - ADMIN - 통계관리 - 국가별 로그인 통계
*   @ JSP NAME	: /pages/admin/statistics/statistics01.jsp
*   @ JSP작성자	: 김나리
*   @ 소속		: 4DEPTH
*   @ 작성일		: 2012.09.19
*   @ 작업이력	: 
********************************************************************/
%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
	<script type="text/javascript" src="/js/Highstock-2.1.9/js/highstock.js"></script>
	<script type="text/javascript" src="/js/Highcharts-4.1.9/js/modules/exporting.js"></script>
	<style type="text/css">
		 #datePicker {width: 600px;z-index: 1000;}
		 #chartContainer	{background: #FFFFFF;z-index: -1;}
	</style>
</head>
<body>
	<c:set var="now" value="<%=new java.util.Date()%>"/>
	<fmt:formatDate var="nowDate" value="${now}" pattern="yyyy"/>
    <fmt:formatNumber value="${nowDate}" type="number" pattern="0000" var="nowDateNumberType" />
	<!-- 검색 조건 영역 -->
	<form name="statisticsFrm" id="statisticsFrm" action="/la/statistics/trainingCourse" target="_self" method="post" >
	<input type="hidden" name="type" id="type" value="${type}"/>
                 <!-- 0909 수정 (s) -->
	<ul class="search-list-1">
		<li>
			<span>년도</span>
			<select name="sdate" id="sdate" class="searchYear">
				<option value="">전체</option>
				<c:forEach var="yearVal" begin="0" end="20" varStatus="status">
				    <c:set var="yearValStr" value="${nowDateNumberType-yearVal}" />
					<c:choose>
						<c:when test="${sDate eq yearValStr}">
							<option value="${yearValStr }" selected>${yearValStr }년</option>
						</c:when>
						<c:otherwise>
							<option value="${yearValStr }" >${yearValStr }년</option>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</select>
		</li>
	</ul>
	<div class="search-btn-area">
		<a href="#fn_search" id='boardSearchBtn' class="type" alt="검색">조회</a>
	</div>
	
    </form>
	<!-- //검색 조건 영역 -->
          <br/>
	<!-- 통계 차트 영역 -->
          <!-- <div id="chartDiv" class="chartContainer" style="width:99.5%; height:250px; margin-bottom:10px; border:1px solid #e0e0e0;overflow:hidden;overflow-x:auto;"></div> -->
	<!-- //통계 차트 영역 -->
	
	<!-- 통계 목록 영역 -->
	<ul class="board-info">
		<li class="info-area">
			<span>전체 : </span> <c:out value="${totalCnt}" /> 건
		</li>
		<li class="btn-area">
			<a href="#fn_exclDownload" onclick="fn_excel()" class="btn">엑셀다운로드</a>					
		</li>
	</ul>
	<table border="0" cellpadding="0" cellspacing="0" class="list-1">
		<caption>국가별 초청연수 현황</caption>
		<colgroup>
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
				<th scope="col">년도</th>
				<th scope="col">과정명</th>
				<th scope="col">모집인원</th>
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
		<c:choose>
			<c:when test="${not empty resultList}">
				<c:forEach var="result" items="${resultList}">
					<tr>
						<td>${result.courseYear}</td>
						<td>${result.title}</td>
						<td>${result.participant}</td>
						<td>${result.writecnt}</td>
						<td>${result.applycnt}</td>
						<td>${result.waitcnt}</td>
						<td>${result.acceptcnt}</td>
						<td>${result.denycnt}</td>
						<td>${result.attendcnt}</td>
						<td>${result.abcentcnt}</td>
						<td>${result.cdname}</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td align="center" colspan="11"> 정보가 존재하지 않습니다. </td>
				</tr>
			</c:otherwise>
		</c:choose>
		</tbody>
	</table>
	<!-- //통계 목록 영역 -->
				
	<script type="text/javascript">
		// 검색 버튼 이벤트
		$("#boardSearchBtn").click(function (){
			$("#statisticsFrm").attr("action","/la/statistics/trainingCourse");
			$("#statisticsFrm").submit();
		});
		
		function fn_excel(){
			var reqUrl = "/la/statistics/trainingCourseExcelDown";
			$("#statisticsFrm").attr("action", reqUrl);
			$("#statisticsFrm").attr("target", "_blank");
			$("#statisticsFrm").submit();
		}
	</script>
