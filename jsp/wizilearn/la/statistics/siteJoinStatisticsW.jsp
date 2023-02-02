<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Iterator"%>
<%@page import="kr.co.wizi.wizilearn.la.statistics.vo.StatisticsVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<%
//통계정보
List listStatistics = (List)request.getAttribute( "resultList" );
StatisticsVO statisticsVO = new StatisticsVO();

StatisticsVO statisticsVO1 = null;
if(listStatistics.size() != 0){
	for(int a = 0 ; a < listStatistics.size(); a++){
		if(listStatistics.get(a) != null && !"".equals(listStatistics.get(a))){
			statisticsVO1 =  (StatisticsVO)listStatistics.get(a);
			break;
		}
	}
}

HashMap data = new HashMap();

for(int i=0;i<listStatistics.size();i++){
	statisticsVO = (StatisticsVO)listStatistics.get(i);
	data.put(statisticsVO.getxArea(),statisticsVO.getyCnt());
}

String dataXML = "";

//그래프 높이
int rowHight = 500;

if(listStatistics != null){

	StringBuffer dateStr = new StringBuffer();

	if(data.containsKey("1")){
		dateStr.append(",[\"일요일\" ,"+data.get("1")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"일요일\" ,0,\"gold\"  ]");
	}
	if(data.containsKey("2")){
		dateStr.append(",[\"월요일\" ,"+data.get("2")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"월요일\" ,0 ,\"gold\"  ]");
	}
	if(data.containsKey("3")){
		dateStr.append(",[\"화요일\" ,"+data.get("3")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"화요일\" ,0 ,\"gold\"  ]");
	}
	if(data.containsKey("4")){
		dateStr.append(",[\"수요일\" ,"+data.get("4")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"수요일\" ,0 ,\"gold\"  ]");
	}
	if(data.containsKey("5")){
		dateStr.append(",[\"목요일\" ,"+data.get("5")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"목요일\" ,0 ,\"gold\"  ]");
	}
	if(data.containsKey("6")){
		dateStr.append(",[\"금요일\" ,"+data.get("6")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"금요일\" ,0 ,\"gold\"  ]");
	}
	if(data.containsKey("7")){
		dateStr.append(",[\"토요일\" ,"+data.get("7")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"토요일\" ,0 ,\"gold\"  ]");
	}
	
	dataXML = dateStr.toString();
}


%>

<%--
  ~ *******************************************************************************
  ~  * COPYRIGHT(C) 2016 WIZI LEARN ALL RIGHTS RESERVED.
  ~  * This software is the proprietary information of WIZI LEARN.
  ~  *
  ~  * Revision History
  ~  * Author   Date            Description
  ~  * ------   ----------      ------------------------------------
  ~  * 위지런C    2016. 10. 27 오후 1:20         Modify Draft.
  ~  *
  ~  *******************************************************************************
 --%>
<script type="text/javascript" src='/js/loader.js'></script>

<c:set var="targetUrl" value="/la/statistics/"/>


