<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags" %><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link href="/css/fullcalendar.min.css" rel="stylesheet" />
<link href="/css/fullcalendar.print.min.css" rel="stylesheet" media="print" />
<script src="/js/moment.min.js"></script>
<script src="/js/fullcalendar.min.js"></script> 
<script type="text/javascript">
$(document).ready(function(){
	
		/* 타이틀 */
		$(document).ready(function () {
			$(document).attr("title", "About > Annual Schedule > Monthly schedule : K-LINK");
		});

  	var calender = $('#calendar').fullCalendar({
  		header : {
          left : 'prev title next',
          //center : 'title',
          //right : 'month,agendaWeek,agendaDay,listWeek'
          right : ''
        },
 
        defaultDate : "${today}",
        //navLinks : true, // can click day/week names to navigate views
        editable : true,
        eventLimit : false, // allow "more" link when too many events
        events : [
        <c:forEach items="${courseScheduleList}" var="result" varStatus="status" >            	
            {
            	title : '${result.title }',
              	start : '${result.applyStart }',
              	end : '${result.applyEnd }',
              	courseCd : '${result.courseCd }',
              	<c:if test="${result.todayType eq 'A'}">color : '#B2EBF4'</c:if>
              	<c:if test="${result.todayType eq 'W'}">color : '#B7F0B1'</c:if>
              	<c:if test="${result.todayType eq 'C'}">color : '#BDBDBD'</c:if>				
            }<c:if test="${!status.last }">,</c:if>
        </c:forEach>
        ],
        eventClick : function(calEvent, jsEvent, view) {
       	   var str1 = calEvent.courseCd;
       	   fn_course(str1);
         
        }
	});
   	
  	$(document).on("click", "#calendar .fc-next-button", function(){ //달력 next 버튼 눌렀을때 날짜 구간 다시가져온다
  		var yearStr = $('#calendar').fullCalendar('getView').intervalStart.format("YYYY");
  		var dayStr = $('#calendar').fullCalendar('getView').intervalStart.format("YYYY-MM-DD");
		var reqUrl = "/lu/course/courseSchedule";
		
		if(yearStr != '${todayYear}' ){
			$("#searchToday").val(dayStr);
	  		$("#frmCourse").attr("action", reqUrl);
	  		$("#frmCourse").submit();			
		}
		
  	});
  	
  	$(document).on("click", "#calendar .fc-prev-button", function(){ //달력 prev 버튼 눌렀을때 날짜 구간 다시가져온다
  		var yearStr = $('#calendar').fullCalendar('getView').intervalStart.format("YYYY");//변경된 날짜값 재 정의중.....
  		var dayStr = $('#calendar').fullCalendar('getView').intervalStart.format("YYYY-MM-DD");
		var reqUrl = "/lu/course/courseSchedule";
		
		if(yearStr != '${todayYear}' ){
			$("#searchToday").val(dayStr);
	  		$("#frmCourse").attr("action", reqUrl);
	  		$("#frmCourse").submit();			
		}
  	});
  	

  	function fn_course(seq){ 
  		
  		$("#courseCd").val(seq);
  		
  		if(seq==null||seq==''){
  			return false;
  		}else{
  			var reqUrl = "/lu/course/courseDetail";
  			$("#frmCourse").attr("action", reqUrl);
  			$("#frmCourse").submit();
  		}
  	}
});

/* 조회 */
function fn_search(){
	
	var reqUrl = "/lu/course/courseList";
	$("#frmCourse").attr("action", reqUrl);
	$("#frmCourse").attr("target","_self");
	$("#frmCourse").submit();
}

</script>
<form id="frmCourse" name="frmCourse" method="post"  >
 <input type="hidden" id="pageIndex" name="pageIndex" value="1" />
 <input type="hidden" name="courseCd" id="courseCd" />
 <input type="hidden" name="searchToday" id="searchToday" />
</form>
<div class="select-year">
	<input type="radio" id="list-type" name="lis-cal" title="List" aria-label="List" onclick="javascript:fn_search('1');" />
	<label for="list-type">List</label>
	
	<input type="radio" id="calendar-type" name="lis-cal" title="Calendar" aria-label="Calendar" OnClick="window.location.href='/lu/course/courseSchedule';" checked="checked" />
	<label for="calendar-type">Calendar</label>
</div>
<div id="calendar">
	<div class="calendar"></div>
</div>
<!-- E: calendar -->
	