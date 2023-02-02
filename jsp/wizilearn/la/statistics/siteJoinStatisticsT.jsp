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

	if(data.containsKey("00")){
		dateStr.append(",[\"00시\" ,"+data.get("00")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"00시\" ,0,\"gold\"  ]");
	}
	if(data.containsKey("01")){
		dateStr.append(",[\"01시\" ,"+data.get("01")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"01시\" ,0 ,\"gold\"  ]");
	}
	if(data.containsKey("02")){
		dateStr.append(",[\"02시\" ,"+data.get("02")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"02시\" ,0 ,\"gold\"  ]");
	}
	if(data.containsKey("03")){
		dateStr.append(",[\"03시\" ,"+data.get("03")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"03시\" ,0 ,\"gold\"  ]");
	}
	if(data.containsKey("04")){
		dateStr.append(",[\"04시\" ,"+data.get("04")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"04시\" ,0 ,\"gold\"  ]");
	}
	if(data.containsKey("05")){
		dateStr.append(",[\"05시\" ,"+data.get("05")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"05시\" ,0 ,\"gold\"  ]");
	}
	if(data.containsKey("06")){
		dateStr.append(",[\"06시\" ,"+data.get("06")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"06시\" ,0 ,\"gold\"  ]");
	}
	if(data.containsKey("07")){
		dateStr.append(",[\"07시\" ,"+data.get("07")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"07시\" ,0 ,\"gold\"  ]");
	}
	if(data.containsKey("08")){
		dateStr.append(",[\"08시\" ,"+data.get("08")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"08시\" ,0,\"gold\"  ]");
	}
	if(data.containsKey("09")){
		dateStr.append(",[\"09시\" ,"+data.get("09")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"09시\" ,0,\"gold\"  ]");
	}
	if(data.containsKey("10")){
		dateStr.append(",[\"10시\" ,"+data.get("10")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"10시\" ,0 ,\"gold\"  ]");
	}
	if(data.containsKey("11")){
		dateStr.append(",[\"11시\" ,"+data.get("11")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"11시\" ,0 ,\"gold\"  ]");
	}
	if(data.containsKey("12")){
		dateStr.append(",[\"12시\" ,"+data.get("12")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"12시\" ,0,\"gold\"  ]");
	}
	if(data.containsKey("13")){
		dateStr.append(",[\"13시\" ,"+data.get("13")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"13시\" ,0,\"gold\"  ]");
	}
	if(data.containsKey("14")){
		dateStr.append(",[\"14시\" ,"+data.get("14")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"14시\" ,0,\"gold\"  ]");
	}
	if(data.containsKey("15")){
		dateStr.append(",[\"15시\" ,"+data.get("15")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"15시\" ,0,\"gold\"  ]");
	}
	if(data.containsKey("16")){
		dateStr.append(",[\"16시\" ,"+data.get("16")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"16시\" ,0,\"gold\"  ]");
	}
	if(data.containsKey("17")){
		dateStr.append(",[\"17시\" ,"+data.get("17")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"17시\" ,0,\"gold\"  ]");
	}
	if(data.containsKey("18")){
		dateStr.append(",[\"18시\" ,"+data.get("18")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"18시\" ,0,\"gold\"  ]");
	}
	if(data.containsKey("19")){
		dateStr.append(",[\"19시\" ,"+data.get("19")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"19시\" ,0,\"gold\"  ]");
	}
	if(data.containsKey("20")){
		dateStr.append(",[\"20시\" ,"+data.get("20")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"20시\" ,0,\"gold\"  ]");
	}
	if(data.containsKey("21")){
		dateStr.append(",[\"21시\" ,"+data.get("21")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"21시\" ,0,\"gold\"  ]");
	}
	if(data.containsKey("22")){
		dateStr.append(",[\"22시\" ,"+data.get("22")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"22시\" ,0,\"gold\"  ]");
	}
	if(data.containsKey("23")){
		dateStr.append(",[\"23시\" ,"+data.get("23")+" ,\"gold\"  ]");
	}else{
		dateStr.append(",[\"23시\" ,0,\"gold\"  ]");
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
		com.datepicker('searchStartDate');
 	    com.datepicker('searchEndDate');
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
	
	/* 엑셀 다운로드 */
	function fn_exclDownload(){
		var reqUrl = CONTEXT_ROOT + targetUrl + "listSiteJoinStatistics";
		$("#pageType").val( "excel" )
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
        title: "시간대별 접속수",
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
	<input type="hidden" 	name="searchType" 	id="searchType" value="T"/>
	<input type="hidden" 	name="pageType" 		id="pageType"/>
	<input type="hidden" 	name="searchMonth" 	id="searchMonth" value="${statisticsVO.searchMonth}"/>
	<input type="hidden" 	name="searchYear" 	id="searchYear" value="${statisticsVO.searchYear}"/>
	
	<ul id="view-tab-1">
		<li class="tab-name-11 on"><a href="#fn_moveSiteJoin">시간대 별</a></li>
		<!-- li class="tab-name-12"><a href="#fn_moveSiteJoin" onclick="fn_moveSiteJoin('D');">일 별</a></li -->
		<li class="tab-name-12"><a href="#fn_moveSiteJoin" onclick="fn_moveSiteJoin('W');">요일 별</a></li>
		<li class="tab-name-13"><a href="#fn_moveSiteJoin" onclick="fn_moveSiteJoin('M');">월 별</a></li>
		<li class="tab-name-14"><a href="#fn_moveSiteJoin" onclick="fn_moveSiteJoin('S');">기간별</a></li>
	</ul>
	<ul class="search-list-1">
		<li>
			<span>조회기간</span>
			<input type="text" id="searchStartDate" name="searchStartDate"  value="${statisticsVO.searchStartDate}"  style="width:80px" /> ~
			<input type="text" id="searchEndDate" name="searchEndDate"   value="${statisticsVO.searchEndDate}"  style="width:80px" />
		</li>
	</ul><!-- E : search-list-1 -->
	<div class="search-btn-area">
		<a href="#fn_search" onclick="javascript:fn_search(); return false" onkeypress="this.onclick();">조회</a>
	</div>
	
	<ul class="board-info">
		<li class="btn-area">
			<a href="#fn_exclDownload" onclick="javascript:fn_exclDownload(); return false" onkeypress="this.onclick;" class="btn">엑셀다운로드</a>					
		</li>
	</ul><!-- E : board-info -->
	
<table border="0" cellpadding="0" cellspacing="0" class="list-1">
  <tr>
  	<td>
			<div id="flash02"  style="width: 1250px; height: <%=rowHight%>px;">
			</div>
  	</td>
  </tr>
</table>
</form>
<!--리스트 끝 -->