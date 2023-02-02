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
if(listStatistics!=null && listStatistics.size() != 0){
	for(int a = 0 ; a < listStatistics.size(); a++){
		if(listStatistics.get(a) != null && !"".equals(listStatistics.get(a))){
			statisticsVO1 =  (StatisticsVO)listStatistics.get(a);
			break;
		}
	}
}

HashMap data = new HashMap();
int dayCount = 0;
for(int i=0;i<listStatistics.size();i++){
	statisticsVO = (StatisticsVO)listStatistics.get(i);
	data.put(statisticsVO.getxArea(),statisticsVO.getyCnt());
}

Iterator siteJoinStatIter;
String dataXML = "";

//그래프 높이
int rowHight = 500;

//접속수 최대값 지정
String maxCnt = "100";
siteJoinStatIter = listStatistics.iterator();
while(siteJoinStatIter.hasNext()){
	statisticsVO = (StatisticsVO)siteJoinStatIter.next();
	if(Integer.parseInt(statisticsVO.getyCnt()) < 10000 && Integer.parseInt(statisticsVO.getyCnt()) > 5000 && Integer.parseInt(statisticsVO.getyCnt()) > Integer.parseInt(maxCnt) ){
		maxCnt = "10000";
	}else if(Integer.parseInt(statisticsVO.getyCnt()) < 5000 && Integer.parseInt(statisticsVO.getyCnt()) > 1000 && Integer.parseInt(statisticsVO.getyCnt()) > Integer.parseInt(maxCnt) ){
		maxCnt = "5000";
	}else if(Integer.parseInt(statisticsVO.getyCnt()) < 1000 && Integer.parseInt(statisticsVO.getyCnt()) > 500 && Integer.parseInt(statisticsVO.getyCnt()) > Integer.parseInt(maxCnt) ){
		maxCnt = "1000";
	}else if(Integer.parseInt(statisticsVO.getyCnt()) < 500 && Integer.parseInt(statisticsVO.getyCnt()) > 100 && Integer.parseInt(statisticsVO.getyCnt()) > Integer.parseInt(maxCnt) ){
		maxCnt = "500";
	}
}