<script type="text/javascript">
	<!--
	var targetUrl = "${targetUrl}";
	
	$(document).ready(function() {
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
	}


	/*====================================================================
		사용자 정의 함수 
	====================================================================*/
	function press(event) {
		if (event.keyCode==13) {
			fn_search();
		}
	}

	/* 리스트 조회 */
	function fn_search(){
		var reqUrl = CONTEXT_ROOT + targetUrl + "listSiteJoinStatistics";
		$("#frmStat").attr("action", reqUrl);
		$("#frmStat").submit();
	}
	
	/* 기타탭 조회 */
	function fn_moveSiteJoin( searchType ){
		$("#searchType").val( searchType );
		var reqUrl = CONTEXT_ROOT + targetUrl + "listSiteJoinStatistics";
		$("#frmStat").attr("action", reqUrl);
		$("#frmStat").submit();
	}

	/* 엑셀 다운로드 */
	function fn_exclDownload(){
		var reqUrl = CONTEXT_ROOT + targetUrl + "listSiteJoinStatisticsExcelDownload";
		$("#frmStat").attr("action", reqUrl);
		$("#frmStat").attr("target","_self");
		$("#frmStat").submit();
	}
	//-->
</script>

<script type="text/javascript">
    google.charts.load("current", {packages:['corechart']});
    google.charts.setOnLoadCallback(drawChart);
    function drawChart() {
      var data = google.visualization.arrayToDataTable([
        ["Element", "접속수", { role: "style" } ]        
        <%=dataXML %>        
      ]);

      var view = new google.visualization.DataView(data);
      view.setColumns([0, 1,
                       { calc: "stringify",
                         sourceColumn: 1,
                         type: "string",
                         role: "annotation" },
                       2]);

      var options = {
        title: "요일별 접속수",
        width: 1250,
        height: <%=rowHight%>,
        bar: {groupWidth: "60%"},
        legend: { position: "none" },
      };
      var chart = new google.visualization.ColumnChart(document.getElementById("flash02"));
      chart.draw(view, options);
  }
</script>

<form name="frmStat" id="frmStat" method="post">
	<input type="hidden" name="searchType" id="searchType" value="W"/>
	
	<ul id="view-tab-1">
		<li class="tab-name-11"><a href="#fn_moveSiteJoin" onclick="fn_moveSiteJoin('T');">시간대 별</a></li>
		<!--li class="tab-name-12"><a href="#fn_moveSiteJoin" onclick="fn_moveSiteJoin('D');">일 별</a></li -->
		<li class="tab-name-12 on"><a href="#fn_moveSiteJoin">요일 별</a></li>
		<li class="tab-name-13"><a href="#fn_moveSiteJoin" onclick="fn_moveSiteJoin('M');">월 별</a></li>
		<li class="tab-name-14"><a href="#fn_moveSiteJoin" onclick="fn_moveSiteJoin('S');">기간별</a></li>
	</ul>
	
	<c:set var="now" value="<%=new java.util.Date()%>"/>
	<fmt:formatDate var="nowDate" value="${now}" pattern="yyyyMMdd"/>
	
	<ul class="search-list-1">
		<li>
			<span>조회기간</span>
			년도 : <select name="searchYear" id="searchYear" class="form_03" title="년도를 선택하세요">
					<c:choose>
						<c:when test="${empty param.searchYear}">
							<c:forEach var="yearVal" begin="2017" end="2025" varStatus="status">
								<c:choose>
									<c:when test="${ fn:substring(nowDate,0,4)  eq yearVal  }">
										<option value="${yearVal }" selected>${yearVal }년</option>
									</c:when>
									<c:otherwise>
										<option value="${yearVal }" >${yearVal }년</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:forEach var="yearVal" begin="2017" end="2025" varStatus="status">
								<c:choose>
									<c:when test="${ param.searchYear  eq yearVal  }">
										<option value="${yearVal }" selected>${yearVal }년</option>
									</c:when>
									<c:otherwise>
										<option value="${yearVal }" >${yearVal }년</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</select>&nbsp;
				월 :
				<select name="searchMonth" id="searchMonth"  class="form_03" title="월을 선택하세요">
					<c:choose>
						<c:when test="${empty param.searchMonth}">
							<option value=""></option>
							<c:choose>
								<c:when test="${ fn:substring(nowDate,4,6)  eq '01'  }">
									<option value="01" selected>1월</option>
								</c:when>
								<c:otherwise>
									<option value="01" >1월</option>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${ fn:substring(nowDate,4,6)  eq '02'  }">
									<option value="02" selected>2월</option>
								</c:when>
								<c:otherwise>
									<option value="02" >2월</option>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${ fn:substring(nowDate,4,6)  eq '03'  }">
									<option value="03" selected>3월</option>
								</c:when>
								<c:otherwise>
									<option value="03" >3월</option>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${ fn:substring(nowDate,4,6)  eq '04'  }">
									<option value="04" selected>4월</option>
								</c:when>
								<c:otherwise>
									<option value="04" >4월</option>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${ fn:substring(nowDate,4,6)  eq '05'  }">
									<option value="05" selected>5월</option>
								</c:when>
								<c:otherwise>
									<option value="05" >5월</option>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${ fn:substring(nowDate,4,6)  eq '06'  }">
									<option value="06" selected>6월</option>
								</c:when>
								<c:otherwise>
									<option value="06" >6월</option>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${ fn:substring(nowDate,4,6)  eq '07'  }">
									<option value="07" selected>7월</option>
								</c:when>
								<c:otherwise>
									<option value="07" >7월</option>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${ fn:substring(nowDate,4,6)  eq '08'  }">
									<option value="08" selected>8월</option>
								</c:when>
								<c:otherwise>
									<option value="08" >8월</option>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${ fn:substring(nowDate,4,6)  eq '09'  }">
									<option value="09" selected>9월</option>
								</c:when>
								<c:otherwise>
									<option value="09" >9월</option>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${ fn:substring(nowDate,4,6)  eq '10'  }">
									<option value="10" selected>10월</option>
								</c:when>
								<c:otherwise>
									<option value="10" >10월</option>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${ fn:substring(nowDate,4,6)  eq '11'  }">
									<option value="11" selected>11월</option>
								</c:when>
								<c:otherwise>
									<option value="11" >11월</option>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${ fn:substring(nowDate,4,6)  eq '12'  }">
									<option value="12" selected>12월</option>
								</c:when>
								<c:otherwise>
									<option value="12" >12월</option>
								</c:otherwise>
							</c:choose>
	
						</c:when>
						<c:otherwise>
							<option value=""></option>
							<c:choose>
								<c:when test="${ param.searchMonth  eq '01'  }">
									<option value="01" selected>1월</option>
								</c:when>
								<c:otherwise>
									<option value="01" >1월</option>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${ param.searchMonth  eq '02'  }">
									<option value="02" selected>2월</option>
								</c:when>
								<c:otherwise>
									<option value="02" >2월</option>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${ param.searchMonth  eq '03'  }">
									<option value="03" selected>3월</option>
								</c:when>
								<c:otherwise>
									<option value="03" >3월</option>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${ param.searchMonth  eq '04'  }">
									<option value="04" selected>4월</option>
								</c:when>
								<c:otherwise>
									<option value="04" >4월</option>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${ param.searchMonth  eq '05'  }">
									<option value="05" selected>5월</option>
								</c:when>
								<c:otherwise>
									<option value="05" >5월</option>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${ param.searchMonth  eq '06'  }">
									<option value="06" selected>6월</option>
								</c:when>
								<c:otherwise>
									<option value="06" >6월</option>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${ param.searchMonth  eq '07'  }">
									<option value="07" selected>7월</option>
								</c:when>
								<c:otherwise>
									<option value="07" >7월</option>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${ param.searchMonth  eq '08'  }">
									<option value="08" selected>8월</option>
								</c:when>
								<c:otherwise>
									<option value="08" >8월</option>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${ param.searchMonth  eq '09'  }">
									<option value="09" selected>9월</option>
								</c:when>
								<c:otherwise>
									<option value="09" >9월</option>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${ param.searchMonth  eq '10'  }">
									<option value="10" selected>10월</option>
								</c:when>
								<c:otherwise>
									<option value="10" >10월</option>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${ param.searchMonth  eq '11'  }">
									<option value="11" selected>11월</option>
								</c:when>
								<c:otherwise>
									<option value="11" >11월</option>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${ param.searchMonth  eq '12'  }">
									<option value="12" selected>12월</option>
								</c:when>
								<c:otherwise>
									<option value="12" >12월</option>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</select>
		</li>
	</ul><!-- E : search-list-1 -->
	<div class="search-btn-area">
		<a href="#fn_search" onclick="javascript:fn_search(); return false" onkeypress="this.onclick();">조회</a>
	</div>
	
	<ul class="board-info">
		<li class="btn-area">
			<a href="#fn_exclDownload" onclick="javascript:fn_exclDownload( ); return false" onkeypress="this.onclick;" class="btn">엑셀다운로드</a>					
		</li>
	</ul><!-- E : board-info -->
	
<table border="0" cellpadding="0" cellspacing="0" class="list-1">
  <tr>
  	<td>
			<div id="flash02" style="width: 1250px; height: <%=rowHight%>px;">
				
			</div>
  	</td>
  </tr>
</table>
</form>
