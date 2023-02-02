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
	<script type="text/javascript">
		var cate = [];		
		var data1 = [];
		var data2 = [];
		var data3 = []; 
		var data4 = [];	
	</script>
	<style type="text/css">
		 #datePicker {width: 600px;z-index: 1000;}
		 #chartContainer	{background: #FFFFFF;z-index: -1;}
	</style>
</head>
<body>
	
 	<c:if test="${not empty list}">
	<c:set var="totalcnt" value="${list.get(0).totalcnt}" />
	<c:forEach var="result" items="${list}" varStatus="status">
		<c:choose>
			<c:when test="${'D' eq termType}">
				<script type="text/javascript">
					cate.push('${fn:substring(result.LOGIN_DATE,5,10)}');
				</script>
			</c:when>
			<c:otherwise>
				<script type="text/javascript">
					cate.push('${result.LOGIN_DATE}');
				</script>
			</c:otherwise>
		</c:choose>
	<script type="text/javascript">
		data1.push(${result.CNT });	
		data2.push(${result.UT01 });
		data3.push(${result.UT02 });
		data4.push(${result.UT03 });	
 	</script>
	</c:forEach>
	</c:if> 
	
	
	<!-- 검색 조건 영역 -->
	<form name="statisticsFrm" id="statisticsFrm" action="statistics01.jsp" target="_self" method="post" >
	<input type="hidden" name="type" id="type" value="${type}"/>
                 <!-- 0909 수정 (s) -->
	<ul class="search-list-1">
		<li>
			<span>대륙구분</span>
			<select name="npCd" class="selectype form_03">
				${npCdSelectBox }
			</select>
			<span>국가구분</span>
			<select name="ntCd" class="selectype form_03">
				${ntCdSelectBox }
			</select>
			<span style="width:60px;">기간설정</span>
			<select id="termType" name="termType" style="width:70px;" onchange="selectPeriodDisplay(this.value);">
				<option value="D" <c:if test="${'D' eq termType }">selected="selected"</c:if> >일별</option>
				<option value="M" <c:if test="${'M' eq termType }">selected="selected"</c:if> >월별</option>
				<option value="Y" <c:if test="${'Y' eq termType }">selected="selected"</c:if> >년도별</option>
			</select>
        	<input type="text" name="sdate" id="sdate" maxlength="10" value="${ sDate }" readonly="readonly"/> ~
			<input type="text" name="edate" id="edate" maxlength="10" value="${ eDate }" readonly="readonly"/>&nbsp;&nbsp;&nbsp;&nbsp;
		</li>
		<li>
			<a href="javascript:changeFromToDate(6);" class="sbtn16 ggrbt daySe"><span>전체</span></a> 
			<a href="javascript:changeFromToDate(7);" class="sbtn16 ggrbt daySe"><span>1주</span></a> 
			<a href="javascript:changeFromToDate(8);" class="sbtn16 ggrbt daySe"><span>2주</span></a> 
			<a href="javascript:changeFromToDate(9);" class="sbtn16 ggrbt daySe"><span>1달</span></a> 

			<a href="javascript:changeFromToDate(6);" class="sbtn16 ggrbt monthSe"><span>전체</span></a> 
			<a href="javascript:changeFromToDate(3);" class="sbtn16 ggrbt monthSe"><span>3개월</span></a> 
			<a href="javascript:changeFromToDate(4);" class="sbtn16 ggrbt monthSe"><span>6개월</span></a> 
			<a href="javascript:changeFromToDate(5);" class="sbtn16 ggrbt monthSe"><span>12개월</span></a> 

			<a href="javascript:changeFromToDate(6);" class="sbtn16 ggrbt yearSe"><span>전체</span></a> 
			<a href="javascript:changeFromToDate(5);" class="sbtn16 ggrbt yearSe"><span>1년</span></a> 
			<a href="javascript:changeFromToDate(10);" class="sbtn16 ggrbt yearSe"><span>2년</span></a> 
			<a href="javascript:changeFromToDate(11);" class="sbtn16 ggrbt yearSe"><span>3년</span></a> 
			<a href="javascript:changeFromToDate(12);" class="sbtn16 ggrbt yearSe"><span>5년</span></a> 
		</li>
	</ul>
	<div class="search-btn-area">
		<a href="#fn_search" id='boardSearchBtn' class="type" alt="검색">조회</a>
	</div>
	
    </form>
	<!-- //검색 조건 영역 -->
          <br/>
	<!-- 통계 차트 영역 -->
          <div id="chartDiv" class="chartContainer" style="width:99.5%; height:250px; margin-bottom:10px; border:1px solid #e0e0e0;overflow:hidden;overflow-x:auto;"></div>
	<!-- //통계 차트 영역 -->
	
	<!-- 통계 목록 영역 -->
	<ul class="board-info">
		<li class="info-area">
			<span>전체 : </span> <c:out value="${totalcnt}" /> 건
		</li>
		<li class="btn-area">
			<a href="#fn_exclDownload" onclick="fn_excel()" class="btn">엑셀다운로드</a>					
		</li>
	</ul>
	<table border="0" cellpadding="0" cellspacing="0" class="list-1">
		<caption>기간별 로그인 현황</caption>
		<colgroup>
			<col style="width:20%" />
			<col style="width:20%" />
			<col style="width:20%" />
			<col style="width:20%" />
			<col style="width:20%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col" rowspan="2" >기간</th>
				<th scope="col" colspan="2">회원구분</th>
				<th scope="col" rowspan="2">합계</th>
			</tr>
			<tr>
				<th scope="col">관리자</th>
				<th scope="col">일반</th>
			</tr>
		</thead>
		<tbody>
		<c:choose>
			<c:when test="${not empty list}">
				<c:forEach var="result" items="${list}">
					<tr>
						<td>${result.LOGIN_DATE }</td>
						<td>${result.UT01 }</td>
						<td>${result.UT03 }</td>
						<td>${result.CNT }</td>
					</tr>
				</c:forEach>								
			</c:when>
			<c:otherwise>
				<tr>
					<td align="center" colspan="4"> 정보가 존재하지 않습니다. </td>
				</tr>
			</c:otherwise>
		</c:choose>
		</tbody>
	</table>
	<!-- //통계 목록 영역 -->
				
	<script type="text/javascript">
	//<![CDATA[
		$(document).ready(function(){
			// 달력 설정
			com.datepicker("sdate");
			com.datepicker("edate");
		});
	
		// 조회기간 설정
		function changeFromToDate(type) {
			var currentDate = '${currentDate}';
			console.log(currentDate);
			console.log(shiftDate(currentDate, 0, 0, -7));
			$("#type").val("");
			if (type == "1") { //당일
				$("#sdate").val(shiftDate(currentDate, 0, 0, 0));
				$("#edate").val(shiftDate(currentDate, 0, 0, 0));
			} else if (type == "2") { // 1주
				$("#sdate").val(shiftDate(currentDate, 0, 0, -7));
				$("#edate").val(shiftDate(currentDate, 0, 0, 0));
			} else if (type == "3") { // 3개월
				$("#sdate").val(shiftDate(currentDate, 0, -3, 0));
				$("#edate").val(shiftDate(currentDate, 0, 0, 0));
			} else if (type == "4") { // 6개월
				$("#sdate").val(shiftDate(currentDate, 0, -6, 0));
				$("#edate").val(shiftDate(currentDate, 0, 0, 0));
			} else if (type == "5") { // 1년
				$("#sdate").val(shiftDate(currentDate, -1, 0, 0));
				$("#edate").val(shiftDate(currentDate, 0, 0, 0));
			} else if (type == "6") { // 전체
				$("#type").val("ALL");
			} else if( type == '7') { // 1주
				$("#sdate").val(shiftDate(currentDate, 0, 0, -7));
				$("#edate").val(shiftDate(currentDate, 0, 0, 0));
			} else if( type == '8') { // 2주
				$("#sdate").val(shiftDate(currentDate, 0, 0, -14));
				$("#edate").val(shiftDate(currentDate, 0, 0, 0));
			} else if( type == '9') {  // 1달
				$("#sdate").val(shiftDate(currentDate, 0, -1, 0));
				$("#edate").val(shiftDate(currentDate, 0, 0, 0));
			} else if( type == '10') { // 2년
				$("#sdate").val(shiftDate(currentDate, -2, 0, 0));
				$("#edate").val(shiftDate(currentDate, 0, 0, 0));
			} else if( type == '11') { // 3년
				$("#sdate").val(shiftDate(currentDate, -3, 0, 0));
				$("#edate").val(shiftDate(currentDate, 0, 0, 0));
			} else if( type == '12') { // 5년
				$("#sdate").val(shiftDate(currentDate, -5, 0, 0));
				$("#edate").val(shiftDate(currentDate, 0, 0, 0));
			}
			$("#statisticsFrm").attr("action","/la/statistics/dateLogin");
			$("#statisticsFrm").submit();
		}
		
		// 검색 버튼 이벤트
		$("#boardSearchBtn").click(function (){
			var sDate = com.replaceAll($("#sdate").val(),'-','');
			var eDate = com.replaceAll($("#edate").val(),'-','');
			var type  = $("#termType").val();
	
			if ( sDate > eDate ) {
				alert("시작일은 종료일보다 이전이어야 합니다.");
				$("#sdate").focus();
				return false;
			}
			
			if ( type == 'D' ) {
				var betweenDay = getBetweenDay($("#sdate").val(), $("#edate").val());
				if ( betweenDay >= 31 ) {
					alert("일별 접속통계 기간설정은 한달을 넘을 수 없습니다.");
					$("#sDate", "#statisticsFrm").focus();
					return false;
				}
			}
			if ( type == 'M' ) {
				var betweenDay = getBetweenDay($("#sdate").val(), $("#edate").val());
				if ( betweenDay > 365 ) {
					alert("월별 접속통계 기간설정은 일년을 넘을 수 없습니다.");
					$("#sDate", "#statisticsFrm").focus();
					return false;
				}
			}
			
			$("#statisticsFrm").attr("action","/la/statistics/dateLogin");
			$("#statisticsFrm").submit();
		});
		
		// 조회기간 검증
		function getBetweenDay(sDate, eDate) {
			var sDateArray = sDate.split("-");
			var eDateArray = eDate.split("-");
			
			var sDateObj = new Date(sDateArray[0], Number(sDateArray[1])-1, sDateArray[2]);
			var eDateObj = new Date(eDateArray[0], Number(eDateArray[1])-1, eDateArray[2]);
			
			var betweenDay = (eDateObj.getTime() - sDateObj.getTime())/1000/60/60/24;
			return betweenDay;
		}
		
		function fn_excel(){
			var reqUrl = "/la/statistics/dateLoginExcelDown";
			$("#statisticsFrm").attr("action", reqUrl);
			$("#statisticsFrm").attr("target", "_blank");
			$("#statisticsFrm").submit();
		}
		
		function selectPeriodDisplay(val) {
			if(val == 'D') {
				displayPeriod('daySe');		
			} else if(val == 'M') {
				displayPeriod('monthSe');		
			} else if(val == 'Y') {
				displayPeriod('yearSe');		
			}
		}
		
		function displayPeriod(elmClassName) {
			$('.ggrbt').css('display', 'none');
			$('.' + elmClassName).css('display', '');
		}
		
		$(function() {
			selectPeriodDisplay('${termType}');
		});
				
		/**
		 * 왼쪽 공백 채우기
		 */
		function lpad(str,n,ch) {
			str = String(str);
			var result = "";
			var len = str.length;
			if ( len < n ) {
				for ( var i=0; i<(n-len); i++ ) {
				result += ch;
				}
				result += str;
			}
			else {
			result = str;
			}
			return result;
		}
		
		/**
		 *    날짜를 y, m, d만큼 이동해서 리턴 (dt : YYYYMMDD(문자열), 리턴타입 : YYYYMMDD)
		 *    y, m, d : +는 주어진 날짜를 앞으로 이동(더하기), -는 주어진 날짜를 뒤로 이동(빼기)
		 *    
		 */
		function shiftDate(dt,y,m,d) {
		    var org_dt = new Date();
		    var yy = dt.substr(0, 4);
		    var mm = dt.substr(4, 2);
		    var dd = dt.substr(6, 2);

		    org_dt.setYear(yy);   
		    org_dt.setMonth(mm-1);
		    org_dt.setDate(dd);

		    var new_dt = org_dt;
		    new_dt.setDate(org_dt.getDate() + d);
		    new_dt.setMonth(new_dt.getMonth() + m);
		    new_dt.setYear(new_dt.getFullYear() + y);

		    var n_yy  = new_dt.getFullYear();
		    var n_mm = new_dt.getMonth()+1; 
		    var n_dd   = new_dt.getDate();

		    if (("" + n_mm).length == 1)     { n_mm = "0" + n_mm;     }
		    if (("" + n_dd).length   == 1)     { n_dd = "0" + n_dd;  }

		    return ""+n_yy+"-"+n_mm+"-"+n_dd;
		}
		
		$(function () {
		    $('#chartDiv').highcharts({
		        chart: {
		            type: 'line',
		            zoomType: 'xy'
		        },
		        title: {
		            text: null
		        },
		        subtitle: {
		            text: ''
		        },
		        xAxis: {
		            categories: cate 
		        },
		        yAxis: {
		            title: {
		                text: null
		            }
		       },
				scrollbar: {
					enabled: true
				},
		        plotOptions: {
		            spline: {
		                marker: {
		                    enabled: true
		                }
		            }
		        },
		        series: [{
		            name: '전체',
		            data: data1
		        }, {
		            name: '관리자',
		            data: data2
		        }, {
		            name: '일반',
		            data: data4
		        }]
		    });
		});
	//]]>
	</script>
