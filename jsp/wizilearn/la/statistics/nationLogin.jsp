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
		var data = [];	
	</script>
	<style type="text/css">
		 #datePicker {width: 600px;z-index: 1000;}
		 #chartContainer	{background: #FFFFFF;z-index: -1;}
	</style>
</head>
<body>
	
 	<c:if test="${not empty list}">
	<c:set var="totalcnt" value="${list.get(0).totalcnt}" />
	<c:forEach var="dto" items="${list}" varStatus="status">
		<c:choose>
			<c:when test="${empty dto.nationDTO.natNameKr}">
				<c:set var="natName" value="${dto.nationDTO.natName}" />
			</c:when>
			<c:otherwise>
				<c:set var="natName" value="${dto.nationDTO.natNameKr}" />
			</c:otherwise>			
		</c:choose>
		<c:if test="${status.index < 10}">
		<script type="text/javascript">
			var _obj = {};	
			_obj.name = '${natName}';
		  	_obj.y = ${dto.ratio};
		  	_obj.drilldown = null;
		  	
	  	data.push(_obj);
	  	</script>
		</c:if>
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
        		<input type="text" name="sdate" id="sdate" maxlength="10" value="${ sDate }" readonly="readonly"/> ~
			<input type="text" name="edate" id="edate" maxlength="10" value="${ eDate }" readonly="readonly"/>&nbsp;&nbsp;&nbsp;&nbsp;
				<!-- <a href="javascript:saveExcel();"><img src="http://klink.websrv.co.kr/images/btn/btn_excel.gif" alt="엑셀로 저장" style="vertical-align:middle;"/></a> -->
		</li>
		<li>
			<a href="javascript:changeFromToDate(6);" class="sbtn16 ggrbt"><span>전체</span></a>
			<a href="javascript:changeFromToDate(2);" class="sbtn16 ggrbt"><span>1주</span></a>
			<a href="javascript:changeFromToDate(3);" class="sbtn16 ggrbt"><span>3개월</span></a>
			<a href="javascript:changeFromToDate(4);" class="sbtn16 ggrbt"><span>6개월</span></a>
			<a href="javascript:changeFromToDate(5);" class="sbtn16 ggrbt"><span>12개월</span></a>
		</li>
	</ul>
	<div class="search-btn-area">
		<!-- <a href="#fn_search" onclick="javascript:fn_search(); return false" onkeypress="this.onclick();">조회</a> -->
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
		<caption>국가별 로그인 현황</caption>
		<colgroup>
			<col style="width:8%" />
			<col style="width:auto%" />
			<col style="width:25%" />
			<col style="width:23%" />
			<col style="width:10%" />
			<col style="width:10%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">순위</th>
				<th scope="col">대륙</th>
				<th scope="col">국가(영문)</th>
				<th scope="col">국가(한글)</th>
				<th scope="col">건수</th>
				<th scope="col">비교율</th>
			</tr>
		</thead>
		<tbody>
		<c:choose>
			<c:when test="${not empty list}">
				<c:forEach var="dto" items="${list}">
					<tr>
						<td>${dto.rank }</td>
						<td>${dto.nationDTO.partName }</td>
						<td>${dto.nationDTO.natName }</td>
						<td>${dto.nationDTO.natNameKr }</td>
						<td>${dto.cnt }</td>
						<td>${dto.ratio }</td>
					</tr>
				</c:forEach>								
			</c:when>
			<c:otherwise>
				<tr>
					<td align="center" colspan="6"> 정보가 존재하지 않습니다. </td>
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
				$("#sdate").val(shiftDate(currentDate, 0, 0, 0),'.','-');
				$("#edate").val(shiftDate(currentDate, 0, 0, 0),'.','-');
			} else if (type == "2") { // 1주
				$("#sdate").val(shiftDate(currentDate, 0, 0, -7),'.','-');
				$("#edate").val(shiftDate(currentDate, 0, 0, 0),'.','-');
			} else if (type == "3") { // 3개월
				$("#sdate").val(shiftDate(currentDate, 0, -3, 0),'.','-');
				$("#edate").val(shiftDate(currentDate, 0, 0, 0),'.','-');
			} else if (type == "4") { // 6개월
				$("#sdate").val(shiftDate(currentDate, 0, -6, 0),'.','-');
				$("#edate").val(shiftDate(currentDate, 0, 0, 0),'.','-');
			} else if (type == "5") { // 1년
				$("#sdate").val(shiftDate(currentDate, -1, 0, 0),'.','-');
				$("#edate").val(shiftDate(currentDate, 0, 0, 0),'.','-');
			} else if (type == "6") { // 전체
				$("#type").val("ALL");
			}
			$("#statisticsFrm").attr("action","/la/statistics/nationLogin");
			$("#statisticsFrm").submit();
		}
		
		// 검색 버튼 이벤트
		$("#boardSearchBtn").click(function (){
			var sDate = com.replaceAll($("#sdate").val(),'-','');
			var eDate = com.replaceAll($("#edate").val(),'-','');
	
			if ( sDate > eDate ) {
				alert("시작일은 종료일보다 이전이어야 합니다.");
				$("#sdate").focus();
				return false;
			}
			$("#statisticsFrm").attr("action","/la/statistics/nationLogin");
			$("#statisticsFrm").submit();
		});
		
		// 엑셀저장
		function saveExcel(){
			var preTarget = document.statisticsFrm.target;
			document.statisticsFrm.action = '/la/statistics/nationLoginExcelDown';
			document.statisticsFrm.method = 'post';
			//paramForm.target = 'hiddenFrame';
			document.statisticsFrm.submit();
			document.statisticsFrm.target = preTarget;
		}
		
		function fn_excel(){
			var reqUrl = "/la/statistics/nationLoginExcelDown";
			$("#statisticsFrm").attr("action", reqUrl);
			$("#statisticsFrm").attr("target", "_blank");
			$("#statisticsFrm").submit();
		}
		
		
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
			Highcharts.setOptions({lang: {noData: "Your custom message"}});
			if(data.length > 0) {
			    $('#chartDiv').highcharts({
			        chart: {
						zoomType: 'xy',
			            type: 'column'
			        },
			        title: {
			            text: null
			        },
			        subtitle: {
			            text: '전체 국가별 로그인 통계'
			        },
			        xAxis: {
			            type: 'category'
			        },
			        yAxis: {
			            title: {
			                text: null
			            }
			        },
					scrollbar: {
						enabled: true
					},
			        legend: {
			            enabled: false 
			        },
			        plotOptions: {
			            series: {
			            	name: null,
			                borderWidth: 0,
			                dataLabels: {
			                    enabled: true,
			                    format: '{point.y:.1f}%'
			                }
			            }
			        },
			        tooltip: {
			            pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}%</b><br/>'
			        },
			        series: [{
			            colorByPoint: true,
			            data: data
			        }]
			    });
			} else {
				$('#chartDiv').highcharts({
					chart: {
						plotBackgroundColor: null,
						plotBorderWidth: null,
						plotShadow: false
					},
					title: {
						text: 'No data to display',
						style: {
			                color: '#60606a',
			                fontWeight: 'bold',
			                verticalAlign: 'middle'
			            }
					}
					
				});
			}
		});
	//]]>
	</script>
