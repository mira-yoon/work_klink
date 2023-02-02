<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	
	$(document).ready(function () {

		/* 타이틀 */
		$(document).attr("title", "About > Annual Schedule > > Monthly schedule > Details : K-LINK");

	});

	/* 목록 */
	function fn_search() {
		//var reqUrl = "/lu/course/courseList";
		var reqUrl = "/lu/course/courseSchedule";
		$("#frmCourse").attr("action", reqUrl);
		$("#frmCourse").attr("target", "_self");
		$("#frmCourse").submit();
	}

	/* 신청 */
	function fn_apply() {
		var reqUrl = "/lu/apply/goApply";
		$("#frmCourse").attr("action", reqUrl);
		$("#frmCourse").attr("target", "_self");
		$("#frmCourse").submit();
	}
</script>

<form id="frmCourse" name="frmCourse" method="post">
	<input type="hidden" id="pageIndex" name="pageIndex" value="<c:out value='${result.pageIndex}'/>" />
	<input type="hidden" id="courseCd" name="courseCd" value="${result.courseCd}" />
</form>

<div id="applyRead">
	<div class="btn-box">
		<ul>
			<li>
				<c:if test="${result.todayType eq 'A'}">
					<a href="#" class="btn-white" onclick="javascript:fn_apply();">Apply</a>
				</c:if>
				<a href="#" class="btn-blue btn-calendar" onclick="javascript:fn_search();">CALENDAR</a>
			</li>
		</ul>
	</div>

	<div class="apply-read">
		<div class="title">${result.title }<span>ONLINE APPLY</span></div>
		<div class="date">${result.dayStart} ~ ${result.dayEnd} &nbsp;&nbsp;&nbsp;&nbsp;
			<%--  [applicant:${result.applycnt}/recruit : ${result.participant}] --%>
			<div class="situation">
				<c:if test="${result.statusCd eq 'CT01'}">UPCOMING</c:if>
				<c:if test="${result.statusCd eq 'CT02'}">
					<c:if test="${result.todayType eq 'A'}">
						<a href="#apply" onclick="javascript:fn_apply();">APPLY</a>
					</c:if>
					<c:if test="${result.todayType eq 'C'}">
						CLOSE
					</c:if>
					<c:if test="${result.todayType eq 'W'}">
						UPCOMING
					</c:if>
				</c:if>
				<c:if test="${result.statusCd eq 'CT03'}">CLOSE</c:if>
			</div>
		</div>
		<div class="apply-con">
			<div class="contents">
				<h6>ABOUT COURSE</h6>
				<div class="text-box">
					<c:out value="${result.courseText}" escapeXml="false" />
				</div>
			</div>
			<div class="contents">
				<h6>COURSE SCHEDULE</h6>
				<div class="text-box">
					<c:out value="${result.scheduleText}" escapeXml="false" />
				</div>
				<div class="text-box">
					<c:out value="${result.lecturerText}" escapeXml="false" />
				</div>
			</div>
		</div>
	</div>
</div><!-- E : applyRead -->