if(listStatistics != null){
	StringBuffer xmlStr = new StringBuffer();

	xmlStr.append( "<graph caption='일별 접속수' xAxisName='일'  baseFont='굴림' baseFontSize='11' yAxisName='Count Number' decimalPrecision='0'  yAxisMinValue='0'  yAxisMaxValue='"+maxCnt+"' formatNumberScale='0' showNames='1'   > " );
	if(data.containsKey("01")){
		xmlStr.append( "<set name='01일' value='"+data.get("01")+"' color='CCCCFF' /> " );
	}else{
		xmlStr.append( "<set name='01일' value='0' color='CCCCFF' /> " );

	}
	if(data.containsKey("02")){
		xmlStr.append( "<set name='02일' value='"+data.get("02")+"' color='CCCCFF' /> " );
	}else{
		xmlStr.append( "<set name='02일' value='0' color='CCCCFF' /> " );

	}
	if(data.containsKey("03")){
		xmlStr.append( "<set name='03일' value='"+data.get("03")+"' color='CCCCFF' /> " );
	}else{
		xmlStr.append( "<set name='03일' value='0' color='CCCCFF' /> " );

	}
	if(data.containsKey("04")){
		xmlStr.append( "<set name='04일' value='"+data.get("04")+"' color='CCCCFF' /> " );
	}else{
		xmlStr.append( "<set name='04일' value='0' color='CCCCFF' /> " );

	}
	if(data.containsKey("05")){
		xmlStr.append( "<set name='05일' value='"+data.get("05")+"' color='CCCCFF' /> " );
	}else{
		xmlStr.append( "<set name='05일' value='0' color='CCCCFF' /> " );

	}
	if(data.containsKey("06")){
		xmlStr.append( "<set name='06일' value='"+data.get("06")+"' color='CCCCFF' /> " );
	}else{
		xmlStr.append( "<set name='06일' value='0' color='CCCCFF' /> " );

	}
	if(data.containsKey("07")){
		xmlStr.append( "<set name='07일' value='"+data.get("07")+"' color='CCCCFF' /> " );
	}else{
		xmlStr.append( "<set name='07일' value='0' color='CCCCFF' /> " );

	}
	if(data.containsKey("08")){
		xmlStr.append( "<set name='08일' value='"+data.get("08")+"' color='CCCCFF' /> " );
	}else{
		xmlStr.append( "<set name='08일' value='0' color='CCCCFF' /> " );

	}
	if(data.containsKey("09")){
		xmlStr.append( "<set name='09일' value='"+data.get("09")+"' color='CCCCFF' /> " );
	}else{
		xmlStr.append( "<set name='09일' value='0' color='CCCCFF' /> " );

	}
	if(data.containsKey("10")){
		xmlStr.append( "<set name='10일' value='"+data.get("10")+"' color='CCCCFF' /> " );
	}else{
		xmlStr.append( "<set name='10일' value='0' color='CCCCFF' /> " );

	}
	if(data.containsKey("11")){
		xmlStr.append( "<set name='11일' value='"+data.get("11")+"' color='CCCCFF' /> " );
	}else{
		xmlStr.append( "<set name='11일' value='0' color='CCCCFF' /> " );

	}
	if(data.containsKey("12")){
		xmlStr.append( "<set name='12일' value='"+data.get("12")+"' color='CCCCFF' /> " );
	}else{
		xmlStr.append( "<set name='12일' value='0' color='CCCCFF' /> " );

	}
	if(data.containsKey("13")){
		xmlStr.append( "<set name='13일' value='"+data.get("13")+"' color='CCCCFF' /> " );
	}else{
		xmlStr.append( "<set name='13일' value='0' color='CCCCFF' /> " );

	}
	if(data.containsKey("14")){
		xmlStr.append( "<set name='14일' value='"+data.get("14")+"' color='CCCCFF' /> " );
	}else{
		xmlStr.append( "<set name='14일' value='0' color='CCCCFF' /> " );

	}
	if(data.containsKey("15")){
		xmlStr.append( "<set name='15일' value='"+data.get("15")+"' color='CCCCFF' /> " );
	}else{
		xmlStr.append( "<set name='15일' value='0' color='CCCCFF' /> " );

	}
	if(data.containsKey("16")){
		xmlStr.append( "<set name='16일' value='"+data.get("16")+"' color='CCCCFF' /> " );
	}else{
		xmlStr.append( "<set name='16일' value='0' color='CCCCFF' /> " );

	}
	if(data.containsKey("17")){
		xmlStr.append( "<set name='17일' value='"+data.get("17")+"' color='CCCCFF' /> " );
	}else{
		xmlStr.append( "<set name='17일' value='0' color='CCCCFF' /> " );

	}
	if(data.containsKey("18")){
		xmlStr.append( "<set name='18일' value='"+data.get("18")+"' color='CCCCFF' /> " );
	}else{
		xmlStr.append( "<set name='18일' value='0' color='CCCCFF' /> " );

	}
	if(data.containsKey("19")){
		xmlStr.append( "<set name='19일' value='"+data.get("19")+"' color='CCCCFF' /> " );
	}else{
		xmlStr.append( "<set name='19일' value='0' color='CCCCFF' /> " );

	}
	if(data.containsKey("20")){
		xmlStr.append( "<set name='20일' value='"+data.get("20")+"' color='CCCCFF' /> " );
	}else{
		xmlStr.append( "<set name='20일' value='0' color='CCCCFF' /> " );

	}
	if(data.containsKey("21")){
		xmlStr.append( "<set name='21일' value='"+data.get("21")+"' color='CCCCFF' /> " );
	}else{
		xmlStr.append( "<set name='21일' value='0' color='CCCCFF' /> " );

	}
	if(data.containsKey("22")){
		xmlStr.append( "<set name='22일' value='"+data.get("22")+"' color='CCCCFF' /> " );
	}else{
		xmlStr.append( "<set name='22일' value='0' color='CCCCFF' /> " );

	}
	if(data.containsKey("23")){
		xmlStr.append( "<set name='23일' value='"+data.get("23")+"' color='CCCCFF' /> " );
	}else{
		xmlStr.append( "<set name='23일' value='0' color='CCCCFF' /> " );

	}
	if(data.containsKey("24")){
		xmlStr.append( "<set name='24일' value='"+data.get("24")+"' color='CCCCFF' /> " );
	}else{
		xmlStr.append( "<set name='24일' value='0' color='CCCCFF' /> " );

	}
	if(data.containsKey("25")){
		xmlStr.append( "<set name='25일' value='"+data.get("25")+"' color='CCCCFF' /> " );
	}else{
		xmlStr.append( "<set name='25일' value='0' color='CCCCFF' /> " );

	}
	if(data.containsKey("26")){
		xmlStr.append( "<set name='26일' value='"+data.get("26")+"' color='CCCCFF' /> " );
	}else{
		xmlStr.append( "<set name='26일' value='0' color='CCCCFF' /> " );

	}
	if(data.containsKey("27")){
		xmlStr.append( "<set name='27일' value='"+data.get("27")+"' color='CCCCFF' /> " );
	}else{
		xmlStr.append( "<set name='27일' value='0' color='CCCCFF' /> " );

	}
	if(dayCount > 27 ){
		if(data.containsKey("28")){
			xmlStr.append( "<set name='28일' value='"+data.get("28")+"' color='CCCCFF' /> " );
		}else{
			xmlStr.append( "<set name='28일' value='0' color='CCCCFF' /> " );

		}
	}
	if(dayCount > 28 ){
		if(data.containsKey("29")){
			xmlStr.append( "<set name='29일' value='"+data.get("29")+"' color='CCCCFF' /> " );
		}else{
			xmlStr.append( "<set name='29일' value='0' color='CCCCFF' /> " );

		}
	}
	if(dayCount > 29 ){
		if(data.containsKey("30")){
			xmlStr.append( "<set name='30일' value='"+data.get("30")+"' color='CCCCFF' /> " );
		}else{
			xmlStr.append( "<set name='30일' value='0' color='CCCCFF' /> " );

		}
	}
	if(dayCount > 30 ){
		if(data.containsKey("31")){
			xmlStr.append( "<set name='31일' value='"+data.get("31")+"' color='CCCCFF' /> " );
		}else{
			xmlStr.append( "<set name='31일' value='0' color='CCCCFF' /> " );

		}
	}
	xmlStr.append( "</graph> " );

	dataXML = xmlStr.toString();
}else{
	dataXML = "nothing";
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
<script type="text/javascript" src='/js/wizi/FusionCharts.js'></script>

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

<form name="frmStat" id="frmStat" method="post">
	<input type="hidden" name="searchType" id="searchType" value="D"/>
	
	<ul id="view-tab-1">
		<li class="tab-name-11"><a href="#fn_moveSiteJoin"  onclick="fn_moveSiteJoin('T');">시간대 별</a></li>
		<li class="tab-name-12 on"><a href="#fn_moveSiteJoin">일 별</a></li>
		<li class="tab-name-13"><a href="#fn_moveSiteJoin" onclick="fn_moveSiteJoin('W');">요일 별</a></li>
		<li class="tab-name-14"><a href="#fn_moveSiteJoin" onclick="fn_moveSiteJoin('M');">월 별</a></li>
		<li class="tab-name-15"><a href="#fn_moveSiteJoin" onclick="fn_moveSiteJoin('S');">기간별</a></li>
	</ul>
	
	<c:set var="now" value="<%=new java.util.Date()%>"/>
	<fmt:formatDate var="nowDate" value="${now}" pattern="yyyyMMdd"/>
	<c:set var="maxCnt" value="100"/>
  	<c:if test="${! empty listStatistics}">
		<c:forEach var="siteJoinStatModel" items="${resultList}" varStatus="status">
			<fmt:parseNumber var="ycntNumber" value="${siteJoinStatModel.YCnt}" type="number"/>
			<c:if test="${ycntNumber < 1000 and ycntNumber > 500 and ycntNumber > maxCnt }">
				<c:set var="maxCnt" value="1000"/>
			</c:if>
			<c:if test="${ycntNumber < 500 and ycntNumber > 100 and ycntNumber > maxCnt }">
				<c:set var="maxCnt" value="500"/>
			</c:if>
			<c:if test="${ycntNumber < 100 and ycntNumber > maxCnt }">
				<c:set var="maxCnt" value="1000"/>
			</c:if>
    	</c:forEach>
    </c:if>
	
	<ul class="search-list-1">
		<li>
			<span>조회기간</span>
			년도 : <select name="searchYear" id="searchYear" class="form_03" title="년도를 선택하세요">
					<c:choose>
						<c:when test="${empty param.searchYear}">
							<c:forEach var="yearVal" begin="2018" end="2025" varStatus="status">
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
							<c:forEach var="yearVal" begin="2018" end="2025" varStatus="status">
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
			<a href="#fn_exclDownload" onclick="javascript:fn_exclDownload(); return false" onkeypress="this.onclick;" class="btn">엑셀다운로드</a>					
		</li>
	</ul><!-- E : board-info -->
	
<table border="0" cellpadding="0" cellspacing="0" class="list-1">
  <tr>
  	<td>
			<div id="flash02">
				<%-- 
				<SCRIPT LANGUAGE="javascript">
					var dataXML = "<%=dataXML%>";
					dataXML = dataXML.replace(/'/g, "\'");
					convertflash(this.flash02,'800','<%=rowHight%>','FC_2_3_Column3D','<%=imageRoot%>/charts/FC_2_3_Column3D.swf?chartWidth=800&chartHeight=<%=rowHight%>','&dataXML='+dataXML);
				</SCRIPT> 
				--%>
			</div>
  	</td>
  </tr>
</table>
</form>
<!--리스트 끝 -->
<script language="javascript">
	var dataXML = "<%=dataXML%>";
	var chart1 = new FusionCharts("/swf/charts/FC_2_3_Column3D.swf", "chart1", "800", "<%=rowHight%>");
	chart1.setDataXML(dataXML);
	chart1.render("flash02");
</script>
