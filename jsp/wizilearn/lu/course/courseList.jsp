<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags" %><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">

	$(document).ready(function () {

		/* 타이틀 */
		$(document).ready(function () {
			$(document).attr("title", "About > Annual Schedule List : K-LINK");
		});

		var dt = new Date();
		var com_year = dt.getFullYear();
		$("#year").append("<option value=''>year</option>");
		for (var y = com_year; y >= (com_year - 6); y--) {

			if (y == "${courseVO.year}") {
				$("#year").append("<option value='" + y + "' selected>" + y + "</option>");
			} else {
				$("#year").append("<option value='" + y + "'>" + y + "</option>");
			}
		}

		$(".list h6").click(function () {
			$(this).siblings().slideToggle()
		});
	});


	/* 조회 */
	function fn_search() {

		var reqUrl = "/lu/course/courseList";
		$("#frmCourse").attr("action", reqUrl);
		$("#frmCourse").attr("target", "_self");
		$("#frmCourse").submit();
	}
	/* 상세 조회 */
	function fn_detail(seq) {

		$("#courseCd").val(seq);
		var reqUrl = "/lu/course/courseDetail";
		$("#frmCourse").attr("action", reqUrl);
		$("#frmCourse").submit();
	}
	/* 상세 조회 */
	function fn_schedule() {

		var reqUrl = "/lu/course/courseSchedule";
		$("#frmCourse").attr("action", reqUrl);
		$("#frmCourse").submit();
	}


</script>

<div id="ScheduleList">
	<form id="frmCourse" name="frmCourse" method="post">
		<input type="hidden" name="courseCd" id="courseCd" />
		<div class="select-year">
			<label for="year">Select Year</label>
			<select id="year" name="year" class="select-box" onchange="javascript:fn_search();" title="Please choose an option." aria-label="Please choose an option."></select>
			<input type="radio" id="list-type" name="lis-cal" title="List" aria-label="List" checked="checked" />
			<label for="list-type">List</label>
			<input type="radio" id="calendar-type" name="lis-cal" title="Calendar" aria-label="Calendar" onclick="javascript:fn_schedule();" />
			<label for="calendar-type">Calendar</label>
		</div>
	</form>

	<div class="schedule-list">
		<div class="list">
			<h6>APPLY</h6>
			<ul class="condition">
				<li>
					<div class="condition-apply">APPLY</div>
					<c:forEach var="result" items="${resultList }" varStatus="status">
						<c:if test="${result.statusCd eq 'CT02' }">
							<c:if test="${result.todayType eq 'A'}">
								<ul>
									<li><a href="#" onclick="javascript:fn_detail('${result.courseCd}');">Courses :
											<c:out value="${result.title }" /></a></li>
									<li>Application Period : ${result.applyStart} ~ ${result.applyEnd}</li>
									<li>Duration : ${result.dayStart} ~ ${result.dayEnd}</li>
									<li>Participants : ${result.applycnt}/${result.participant}</li>
								</ul>
							</c:if>
						</c:if>
					</c:forEach>
				</li>
			</ul>
		</div>

		<div class="list">
			<h6>UPCOMING</h6>
			<ul class="condition">
				<li>
					<div class="condition-upcoming">UPCOMING</div>
					<c:forEach var="result" items="${resultList }" varStatus="status">
						<c:if test="${result.statusCd eq 'CT01' }">
							<ul>
								<li><a href="#" onclick="javascript:fn_detail('${result.courseCd}');">Courses :
										<c:out value="${result.title }" /></a></li>
								<li>Application Period : ${result.applyStart} ~ ${result.applyEnd}</li>
								<li>Duration : ${result.dayStart} ~ ${result.dayEnd}</li>
								<li>Participants : ${result.applycnt}/${result.participant}</li>
							</ul>
						</c:if>
					</c:forEach>
				</li>
			</ul>
		</div>

		<div class="list">
			<h6>CLOSE</h6>
			<ul class="condition">
				<li>
					<div class="condition-close">CLOSE</div>
					<c:forEach var="result" items="${resultList }" varStatus="status">
						<c:if test="${result.statusCd eq 'CT03' }">
							<ul>
								<li><a href="#" onclick="javascript:fn_detail('${result.courseCd}');">Courses :
										<c:out value="${result.title }" /></a></li>
								<li>Application Period : ${result.applyStart} ~ ${result.applyEnd}</li>
								<li>Duration : ${result.dayStart} ~ ${result.dayEnd}</li>
								<li>Participants : ${result.applycnt}/${result.participant}</li>
							</ul>
						</c:if>
						<c:if test="${result.statusCd eq 'CT02' }">
							<c:if test="${result.todayType ne 'A'}">
								<ul>
									<li><a href="#" onclick="javascript:fn_detail('${result.courseCd}');">Courses :
											<c:out value="${result.title }" /></a></li>
									<li>Application Period : ${result.applyStart} ~ ${result.applyEnd}</li>
									<li>Duration : ${result.dayStart} ~ ${result.dayEnd}</li>
									<li>Participants : ${result.applycnt}/${result.participant}</li>
								</ul>
							</c:if>
						</c:if>
					</c:forEach>
				</li>
			</ul>
		</div>
	</div>
</div>
<!-- E: ScheduleList -->
